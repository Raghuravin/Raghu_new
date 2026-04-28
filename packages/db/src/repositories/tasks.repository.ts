import type { Task, TaskPriority, TaskStatus } from "@task-capture/shared";

import type { DbClient } from "../client.js";
import { rowToTask } from "../mappers.js";

import { DbError } from "./errors.js";

export interface ListTasksOptions {
  userId: string;
  status?: TaskStatus | TaskStatus[];
  /** Inclusive lower bound (ISO timestamp) for `due_at`. */
  dueAfter?: string;
  /** Inclusive upper bound (ISO timestamp) for `due_at`. */
  dueBefore?: string;
  limit?: number;
}

export interface CreateTaskInput {
  userId: string;
  title: string;
  description?: string | null;
  status?: TaskStatus;
  priority?: TaskPriority;
  dueAt?: string | null;
}

export interface UpdateTaskInput {
  title?: string;
  description?: string | null;
  status?: TaskStatus;
  priority?: TaskPriority;
  dueAt?: string | null;
  completedAt?: string | null;
}

export class TasksRepository {
  constructor(private readonly db: DbClient) {}

  async list(opts: ListTasksOptions): Promise<Task[]> {
    let query = this.db
      .from("tasks")
      .select("*")
      .eq("user_id", opts.userId)
      .order("due_at", { ascending: true, nullsFirst: false });

    if (opts.status) {
      query = Array.isArray(opts.status)
        ? query.in("status", opts.status)
        : query.eq("status", opts.status);
    }
    if (opts.dueAfter) query = query.gte("due_at", opts.dueAfter);
    if (opts.dueBefore) query = query.lte("due_at", opts.dueBefore);
    if (opts.limit !== undefined) query = query.limit(opts.limit);

    const { data, error } = await query;
    if (error) throw wrap("tasks.list", error);
    return (data ?? []).map(rowToTask);
  }

  async getById(userId: string, id: string): Promise<Task | null> {
    const { data, error } = await this.db
      .from("tasks")
      .select("*")
      .eq("user_id", userId)
      .eq("id", id)
      .maybeSingle();
    if (error) throw wrap("tasks.getById", error);
    return data ? rowToTask(data) : null;
  }

  async create(input: CreateTaskInput): Promise<Task> {
    const { data, error } = await this.db
      .from("tasks")
      .insert({
        user_id: input.userId,
        title: input.title,
        description: input.description ?? null,
        status: input.status ?? "pending",
        priority: input.priority ?? "medium",
        due_at: input.dueAt ?? null,
      })
      .select("*")
      .single();
    if (error || !data) throw wrap("tasks.create", error);
    return rowToTask(data);
  }

  async update(userId: string, id: string, patch: UpdateTaskInput): Promise<Task> {
    const { data, error } = await this.db
      .from("tasks")
      .update({
        ...(patch.title !== undefined ? { title: patch.title } : {}),
        ...(patch.description !== undefined ? { description: patch.description } : {}),
        ...(patch.status !== undefined ? { status: patch.status } : {}),
        ...(patch.priority !== undefined ? { priority: patch.priority } : {}),
        ...(patch.dueAt !== undefined ? { due_at: patch.dueAt } : {}),
        ...(patch.completedAt !== undefined ? { completed_at: patch.completedAt } : {}),
      })
      .eq("user_id", userId)
      .eq("id", id)
      .select("*")
      .single();
    if (error || !data) throw wrap("tasks.update", error);
    return rowToTask(data);
  }

  async remove(userId: string, id: string): Promise<void> {
    const { error } = await this.db.from("tasks").delete().eq("user_id", userId).eq("id", id);
    if (error) throw wrap("tasks.remove", error);
  }
}

function wrap(operation: string, error: unknown): DbError {
  const e = error as { message?: string; code?: string; details?: unknown } | null;
  return new DbError(`${operation} failed: ${e?.message ?? "unknown error"}`, {
    code: e?.code,
    details: e?.details,
    cause: error,
  });
}
