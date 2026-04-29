import { randomUUID } from "node:crypto";

import type { Reminder, Task, TaskSource } from "@task-capture/shared";

import type { CreateTaskInput, CreatedTask, ListTasksOptions } from "./tasks.service.js";

/**
 * Per-user in-memory task store used when Supabase is not configured.
 * Keeps the dashboard and extension functional end-to-end during local
 * development without requiring Docker / a Postgres instance.
 *
 * Process-local only — discarded on restart.
 */
export class InMemoryTasksStore {
  private readonly tasks = new Map<string, Task[]>();
  private readonly sources = new Map<string, TaskSource[]>();
  private readonly reminders = new Map<string, Reminder[]>();
  private seeded = new Set<string>();

  list(opts: ListTasksOptions): Task[] {
    this.ensureSeeded(opts.userId);
    let items = (this.tasks.get(opts.userId) ?? []).slice();
    if (opts.status) {
      const allowed = Array.isArray(opts.status) ? new Set(opts.status) : new Set([opts.status]);
      items = items.filter((t) => allowed.has(t.status));
    }
    items.sort((a, b) => {
      const av = a.dueAt ? new Date(a.dueAt).getTime() : Number.POSITIVE_INFINITY;
      const bv = b.dueAt ? new Date(b.dueAt).getTime() : Number.POSITIVE_INFINITY;
      return av - bv;
    });
    if (opts.limit !== undefined) items = items.slice(0, opts.limit);
    return items;
  }

  create(userId: string, input: CreateTaskInput): CreatedTask {
    this.ensureSeeded(userId);
    const now = new Date().toISOString();
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
    this.push(this.tasks, userId, task);

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
    if (source) this.push(this.sources, userId, source);

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
    if (reminder) this.push(this.reminders, userId, reminder);

    return { task, source, reminder };
  }

  private push<T>(map: Map<string, T[]>, userId: string, item: T): void {
    const arr = map.get(userId) ?? [];
    arr.push(item);
    map.set(userId, arr);
  }

  private ensureSeeded(userId: string): void {
    if (this.seeded.has(userId)) return;
    this.seeded.add(userId);
    for (const seed of buildSeedTasks(userId)) {
      this.push(this.tasks, userId, seed);
    }
  }
}

function buildSeedTasks(userId: string): Task[] {
  const now = new Date();
  const isoDaysFromNow = (days: number, hour = 17): string => {
    const d = new Date(now);
    d.setDate(d.getDate() + days);
    d.setHours(hour, 0, 0, 0);
    return d.toISOString();
  };
  const isoMinutesAgo = (minutes: number): string =>
    new Date(now.getTime() - minutes * 60 * 1000).toISOString();

  const seed = (
    id: number,
    fields: {
      title: string;
      description: string;
      status: Task["status"];
      priority: Task["priority"];
      dueAt: string | null;
      completedAt?: string | null;
      createdMinutesAgo?: number;
    },
  ): Task => {
    const created = isoMinutesAgo(fields.createdMinutesAgo ?? 60);
    return {
      id: `00000000-0000-4000-8000-${id.toString().padStart(12, "0")}`,
      userId,
      title: fields.title,
      description: fields.description,
      status: fields.status,
      priority: fields.priority,
      dueAt: fields.dueAt,
      completedAt: fields.completedAt ?? null,
      createdAt: created,
      updatedAt: created,
    };
  };

  return [
    seed(1, {
      title: "Approve Q3 budget",
      description: "From Alex: review and approve the attached Q3 budget by EOD.",
      status: "pending",
      priority: "urgent",
      dueAt: isoDaysFromNow(0, 23),
      createdMinutesAgo: 90,
    }),
    seed(2, {
      title: "Reply to vendor contract",
      description: "From legal@vendor.com: send signed NDA back to legal counsel.",
      status: "in_progress",
      priority: "high",
      dueAt: isoDaysFromNow(0, 20),
      createdMinutesAgo: 240,
    }),
    seed(3, {
      title: "Submit expense report",
      description: "From finance@company.com: submit March expense report.",
      status: "pending",
      priority: "medium",
      dueAt: isoDaysFromNow(2, 17),
    }),
    seed(4, {
      title: "Schedule design review",
      description: "From mia@design.com: pick a slot next week for the v2 design review.",
      status: "pending",
      priority: "medium",
      dueAt: isoDaysFromNow(5, 17),
    }),
    seed(5, {
      title: "Renew domain certificate",
      description: "From ops@company.com: SSL certificate for taskcapture.app expires soon.",
      status: "pending",
      priority: "high",
      dueAt: isoDaysFromNow(7, 17),
    }),
    seed(6, {
      title: "Read product newsletter",
      description: "From newsletters@stripe.com: weekly product update.",
      status: "pending",
      priority: "low",
      dueAt: null,
    }),
    seed(7, {
      title: "Confirm dentist appointment",
      description: "From appointments@clinic.com: confirm Tuesday 9am visit.",
      status: "done",
      priority: "medium",
      dueAt: isoDaysFromNow(-1, 9),
      completedAt: isoDaysFromNow(-1, 10),
    }),
    seed(8, {
      title: "Send onboarding doc",
      description: "From hr@company.com: forward onboarding doc to new hire.",
      status: "done",
      priority: "high",
      dueAt: isoDaysFromNow(-2, 17),
      completedAt: isoDaysFromNow(-2, 16),
    }),
    seed(9, {
      title: "Pay AWS invoice",
      description: "From billing@aws.com: April invoice ready.",
      status: "done",
      priority: "medium",
      dueAt: isoDaysFromNow(-3, 12),
      completedAt: isoDaysFromNow(-3, 13),
    }),
  ];
}
