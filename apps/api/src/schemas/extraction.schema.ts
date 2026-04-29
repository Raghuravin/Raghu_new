import type { EmailPayload, TaskSuggestion } from "@task-capture/shared";
import { z } from "zod";

export const TaskPrioritySchema = z.enum(["low", "medium", "high", "urgent"]);

/**
 * POST /extract-task request body.
 * Mirrors `EmailPayload` from @task-capture/shared.
 */
export const EmailPayloadSchema = z.object({
  subject: z.string().min(1, "subject is required").max(998),
  sender: z.string().min(1, "sender is required").max(320),
  body: z.string().min(1, "body is required").max(200_000),
  timestamp: z
    .string()
    .min(1, "timestamp is required")
    .refine((value) => !Number.isNaN(Date.parse(value)), {
      message: "timestamp must be a valid ISO 8601 date-time",
    }),
  sourceUrl: z.string().url("sourceUrl must be a valid URL"),
}) satisfies z.ZodType<EmailPayload>;

/**
 * POST /extract-task response payload.
 * Mirrors `TaskSuggestion` from @task-capture/shared.
 */
export const TaskSuggestionSchema = z.object({
  taskTitle: z.string().min(1).max(200),
  summary: z.string().min(1).max(2_000),
  dueDate: z.string().datetime().nullable(),
  priority: TaskPrioritySchema,
  suggestedReminder: z.string().datetime().nullable(),
  confidence: z.number().min(0).max(1),
}) satisfies z.ZodType<TaskSuggestion>;

export type EmailPayloadInput = z.infer<typeof EmailPayloadSchema>;
export type TaskSuggestionOutput = z.infer<typeof TaskSuggestionSchema>;
