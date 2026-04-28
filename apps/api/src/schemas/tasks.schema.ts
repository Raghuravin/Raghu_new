import type { TaskSourceProvider } from "@task-capture/shared";
import { z } from "zod";

export const TaskPrioritySchema = z.enum(["low", "medium", "high", "urgent"]);
export const TaskStatusSchema = z.enum(["pending", "in_progress", "done", "snoozed", "archived"]);
export const TaskSourceProviderSchema = z.enum([
  "gmail",
  "manual",
  "other",
]) satisfies z.ZodType<TaskSourceProvider>;

export const TaskSourceInputSchema = z.object({
  provider: TaskSourceProviderSchema,
  externalId: z.string().min(1).max(512).optional(),
  subject: z.string().max(998).optional(),
  sender: z.string().max(320).optional(),
  sourceUrl: z.string().url().optional(),
  receivedAt: z
    .string()
    .refine((v) => !Number.isNaN(Date.parse(v)), {
      message: "receivedAt must be a valid ISO 8601 date-time",
    })
    .optional(),
  snippet: z.string().max(2_000).optional(),
});

/**
 * POST /api/v1/tasks request body. Captures both the task itself and an
 * optional source so the extension can save in a single round-trip.
 */
export const CreateTaskBodySchema = z.object({
  title: z.string().min(1).max(200),
  description: z.string().max(2_000).nullable().optional(),
  status: TaskStatusSchema.optional(),
  priority: TaskPrioritySchema.optional(),
  dueAt: z
    .string()
    .refine((v) => !Number.isNaN(Date.parse(v)), {
      message: "dueAt must be a valid ISO 8601 date-time",
    })
    .nullable()
    .optional(),
  remindAt: z
    .string()
    .refine((v) => !Number.isNaN(Date.parse(v)), {
      message: "remindAt must be a valid ISO 8601 date-time",
    })
    .nullable()
    .optional(),
  source: TaskSourceInputSchema.optional(),
});

export type CreateTaskBody = z.infer<typeof CreateTaskBodySchema>;
export type TaskSourceInput = z.infer<typeof TaskSourceInputSchema>;
