import { sendRuntimeMessage } from "../shared/messaging.js";
import type { ExtensionSettings } from "../shared/types.js";

const apiUrl = document.getElementById("api-url") as HTMLInputElement;
const saveBtn = document.getElementById("save") as HTMLButtonElement;
const status = document.getElementById("status") as HTMLParagraphElement;

async function init(): Promise<void> {
  const res = await sendRuntimeMessage<ExtensionSettings>({ kind: "getSettings" });
  if (res.ok) {
    apiUrl.value = res.data.apiBaseUrl;
  }
}

saveBtn.addEventListener("click", async () => {
  const url = apiUrl.value.trim().replace(/\/+$/, "");
  if (!url) {
    setStatus("error", "API URL is required.");
    return;
  }
  try {
    new URL(url);
  } catch {
    setStatus("error", "Enter a valid URL.");
    return;
  }
  saveBtn.disabled = true;
  const res = await sendRuntimeMessage({
    kind: "setSettings",
    settings: { apiBaseUrl: url },
  });
  saveBtn.disabled = false;
  if (res.ok) {
    setStatus("ok", "Saved.");
  } else {
    setStatus("error", res.error.message);
  }
});

function setStatus(kind: "ok" | "error", text: string): void {
  status.textContent = text;
  status.className = `status status-${kind}`;
  if (kind === "ok") {
    setTimeout(() => {
      status.textContent = "";
    }, 1_500);
  }
}

void init();
