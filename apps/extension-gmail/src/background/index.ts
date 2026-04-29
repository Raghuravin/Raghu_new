import { getSettings, setSettings } from "../shared/settings.js";
import type {
  ApiResponse,
  EmailPayload,
  RuntimeRequest,
  RuntimeResponse,
  SaveTaskPayload,
  SaveTaskResult,
  Task,
  TaskSuggestion,
} from "../shared/types.js";

chrome.runtime.onInstalled.addListener(() => {
  console.log("[task-capture] background service worker installed");
});

/**
 * Background message router. Centralizes API calls so the content script
 * never sees CORS / network failures directly and so settings stay in one
 * place.
 */
chrome.runtime.onMessage.addListener(
  (request: RuntimeRequest, _sender, sendResponse: (res: RuntimeResponse) => void) => {
    handleRequest(request)
      .then(sendResponse)
      .catch((err: unknown) => {
        sendResponse({
          ok: false,
          error: {
            code: "background_error",
            message: err instanceof Error ? err.message : String(err),
          },
        });
      });
    return true; // keep the channel open for async sendResponse
  },
);

async function handleRequest(req: RuntimeRequest): Promise<RuntimeResponse> {
  switch (req.kind) {
    case "extract":
      return extract(req.payload);
    case "save":
      return save(req.payload);
    case "getSettings":
      return { ok: true, data: await getSettings() };
    case "setSettings":
      await setSettings(req.settings);
      return { ok: true, data: req.settings };
  }
}

async function extract(payload: EmailPayload): Promise<RuntimeResponse<TaskSuggestion>> {
  const { apiBaseUrl } = await getSettings();
  const res = await fetchJson<TaskSuggestion>(`${apiBaseUrl}/api/v1/extract-task`, {
    method: "POST",
    body: JSON.stringify(payload),
  });
  return res;
}

async function save(payload: SaveTaskPayload): Promise<RuntimeResponse<SaveTaskResult>> {
  const { apiBaseUrl } = await getSettings();
  const body = {
    title: payload.title,
    description: payload.description,
    priority: payload.priority,
    dueAt: payload.dueAt,
    remindAt: payload.remindAt,
    source: payload.source,
  };
  const res = await fetchJson<{ task: Task }>(`${apiBaseUrl}/api/v1/tasks`, {
    method: "POST",
    body: JSON.stringify(body),
  });
  if (!res.ok) return res;
  return { ok: true, data: { task: res.data.task } };
}

async function fetchJson<T>(url: string, init: RequestInit): Promise<RuntimeResponse<T>> {
  let response: Response;
  try {
    response = await fetch(url, {
      ...init,
      headers: { "content-type": "application/json", ...(init.headers ?? {}) },
    });
  } catch (err) {
    return {
      ok: false,
      error: {
        code: "network_error",
        message: err instanceof Error ? err.message : "Network error",
      },
    };
  }

  let parsed: ApiResponse<T> | null = null;
  try {
    parsed = (await response.json()) as ApiResponse<T>;
  } catch {
    return {
      ok: false,
      error: {
        code: "invalid_response",
        message: `API returned ${response.status} with non-JSON body`,
      },
    };
  }

  if (!response.ok) {
    if (parsed && !parsed.ok) {
      return { ok: false, error: parsed.error };
    }
    return {
      ok: false,
      error: { code: "http_error", message: `API responded with ${response.status}` },
    };
  }

  if (!parsed || !parsed.ok) {
    return parsed && !parsed.ok
      ? { ok: false, error: parsed.error }
      : { ok: false, error: { code: "invalid_response", message: "Malformed success response" } };
  }
  return { ok: true, data: parsed.data };
}
