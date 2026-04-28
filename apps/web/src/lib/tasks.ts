import type { Task } from "@task-capture/shared";

import { MOCK_TASKS } from "./mock-tasks";

export type TaskBucket = "today" | "upcoming" | "done";

function startOfToday(now = new Date()): Date {
  const d = new Date(now);
  d.setHours(0, 0, 0, 0);
  return d;
}

function endOfToday(now = new Date()): Date {
  const d = new Date(now);
  d.setHours(23, 59, 59, 999);
  return d;
}

export function getTasks(bucket: TaskBucket, now: Date = new Date()): Task[] {
  const start = startOfToday(now);
  const end = endOfToday(now);

  switch (bucket) {
    case "today":
      return MOCK_TASKS.filter(
        (t) =>
          t.status !== "done" &&
          t.status !== "archived" &&
          t.dueAt !== null &&
          new Date(t.dueAt) >= start &&
          new Date(t.dueAt) <= end,
      ).sort(byDueAtAsc);

    case "upcoming":
      return MOCK_TASKS.filter(
        (t) =>
          t.status !== "done" &&
          t.status !== "archived" &&
          (t.dueAt === null || new Date(t.dueAt) > end),
      ).sort(byDueAtAscNullsLast);

    case "done":
      return MOCK_TASKS.filter((t) => t.status === "done").sort(byCompletedAtDesc);
  }
}

export function getCounts(now: Date = new Date()): Record<TaskBucket, number> {
  return {
    today: getTasks("today", now).length,
    upcoming: getTasks("upcoming", now).length,
    done: getTasks("done", now).length,
  };
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

function byCompletedAtDesc(a: Task, b: Task): number {
  return new Date(b.completedAt ?? 0).getTime() - new Date(a.completedAt ?? 0).getTime();
}
