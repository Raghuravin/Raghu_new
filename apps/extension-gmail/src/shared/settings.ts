import { DEFAULT_API_BASE_URL, type ExtensionSettings } from "./types.js";

const KEY = "task-capture:settings";

export async function getSettings(): Promise<ExtensionSettings> {
  const stored = await chrome.storage.local.get(KEY);
  const raw = stored[KEY] as Partial<ExtensionSettings> | undefined;
  return {
    apiBaseUrl:
      raw?.apiBaseUrl && typeof raw.apiBaseUrl === "string" ? raw.apiBaseUrl : DEFAULT_API_BASE_URL,
  };
}

export async function setSettings(next: ExtensionSettings): Promise<void> {
  await chrome.storage.local.set({ [KEY]: next });
}
