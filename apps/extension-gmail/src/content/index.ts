import { type ModalFormValues, TaskModal } from "../modal/modal.js";
import { sendRuntimeMessage } from "../shared/messaging.js";
import type {
  CapturedEmail,
  RuntimeResponse,
  SaveTaskResult,
  TaskSuggestion,
} from "../shared/types.js";

import { ensureCreateTaskButton, showButton } from "./button.js";
import { captureCurrentEmail } from "./gmail-capture.js";

/**
 * Content-script entrypoint. Watches the Gmail SPA for navigation, keeps
 * the "Create task" affordance present whenever a conversation is open,
 * and orchestrates extract -> edit -> save when the user clicks it.
 */

console.log("[task-capture] content script loaded");

let activeModal: TaskModal | null = null;

ensureCreateTaskButton(() => {
  const email = captureCurrentEmail();
  if (!email) {
    flashToast("Open an email first");
    return;
  }
  void openModalFor(email);
});

const observer = new MutationObserver(() => {
  refreshButtonVisibility();
});
observer.observe(document.body, { childList: true, subtree: true });
window.addEventListener("hashchange", refreshButtonVisibility);
refreshButtonVisibility();

function refreshButtonVisibility(): void {
  const inThread = /#(?:inbox|label|search|sent|drafts|all|imp|starred)\/[A-Za-z0-9]+/.test(
    window.location.hash,
  );
  showButton(inThread || isThreadOpen());
}

function isThreadOpen(): boolean {
  return Boolean(document.querySelector("h2.hP"));
}

async function openModalFor(email: CapturedEmail): Promise<void> {
  if (activeModal) {
    activeModal.destroy();
    activeModal = null;
  }

  const callbacks = {
    onClose: (): void => {
      modal.destroy();
      activeModal = null;
    },
    onSave: (form: ModalFormValues): Promise<void> => save(modal, email, form),
    onRetryExtract: (): void => {
      modal.setState({ kind: "loading", email });
      void runExtraction(modal, email);
    },
  };
  const modal: TaskModal = new TaskModal({ kind: "loading", email }, callbacks);
  activeModal = modal;

  await runExtraction(modal, email);
}

async function runExtraction(modal: TaskModal, email: CapturedEmail): Promise<void> {
  const res = await sendRuntimeMessage<TaskSuggestion>({
    kind: "extract",
    payload: {
      subject: email.subject,
      sender: email.sender,
      body: email.body,
      timestamp: email.timestamp,
      sourceUrl: email.sourceUrl,
    },
  });
  if (!res.ok) {
    modal.setState({ kind: "error", email, message: res.error.message });
    return;
  }
  modal.setState({ kind: "ready", email, suggestion: res.data });
}

async function save(modal: TaskModal, email: CapturedEmail, form: ModalFormValues): Promise<void> {
  modal.setBusy(true);
  modal.setStatus("info", "Saving…");

  const res: RuntimeResponse<SaveTaskResult> = await sendRuntimeMessage({
    kind: "save",
    payload: {
      title: form.title.trim(),
      description: form.description.trim().length > 0 ? form.description.trim() : null,
      priority: form.priority,
      dueAt: form.dueAt,
      remindAt: form.remindAt,
      source: {
        provider: "gmail",
        externalId: email.gmailMessageId ?? undefined,
        subject: email.subject,
        sender: email.sender,
        sourceUrl: email.sourceUrl,
        receivedAt: email.timestamp,
        snippet: email.snippet,
      },
    },
  });

  modal.setBusy(false);
  if (!res.ok) {
    modal.setStatus("error", res.error.message);
    return;
  }
  modal.setStatus("success", "Saved.");
  setTimeout(() => {
    modal.destroy();
    activeModal = null;
  }, 800);
}

function flashToast(text: string): void {
  const t = document.createElement("div");
  t.className = "tc-toast";
  t.textContent = text;
  document.body.appendChild(t);
  setTimeout(() => t.remove(), 2_500);
}
