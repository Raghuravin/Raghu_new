export type TaskStatus = "pending" | "in_progress" | "done" | "snoozed" | "archived";

export type TaskPriority = "low" | "medium" | "high" | "urgent";

export interface Task {
  id: string;
  userId: string;
  emailId: string | null;
  title: string;
  description: string | null;
  status: TaskStatus;
  priority: TaskPriority;
  dueAt: string | null;
  remindAt: string | null;
  completedAt: string | null;
  createdAt: string;
  updatedAt: string;
}

export interface Reminder {
  id: string;
  taskId: string;
  remindAt: string;
  sent: boolean;
  sentAt: string | null;
  createdAt: string;
}
