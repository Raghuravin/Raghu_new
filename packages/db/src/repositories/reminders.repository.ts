import type { Reminder, ReminderStatus } from "@task-capture/shared";

import type { DbClient } from "../client.js";
import type { Json } from "../database.types.js";
import { rowToReminder } from "../mappers.js";

import { DbError } from "./errors.js";

export interface ListRemindersOptions {
  userId: string;
  taskId?: string;
  status?: ReminderStatus | ReminderStatus[];
  /** Inclusive lower bound (ISO timestamp) for `remind_at`. */
  remindAfter?: string;
  /** Inclusive upper bound (ISO timestamp) for `remind_at`. */
  remindBefore?: string;
  limit?: number;
}

export interface CreateReminderInput {
  taskId: string;
  userId: string;
  remindAt: string;
  status?: ReminderStatus;
  channel?: string | null;
  metadata?: Record<string, unknown>;
}

export interface UpdateReminderInput {
  remindAt?: string;
  status?: ReminderStatus;
  sentAt?: string | null;
  channel?: string | null;
  metadata?: Record<string, unknown>;
}

export class RemindersRepository {
  constructor(private readonly db: DbClient) {}

  async list(opts: ListRemindersOptions): Promise<Reminder[]> {
    let query = this.db
      .from("reminders")
      .select("*")
      .eq("user_id", opts.userId)
      .order("remind_at", { ascending: true });

    if (opts.taskId) query = query.eq("task_id", opts.taskId);
    if (opts.status) {
      query = Array.isArray(opts.status)
        ? query.in("status", opts.status)
        : query.eq("status", opts.status);
    }
    if (opts.remindAfter) query = query.gte("remind_at", opts.remindAfter);
    if (opts.remindBefore) query = query.lte("remind_at", opts.remindBefore);
    if (opts.limit !== undefined) query = query.limit(opts.limit);

    const { data, error } = await query;
    if (error) throw wrap("reminders.list", error);
    return (data ?? []).map(rowToReminder);
  }

  /**
   * Returns reminders that should fire now or earlier and have not yet been
   * sent. Intended for a background worker.
   */
  async listDue(now: string, limit = 100): Promise<Reminder[]> {
    const { data, error } = await this.db
      .from("reminders")
      .select("*")
      .eq("status", "scheduled")
      .lte("remind_at", now)
      .order("remind_at", { ascending: true })
      .limit(limit);
    if (error) throw wrap("reminders.listDue", error);
    return (data ?? []).map(rowToReminder);
  }

  async create(input: CreateReminderInput): Promise<Reminder> {
    const { data, error } = await this.db
      .from("reminders")
      .insert({
        task_id: input.taskId,
        user_id: input.userId,
        remind_at: input.remindAt,
        status: input.status ?? "scheduled",
        channel: input.channel ?? null,
        metadata: (input.metadata ?? {}) as Json,
      })
      .select("*")
      .single();
    if (error || !data) throw wrap("reminders.create", error);
    return rowToReminder(data);
  }

  async update(userId: string, id: string, patch: UpdateReminderInput): Promise<Reminder> {
    const { data, error } = await this.db
      .from("reminders")
      .update({
        ...(patch.remindAt !== undefined ? { remind_at: patch.remindAt } : {}),
        ...(patch.status !== undefined ? { status: patch.status } : {}),
        ...(patch.sentAt !== undefined ? { sent_at: patch.sentAt } : {}),
        ...(patch.channel !== undefined ? { channel: patch.channel } : {}),
        ...(patch.metadata !== undefined ? { metadata: patch.metadata as Json } : {}),
      })
      .eq("user_id", userId)
      .eq("id", id)
      .select("*")
      .single();
    if (error || !data) throw wrap("reminders.update", error);
    return rowToReminder(data);
  }

  async markSent(
    userId: string,
    id: string,
    sentAt: string = new Date().toISOString(),
  ): Promise<Reminder> {
    return this.update(userId, id, { status: "sent", sentAt });
  }

  async remove(userId: string, id: string): Promise<void> {
    const { error } = await this.db.from("reminders").delete().eq("user_id", userId).eq("id", id);
    if (error) throw wrap("reminders.remove", error);
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
