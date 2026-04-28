import type { TaskPriority } from "@task-capture/shared";

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
  apiKey: string;
  model: string;
}
