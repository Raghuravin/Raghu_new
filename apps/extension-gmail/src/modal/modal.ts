import type { CapturedEmail, TaskSuggestion } from "../shared/types.js";

const HOST_ID = "tc-modal-host";

export type ModalState =
  | { kind: "loading"; email: CapturedEmail }
  | { kind: "ready"; email: CapturedEmail; suggestion: TaskSuggestion }
  | { kind: "error"; email: CapturedEmail; message: string };

export interface ModalCallbacks {
  onSave: (form: ModalFormValues) => void | Promise<void>;
  onClose: () => void;
  onRetryExtract?: () => void;
}

export interface ModalFormValues {
  title: string;
  description: string;
  priority: TaskSuggestion["priority"];
  dueAt: string | null;
  remindAt: string | null;
}

export class TaskModal {
  private host: HTMLDivElement;
  private state: ModalState;
  private form: ModalFormValues;
  private busy = false;
  private statusMessage: { kind: "info" | "error" | "success"; text: string } | null = null;

  constructor(
    initial: ModalState,
    private callbacks: ModalCallbacks,
  ) {
    this.state = initial;
    this.form = deriveForm(initial);
    this.host = ensureHost();
    this.render();
  }

  setState(next: ModalState): void {
    this.state = next;
    if (next.kind === "ready") {
      this.form = deriveForm(next);
    }
    this.render();
  }

  setBusy(busy: boolean): void {
    this.busy = busy;
    this.render();
  }

  setStatus(kind: "info" | "error" | "success", text: string): void {
    this.statusMessage = { kind, text };
    this.render();
  }

  destroy(): void {
    this.host.remove();
  }

  private render(): void {
    const overlay = document.createElement("div");
    overlay.className = "tc-overlay";
    overlay.addEventListener("click", (e) => {
      if (e.target === overlay) this.callbacks.onClose();
    });

    const dialog = document.createElement("div");
    dialog.className = "tc-dialog";
    dialog.setAttribute("role", "dialog");
    dialog.setAttribute("aria-modal", "true");
    dialog.setAttribute("aria-labelledby", "tc-dialog-title");

    dialog.appendChild(this.renderHeader());
    dialog.appendChild(this.renderBody());
    dialog.appendChild(this.renderFooter());

    overlay.appendChild(dialog);

    this.host.replaceChildren(overlay);
  }

  private renderHeader(): HTMLElement {
    const header = document.createElement("div");
    header.className = "tc-header";

    const title = document.createElement("h2");
    title.id = "tc-dialog-title";
    title.className = "tc-title";
    title.textContent = "Create task";

    const close = document.createElement("button");
    close.type = "button";
    close.className = "tc-icon-btn";
    close.setAttribute("aria-label", "Close");
    close.textContent = "×";
    close.addEventListener("click", () => this.callbacks.onClose());

    header.append(title, close);
    return header;
  }

  private renderBody(): HTMLElement {
    const body = document.createElement("div");
    body.className = "tc-body";

    if (this.state.kind === "loading") {
      const p = document.createElement("p");
      p.className = "tc-muted";
      p.textContent = "Extracting task…";
      body.appendChild(p);
      body.appendChild(this.renderEmailPreview(this.state.email));
      return body;
    }

    if (this.state.kind === "error") {
      const p = document.createElement("p");
      p.className = "tc-error-text";
      p.textContent = `Couldn't extract: ${this.state.message}`;
      body.appendChild(p);
      if (this.callbacks.onRetryExtract) {
        const retry = document.createElement("button");
        retry.type = "button";
        retry.className = "tc-btn tc-btn-secondary";
        retry.textContent = "Retry";
        retry.addEventListener("click", () => this.callbacks.onRetryExtract?.());
        body.appendChild(retry);
      }
      body.appendChild(this.renderEmailPreview(this.state.email));
      return body;
    }

    body.appendChild(this.renderForm(this.state));
    body.appendChild(this.renderEmailPreview(this.state.email, this.state.suggestion.confidence));
    return body;
  }

  private renderForm(state: { suggestion: TaskSuggestion }): HTMLElement {
    void state;
    const form = document.createElement("div");
    form.className = "tc-form";

    form.appendChild(
      labeled(
        "Title",
        textInput(this.form.title, (v) => {
          this.form.title = v;
        }),
      ),
    );

    form.appendChild(
      labeled(
        "Summary",
        textArea(this.form.description, (v) => {
          this.form.description = v;
        }),
      ),
    );

    const row = document.createElement("div");
    row.className = "tc-row";

    row.appendChild(
      labeled(
        "Priority",
        prioritySelect(this.form.priority, (v) => {
          this.form.priority = v;
        }),
      ),
    );

    row.appendChild(
      labeled(
        "Due",
        dateTimeInput(this.form.dueAt, (v) => {
          this.form.dueAt = v;
        }),
      ),
    );

    row.appendChild(
      labeled(
        "Reminder",
        dateTimeInput(this.form.remindAt, (v) => {
          this.form.remindAt = v;
        }),
      ),
    );

    form.appendChild(row);

    return form;
  }

