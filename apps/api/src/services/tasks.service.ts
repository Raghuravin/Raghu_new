import {
  RemindersRepository,
  TaskSourcesRepository,
  TasksRepository,
  type CreateTaskInput as RepoCreateTaskInput,
} from "@task-capture/db";
import type { Reminder, Task, TaskSource } from "@task-capture/shared";
import type { FastifyBaseLogger } from "fastify";

import type { DbClient } from "../lib/supabase.js";

import { InMemoryTasksStore } from "./tasks.store.js";

export interface TasksServiceDeps {
  supabase: DbClient | null;
  logger?: FastifyBaseLogger;
}

export interface ListTasksOptions {
  userId: string;
  status?: Task["status"] | Task["status"][];
  limit?: number;
}

export interface CreateTaskInput {
  title: string;
  description?: string | null;
  status?: Task["status"];
  priority?: Task["priority"];
  dueAt?: string | null;
  /** When set, a reminder row will be created alongside the task. */
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

/**
 * Tasks service.
 *
 * - When a Supabase client is configured, persists tasks / sources /
 *   reminders via the typed repositories from `@task-capture/db`.
 * - Otherwise falls back to a per-user in-memory store seeded with
 *   demo data so the dashboard and extension are usable without a DB.
 *
 * The caller is always identified by `userId`. Authentication is
 * enforced at the route layer via `app.requireAuth`.
 */
export class TasksService {
  private readonly logger: FastifyBaseLogger | undefined;
  private readonly memory: InMemoryTasksStore;

  // Repositories are lazy: they only get instantiated when supabase is set.
  private readonly tasksRepo: TasksRepository | null;
  private readonly sourcesRepo: TaskSourcesRepository | null;
  private readonly remindersRepo: RemindersRepository | null;

  constructor(deps: TasksServiceDeps) {
    this.logger = deps.logger;
    this.memory = new InMemoryTasksStore();
    this.tasksRepo = deps.supabase ? new TasksRepository(deps.supabase) : null;
    this.sourcesRepo = deps.supabase ? new TaskSourcesRepository(deps.supabase) : null;
    this.remindersRepo = deps.supabase ? new RemindersRepository(deps.supabase) : null;
  }

  async list(opts: ListTasksOptions): Promise<Task[]> {
    if (this.tasksRepo) {
      return this.tasksRepo.list({
        userId: opts.userId,
        status: opts.status,
        limit: opts.limit,
      });
    }
    return this.memory.list(opts);
  }

  async create(userId: string, input: CreateTaskInput): Promise<CreatedTask> {
    if (!this.tasksRepo || !this.sourcesRepo || !this.remindersRepo) {
      const created = this.memory.create(userId, input);
      this.logger?.info(
        { taskId: created.task.id, hasSource: !!created.source, hasReminder: !!created.reminder },
        "tasks.create: persisted in-memory (Supabase not configured)",
      );
      return created;
    }

    const repoInput: RepoCreateTaskInput = {
      userId,
      title: input.title,
      description: input.description ?? null,
      status: input.status ?? "pending",
      priority: input.priority ?? "medium",
      dueAt: input.dueAt ?? null,
    };
    const task = await this.tasksRepo.create(repoInput);

    let source: TaskSource | null = null;
    if (input.source) {
      source = await this.sourcesRepo.create({
        taskId: task.id,
        userId,
        provider: input.source.provider,
        externalId: input.source.externalId ?? null,
        subject: input.source.subject ?? null,
        sender: input.source.sender ?? null,
        sourceUrl: input.source.sourceUrl ?? null,
        receivedAt: input.source.receivedAt ?? null,
        snippet: input.source.snippet ?? null,
      });
    }

    let reminder: Reminder | null = null;
    if (input.remindAt) {
      reminder = await this.remindersRepo.create({
        taskId: task.id,
        userId,
        remindAt: input.remindAt,
      });
    }

    this.logger?.info(
      { taskId: task.id, hasSource: source !== null, hasReminder: reminder !== null },
      "tasks.create: persisted to Supabase",
    );

    return { task, source, reminder };
  }
}
