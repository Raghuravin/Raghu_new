import type { ApiResponse, EmailPayload, Task, TaskSuggestion } from "@task-capture/shared";

export type { ApiResponse, EmailPayload, Task, TaskSuggestion };

export interface CapturedEmail extends EmailPayload {
  /** Gmail-specific id parsed from the URL hash. Used as TaskSource.externalId. */
  gmailMessageId: string | null;
  snippet: string;
}

export type ExtensionSettings = {
  apiBaseUrl: string;
};

export const DEFAULT_API_BASE_URL = "http://localhost:4000";

/* -- chrome.runtime message contracts ----------------------------------- */

export type RuntimeRequest =
  | { kind: "extract"; payload: EmailPayload }
  | { kind: "save"; payload: SaveTaskPayload }
  | { kind: "getSettings" }
  | { kind: "setSettings"; settings: ExtensionSettings };

export type RuntimeResponse<T = unknown> =
  | { ok: true; data: T }
  | { ok: false; error: { code: string; message: string; details?: unknown } };

export interface SaveTaskPayload {
  title: string;
  description: string | null;
  priority: TaskSuggestion["priority"];
  dueAt: string | null;
  remindAt: string | null;
  source: {
    provider: "gmail";
    externalId?: string;
    subject?: string;
    sender?: string;
    sourceUrl?: string;
    receivedAt?: string;
    snippet?: string;
  };
}

export interface SaveTaskResult {
  task: Task;
}
