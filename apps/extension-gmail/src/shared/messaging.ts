import type { RuntimeRequest, RuntimeResponse } from "./types.js";

/**
 * Promise wrapper around `chrome.runtime.sendMessage`. Resolves with the
 * structured response from the background service worker; never rejects.
 */
export function sendRuntimeMessage<T>(req: RuntimeRequest): Promise<RuntimeResponse<T>> {
  return new Promise((resolve) => {
    try {
      chrome.runtime.sendMessage(req, (res?: RuntimeResponse<T>) => {
        const lastError = chrome.runtime.lastError;
        if (lastError) {
          resolve({
            ok: false,
            error: { code: "runtime_error", message: lastError.message ?? "Unknown error" },
          });
          return;
        }
        if (!res) {
          resolve({
            ok: false,
            error: { code: "no_response", message: "No response from background worker" },
          });
          return;
        }
        resolve(res);
      });
    } catch (err) {
      resolve({
        ok: false,
        error: {
          code: "send_failed",
          message: err instanceof Error ? err.message : String(err),
        },
      });
    }
  });
}
