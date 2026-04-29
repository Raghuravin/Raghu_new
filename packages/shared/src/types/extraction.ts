import type { TaskPriority } from "./task.js";

/**
 * Input payload sent by the Gmail extension (or any caller) to ask the API
 * to convert an email into a structured task suggestion.
 */
export interface EmailPayload {
  subject: string;
  sender: string;
  body: string;
  timestamp: string;
  sourceUrl: string;
}

/**
 * Structured task suggestion returned by the extraction endpoint.
 *
 * - `dueDate` and `suggestedReminder` are ISO 8601 timestamps, or `null`
 *   when the extractor could not infer a date.
 * - `confidence` is in `[0, 1]`. Mock extractor outputs are clamped to a
 *   conservative range; LLM extractor outputs are sanitized to the same
 *   bounds. Callers can use it to gate auto-acceptance vs. human review.
 */
export interface TaskSuggestion {
  taskTitle: string;
  summary: string;
  dueDate: string | null;
  priority: TaskPriority;
  suggestedReminder: string | null;
  confidence: number;
}
