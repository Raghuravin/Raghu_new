import type { Task, TaskPriority, TaskStatus } from "@task-capture/shared";

/**
 * Dashboard view-model: a domain `Task` plus the next reminder time we want
 * to render on the card. The real version will join the `tasks` and
 * `reminders` tables; the mock keeps it inline.
 */
export interface MockTask extends Task {
  nextReminderAt: string | null;
}

const NOW = new Date();

function isoDaysFromNow(days: number, hour = 17): string {
  const d = new Date(NOW);
  d.setDate(d.getDate() + days);
  d.setHours(hour, 0, 0, 0);
  return d.toISOString();
}

function isoMinutesAgo(minutes: number): string {
  return new Date(NOW.getTime() - minutes * 60 * 1000).toISOString();
}

function task(
  id: string,
  partial: {
    title: string;
    description: string;
    priority: TaskPriority;
    status: TaskStatus;
    dueAt?: string | null;
    nextReminderAt?: string | null;
    completedAt?: string | null;
    createdMinutesAgo?: number;
  },
): MockTask {
  const created = isoMinutesAgo(partial.createdMinutesAgo ?? 60);
  return {
    id,
    userId: "user_demo",
    title: partial.title,
    description: partial.description,
    status: partial.status,
    priority: partial.priority,
    dueAt: partial.dueAt ?? null,
    completedAt: partial.completedAt ?? null,
    createdAt: created,
    updatedAt: isoMinutesAgo(Math.max((partial.createdMinutesAgo ?? 60) - 5, 0)),
    nextReminderAt: partial.nextReminderAt ?? null,
  };
}

export const MOCK_TASKS: MockTask[] = [
  task("t_001", {
    title: "Approve Q3 budget",
    description: "From Alex: review and approve the attached Q3 budget by EOD.",
    priority: "urgent",
    status: "pending",
    dueAt: isoDaysFromNow(0, 23),
    nextReminderAt: isoDaysFromNow(0, 18),
    createdMinutesAgo: 90,
  }),
  task("t_002", {
    title: "Reply to vendor contract",
    description: "From legal@vendor.com: send signed NDA back to legal counsel.",
    priority: "high",
    status: "in_progress",
    dueAt: isoDaysFromNow(0, 20),
    nextReminderAt: isoDaysFromNow(0, 16),
    createdMinutesAgo: 240,
  }),
  task("t_003", {
    title: "Submit expense report",
    description: "From finance@company.com: submit March expense report.",
    priority: "medium",
    status: "pending",
    dueAt: isoDaysFromNow(2, 17),
    nextReminderAt: isoDaysFromNow(1, 17),
    createdMinutesAgo: 60 * 18,
  }),
  task("t_004", {
    title: "Schedule design review",
    description: "From mia@design.com: pick a slot next week for the v2 design review.",
    priority: "medium",
    status: "pending",
    dueAt: isoDaysFromNow(5, 17),
    nextReminderAt: isoDaysFromNow(4, 17),
    createdMinutesAgo: 60 * 24,
  }),
  task("t_005", {
    title: "Renew domain certificate",
    description: "From ops@company.com: SSL certificate for taskcapture.app expires soon.",
    priority: "high",
    status: "pending",
    dueAt: isoDaysFromNow(7, 17),
    nextReminderAt: isoDaysFromNow(6, 17),
    createdMinutesAgo: 60 * 36,
  }),
  task("t_006", {
    title: "Read product newsletter",
    description: "From newsletters@stripe.com: weekly product update.",
    priority: "low",
    status: "pending",
    dueAt: null,
    nextReminderAt: null,
    createdMinutesAgo: 60 * 30,
  }),
  task("t_007", {
    title: "Confirm dentist appointment",
    description: "From appointments@clinic.com: confirm Tuesday 9am visit.",
    priority: "medium",
    status: "done",
    dueAt: isoDaysFromNow(-1, 9),
    nextReminderAt: isoDaysFromNow(-1, 8),
    completedAt: isoDaysFromNow(-1, 10),
    createdMinutesAgo: 60 * 60,
  }),
  task("t_008", {
    title: "Send onboarding doc",
    description: "From hr@company.com: forward onboarding doc to new hire.",
    priority: "high",
    status: "done",
    dueAt: isoDaysFromNow(-2, 17),
    nextReminderAt: isoDaysFromNow(-2, 12),
    completedAt: isoDaysFromNow(-2, 16),
    createdMinutesAgo: 60 * 72,
  }),
  task("t_009", {
    title: "Pay AWS invoice",
    description: "From billing@aws.com: April invoice ready.",
    priority: "medium",
    status: "done",
    dueAt: isoDaysFromNow(-3, 12),
    nextReminderAt: isoDaysFromNow(-3, 10),
    completedAt: isoDaysFromNow(-3, 13),
    createdMinutesAgo: 60 * 96,
  }),
];
