import type { TaskSource, TaskSourceProvider } from "@task-capture/shared";

import type { DbClient } from "../client.js";
import type { Json } from "../database.types.js";
import { rowToTaskSource } from "../mappers.js";

import { DbError } from "./errors.js";

export interface CreateTaskSourceInput {
  taskId: string;
  userId: string;
  provider: TaskSourceProvider;
  externalId?: string | null;
  subject?: string | null;
  sender?: string | null;
  sourceUrl?: string | null;
  receivedAt?: string | null;
  snippet?: string | null;
  metadata?: Record<string, unknown>;
}

export interface UpdateTaskSourceInput {
  subject?: string | null;
  sender?: string | null;
  sourceUrl?: string | null;
  receivedAt?: string | null;
  snippet?: string | null;
  metadata?: Record<string, unknown>;
}

export class TaskSourcesRepository {
  constructor(private readonly db: DbClient) {}

  async listByTask(userId: string, taskId: string): Promise<TaskSource[]> {
    const { data, error } = await this.db
      .from("task_sources")
      .select("*")
      .eq("user_id", userId)
      .eq("task_id", taskId)
      .order("created_at", { ascending: true });
    if (error) throw wrap("task_sources.listByTask", error);
    return (data ?? []).map(rowToTaskSource);
  }

  async findByExternal(
    userId: string,
    provider: TaskSourceProvider,
    externalId: string,
  ): Promise<TaskSource | null> {
    const { data, error } = await this.db
      .from("task_sources")
      .select("*")
      .eq("user_id", userId)
      .eq("provider", provider)
      .eq("external_id", externalId)
      .maybeSingle();
    if (error) throw wrap("task_sources.findByExternal", error);
    return data ? rowToTaskSource(data) : null;
  }

  async create(input: CreateTaskSourceInput): Promise<TaskSource> {
    const { data, error } = await this.db
      .from("task_sources")
      .insert({
        task_id: input.taskId,
        user_id: input.userId,
        provider: input.provider,
        external_id: input.externalId ?? null,
        subject: input.subject ?? null,
        sender: input.sender ?? null,
        source_url: input.sourceUrl ?? null,
        received_at: input.receivedAt ?? null,
        snippet: input.snippet ?? null,
        metadata: (input.metadata ?? {}) as Json,
      })
      .select("*")
      .single();
    if (error || !data) throw wrap("task_sources.create", error);
    return rowToTaskSource(data);
  }

  async update(userId: string, id: string, patch: UpdateTaskSourceInput): Promise<TaskSource> {
    const { data, error } = await this.db
      .from("task_sources")
      .update({
        ...(patch.subject !== undefined ? { subject: patch.subject } : {}),
        ...(patch.sender !== undefined ? { sender: patch.sender } : {}),
        ...(patch.sourceUrl !== undefined ? { source_url: patch.sourceUrl } : {}),
        ...(patch.receivedAt !== undefined ? { received_at: patch.receivedAt } : {}),
        ...(patch.snippet !== undefined ? { snippet: patch.snippet } : {}),
        ...(patch.metadata !== undefined ? { metadata: patch.metadata as Json } : {}),
      })
      .eq("user_id", userId)
      .eq("id", id)
      .select("*")
      .single();
    if (error || !data) throw wrap("task_sources.update", error);
    return rowToTaskSource(data);
  }

  async remove(userId: string, id: string): Promise<void> {
    const { error } = await this.db
      .from("task_sources")
      .delete()
      .eq("user_id", userId)
      .eq("id", id);
    if (error) throw wrap("task_sources.remove", error);
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
