import type { Reminder, Task, TaskSource } from "@task-capture/shared";

import type { ReminderRow, TaskRow, TaskSourceRow } from "./database.types.js";

/**
 * Row -> Domain mappers. Repositories return domain shapes so callers
 * (apps/api services, etc.) never depend on snake_case row types.
 */

export function rowToTask(row: TaskRow): Task {
  return {
    id: row.id,
    userId: row.user_id,
    title: row.title,
    description: row.description,
    status: row.status,
    priority: row.priority,
    dueAt: row.due_at,
    completedAt: row.completed_at,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

export function rowToTaskSource(row: TaskSourceRow): TaskSource {
  return {
    id: row.id,
    taskId: row.task_id,
    userId: row.user_id,
    provider: row.provider,
    externalId: row.external_id,
    subject: row.subject,
    sender: row.sender,
    sourceUrl: row.source_url,
    receivedAt: row.received_at,
    snippet: row.snippet,
    metadata: toRecord(row.metadata),
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

export function rowToReminder(row: ReminderRow): Reminder {
  return {
    id: row.id,
    taskId: row.task_id,
    userId: row.user_id,
    remindAt: row.remind_at,
    status: row.status,
    sentAt: row.sent_at,
    channel: row.channel,
    metadata: toRecord(row.metadata),
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function toRecord(value: unknown): Record<string, unknown> {
  if (value && typeof value === "object" && !Array.isArray(value)) {
    return value as Record<string, unknown>;
  }
  return {};
}
