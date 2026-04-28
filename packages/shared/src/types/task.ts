export type TaskStatus = "pending" | "in_progress" | "done" | "snoozed" | "archived";

export type TaskPriority = "low" | "medium" | "high" | "urgent";

export type TaskSourceProvider = "gmail" | "manual" | "other";

export type ReminderStatus = "scheduled" | "sent" | "cancelled" | "failed";

/**
 * Domain Task. The persisted shape lives in the `tasks` table and is mapped
 * via `@task-capture/db` repositories. Sources and reminders are separate
 * resources (see `TaskSource` and `Reminder`).
 */
export interface Task {
  id: string;
  userId: string;
  title: string;
  description: string | null;
  status: TaskStatus;
  priority: TaskPriority;
  dueAt: string | null;
  completedAt: string | null;
  createdAt: string;
  updatedAt: string;
}

/**
 * Reference to the external artifact a task was captured from (today,
 * always a Gmail email; designed to extend to other providers later).
 */
export interface TaskSource {
  id: string;
  taskId: string;
  userId: string;
  provider: TaskSourceProvider;
  externalId: string | null;
  subject: string | null;
  sender: string | null;
  sourceUrl: string | null;
  receivedAt: string | null;
  snippet: string | null;
  metadata: Record<string, unknown>;
  createdAt: string;
  updatedAt: string;
}

export interface Reminder {
  id: string;
  taskId: string;
  userId: string;
  remindAt: string;
  status: ReminderStatus;
  sentAt: string | null;
  channel: string | null;
  metadata: Record<string, unknown>;
  createdAt: string;
  updatedAt: string;
}
