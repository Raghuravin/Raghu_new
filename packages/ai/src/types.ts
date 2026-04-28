import type { TaskPriority } from "@task-capture/shared";

/**
 * Legacy shape kept for backwards compatibility with the lower-level
 * `extractTasksFromEmail` helper. The product's main extraction contract
 * is `EmailPayload` -> `TaskSuggestion` (see @task-capture/shared) which is
 * what `mockExtractTask` and `llmExtractTask` use directly.
 */
export interface ExtractedTask {
  title: string;
  description: string | null;
  priority: TaskPriority;
  dueAt: string | null;
  remindAt: string | null;
}

export interface ExtractionInput {
  subject: string;
  from: string;
  bodyText: string;
  receivedAt: string;
}

export interface AiConfig {
  /** OpenAI API key. Required for the LLM extractor. */
  apiKey: string;
  /** Model id. Must support structured (JSON-schema) outputs. */
  model: string;
  /** Optional override of the API base URL (proxy / Azure / local). */
  baseURL?: string;
  /** Per-request timeout in milliseconds. Defaults to 20s. */
  timeoutMs?: number;
}
