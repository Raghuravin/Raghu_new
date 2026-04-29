import type { Task } from "@task-capture/shared";

import { ApiClientError, apiFetch } from "./api";

export type TaskBucket = "today" | "upcoming" | "done";

export interface TasksResult {
  tasks: Task[];
  /** Set when the API call failed; UI surfaces this inline. */
  error: { code: string; message: string } | null;
}

/**
 * Server-side fetch of all tasks for the current user. Auth is currently
 * handled by the API's dev-mode (no Bearer token sent). When the
 * dashboard learns to authenticate users we'll forward the Supabase
 * session JWT here.
 */
async function fetchAllTasks(): Promise<TasksResult> {
  try {
    const tasks = await apiFetch<Task[]>("/api/v1/tasks");
    return { tasks, error: null };
  } catch (err) {
    if (err instanceof ApiClientError) {
      return { tasks: [], error: { code: err.code, message: err.message } };
    }
    return {
      tasks: [],
      error: {
        code: "network_error",
        message: err instanceof Error ? err.message : "Could not reach the API",
      },
    };
  }
}

export async function getTasks(bucket: TaskBucket, now: Date = new Date()): Promise<TasksResult> {
  const all = await fetchAllTasks();
  if (all.error) return all;
  return { tasks: filterBucket(all.tasks, bucket, now), error: null };
}

export async function getCounts(now: Date = new Date()): Promise<Record<TaskBucket, number>> {
  const all = await fetchAllTasks();
  if (all.error) return { today: 0, upcoming: 0, done: 0 };
  return {
    today: filterBucket(all.tasks, "today", now).length,
    upcoming: filterBucket(all.tasks, "upcoming", now).length,
    done: filterBucket(all.tasks, "done", now).length,
  };
}

function filterBucket(tasks: Task[], bucket: TaskBucket, now: Date): Task[] {
  const start = startOfDay(now);
  const end = endOfDay(now);

  switch (bucket) {
    case "today":
      return tasks
        .filter(
          (t) =>
            t.status !== "done" &&
            t.status !== "archived" &&
            t.dueAt !== null &&
            new Date(t.dueAt) >= start &&
            new Date(t.dueAt) <= end,
        )
        .sort(byDueAtAsc);
    case "upcoming":
      return tasks
        .filter(
          (t) =>
            t.status !== "done" &&
            t.status !== "archived" &&
            (t.dueAt === null || new Date(t.dueAt) > end),
        )
        .sort(byDueAtAscNullsLast);
    case "done":
      return tasks
        .filter((t) => t.status === "done")
        .sort((a, b) => new Date(b.updatedAt).getTime() - new Date(a.updatedAt).getTime());
  }
}

function startOfDay(now: Date): Date {
  const d = new Date(now);
  d.setHours(0, 0, 0, 0);
  return d;
}

function endOfDay(now: Date): Date {
  const d = new Date(now);
  d.setHours(23, 59, 59, 999);
  return d;
}

function byDueAtAsc(a: Task, b: Task): number {
  return new Date(a.dueAt ?? 0).getTime() - new Date(b.dueAt ?? 0).getTime();
}

function byDueAtAscNullsLast(a: Task, b: Task): number {
  if (a.dueAt === null && b.dueAt === null) return 0;
  if (a.dueAt === null) return 1;
  if (b.dueAt === null) return -1;
  return new Date(a.dueAt).getTime() - new Date(b.dueAt).getTime();
}
