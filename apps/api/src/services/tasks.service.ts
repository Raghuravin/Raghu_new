import { randomUUID } from "node:crypto";

import type { Reminder, Task, TaskSource } from "@task-capture/shared";
import type { FastifyBaseLogger } from "fastify";

import type { DbClient } from "../lib/supabase.js";

export interface TasksServiceDeps {
  supabase: DbClient | null;
  logger?: FastifyBaseLogger;
}

export interface CreateTaskInput {
  title: string;
  description?: string | null;
  status?: Task["status"];
  priority?: Task["priority"];
  dueAt?: string | null;
  remindAt?: string | null;
  source?: {
    provider: TaskSource["provider"];
    externalId?: string;
    subject?: string;
    sender?: string;
    sourceUrl?: string;
    receivedAt?: string;
    snippet?: string;
  };
}

export interface CreatedTask {
  task: Task;
  source: TaskSource | null;
  reminder: Reminder | null;
}

const PLACEHOLDER_USER_ID = "00000000-0000-0000-0000-000000000000";

/**
 * Tasks service. Persistence is intentionally stubbed at this stage — auth
 * and the user-scoped Supabase context are not yet wired in. `create`
 * accepts and validates the same shape the production version will use,
 * returns a fully-formed `Task` (+ optional source / reminder), and logs
 * what would have been written so the extension and dashboard can be
 * developed end-to-end against a real-shaped response.
 */
export class TasksService {
  private readonly supabase: DbClient | null;
  private readonly logger: FastifyBaseLogger | undefined;

  constructor(deps: TasksServiceDeps) {
    this.supabase = deps.supabase;
    this.logger = deps.logger;
  }

  async list(): Promise<Task[]> {
    return [];
  }

  async create(input: CreateTaskInput): Promise<CreatedTask> {
    const now = new Date().toISOString();
    const userId = PLACEHOLDER_USER_ID;
    const taskId = randomUUID();

    const task: Task = {
      id: taskId,
      userId,
      title: input.title,
      description: input.description ?? null,
      status: input.status ?? "pending",
      priority: input.priority ?? "medium",
      dueAt: input.dueAt ?? null,
      completedAt: null,
      createdAt: now,
      updatedAt: now,
    };

    const source: TaskSource | null = input.source
      ? {
          id: randomUUID(),
          taskId,
          userId,
          provider: input.source.provider,
          externalId: input.source.externalId ?? null,
          subject: input.source.subject ?? null,
          sender: input.source.sender ?? null,
          sourceUrl: input.source.sourceUrl ?? null,
          receivedAt: input.source.receivedAt ?? null,
          snippet: input.source.snippet ?? null,
          metadata: {},
          createdAt: now,
          updatedAt: now,
        }
      : null;

    const reminder: Reminder | null = input.remindAt
      ? {
          id: randomUUID(),
          taskId,
          userId,
          remindAt: input.remindAt,
          status: "scheduled",
          sentAt: null,
          channel: null,
          metadata: {},
          createdAt: now,
          updatedAt: now,
        }
      : null;

    if (this.supabase) {
      // Persistence path will be wired here once auth + RLS context land.
      this.logger?.info(
        { taskId, hasSource: source !== null, hasReminder: reminder !== null },
        "tasks.create: Supabase configured, persistence pending auth integration",
      );
    } else {
      this.logger?.info(
        { taskId, hasSource: source !== null, hasReminder: reminder !== null },
        "tasks.create: persisted in-memory only (Supabase not configured)",
      );
    }

    return { task, source, reminder };
  }
}