  private renderEmailPreview(email: CapturedEmail, confidence?: number): HTMLElement {
    const wrap = document.createElement("div");
    wrap.className = "tc-preview";

    const meta = document.createElement("div");
    meta.className = "tc-preview-meta";
    meta.textContent = `${email.subject} · ${email.sender}`;
    wrap.appendChild(meta);

    if (typeof confidence === "number") {
      const conf = document.createElement("div");
      conf.className = "tc-preview-conf";
      conf.textContent = `Extractor confidence: ${(confidence * 100).toFixed(0)}%`;
      wrap.appendChild(conf);
    }
    return wrap;
  }

  private renderFooter(): HTMLElement {
    const footer = document.createElement("div");
    footer.className = "tc-footer";

    if (this.statusMessage) {
      const s = document.createElement("span");
      s.className = `tc-status tc-status-${this.statusMessage.kind}`;
      s.textContent = this.statusMessage.text;
      footer.appendChild(s);
    } else {
      footer.appendChild(document.createElement("span"));
    }

    const actions = document.createElement("div");
    actions.className = "tc-actions";

    const cancel = document.createElement("button");
    cancel.type = "button";
    cancel.className = "tc-btn tc-btn-secondary";
    cancel.textContent = "Cancel";
    cancel.disabled = this.busy;
    cancel.addEventListener("click", () => this.callbacks.onClose());

    const save = document.createElement("button");
    save.type = "button";
    save.className = "tc-btn tc-btn-primary";
    save.textContent = this.busy ? "Saving…" : "Save task";
    save.disabled = this.busy || this.state.kind !== "ready" || this.form.title.trim().length === 0;
    save.addEventListener("click", () => {
      void this.callbacks.onSave({ ...this.form });
    });

    actions.append(cancel, save);
    footer.appendChild(actions);
    return footer;
  }
}

function ensureHost(): HTMLDivElement {
  const existing = document.getElementById(HOST_ID);
  if (existing instanceof HTMLDivElement) return existing;
  const host = document.createElement("div");
  host.id = HOST_ID;
  document.body.appendChild(host);
  return host;
}

function deriveForm(state: ModalState): ModalFormValues {
  if (state.kind === "ready") {
    return {
      title: state.suggestion.taskTitle,
      description: state.suggestion.summary,
      priority: state.suggestion.priority,
      dueAt: toLocalInputValue(state.suggestion.dueDate),
      remindAt: toLocalInputValue(state.suggestion.suggestedReminder),
    };
  }
  return {
    title: state.email.subject,
    description: state.email.snippet,
    priority: "medium",
    dueAt: null,
    remindAt: null,
  };
}

/* -- form helpers ------------------------------------------------------- */

function labeled(labelText: string, input: HTMLElement): HTMLElement {
  const wrap = document.createElement("label");
  wrap.className = "tc-field";
  const span = document.createElement("span");
  span.className = "tc-label";
  span.textContent = labelText;
  wrap.append(span, input);
  return wrap;
}

function textInput(value: string, onChange: (v: string) => void): HTMLInputElement {
  const el = document.createElement("input");
  el.type = "text";
  el.className = "tc-input";
  el.value = value;
  el.addEventListener("input", () => onChange(el.value));
  return el;
}

function textArea(value: string, onChange: (v: string) => void): HTMLTextAreaElement {
  const el = document.createElement("textarea");
  el.className = "tc-input tc-textarea";
  el.rows = 3;
  el.value = value;
  el.addEventListener("input", () => onChange(el.value));
  return el;
}

function dateTimeInput(
  value: string | null,
  onChange: (v: string | null) => void,
): HTMLInputElement {
  const el = document.createElement("input");
  el.type = "datetime-local";
  el.className = "tc-input";
  el.value = value ?? "";
  el.addEventListener("change", () => {
    const v = el.value.trim();
    onChange(v.length > 0 ? new Date(v).toISOString() : null);
  });
  return el;
}

function prioritySelect(
  value: TaskSuggestion["priority"],
  onChange: (v: TaskSuggestion["priority"]) => void,
): HTMLSelectElement {
  const el = document.createElement("select");
  el.className = "tc-input";
  for (const opt of ["low", "medium", "high", "urgent"] as const) {
    const o = document.createElement("option");
    o.value = opt;
    o.textContent = opt[0]!.toUpperCase() + opt.slice(1);
    if (opt === value) o.selected = true;
    el.appendChild(o);
  }
  el.addEventListener("change", () => onChange(el.value as TaskSuggestion["priority"]));
  return el;
}

function toLocalInputValue(iso: string | null): string | null {
  if (!iso) return null;
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return null;
  const pad = (n: number) => n.toString().padStart(2, "0");
  return (
    `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}` +
    `T${pad(d.getHours())}:${pad(d.getMinutes())}`
  );
}
