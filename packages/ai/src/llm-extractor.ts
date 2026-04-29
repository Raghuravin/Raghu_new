import type { EmailPayload, TaskSuggestion } from "@task-capture/shared";
import OpenAI from "openai";
import { z } from "zod";

import { mockExtractTask } from "./mock-extractor.js";
import { EXTRACTION_SYSTEM_PROMPT } from "./prompts.js";
import type { AiConfig } from "./types.js";

/**
 * Deterministic JSON schema sent to the LLM. `additionalProperties: false`
 * and `strict: true` (set by OpenAI's structured-outputs implementation
 * when the function is given a schema with all keys required) constrain
 * the model to exactly these fields.
 */
const TASK_SUGGESTION_JSON_SCHEMA = {
  type: "object",
  additionalProperties: false,
  required: ["taskTitle", "summary", "dueDate", "priority", "suggestedReminder", "confidence"],
  properties: {
    taskTitle: {
      type: "string",
      description: "Short imperative phrase describing the action.",
    },
    summary: {
      type: "string",
      description: "One-sentence summary of the email body.",
    },
    dueDate: {
      type: ["string", "null"],
      description: "ISO 8601 UTC timestamp for the due date, or null.",
    },
    priority: {
      type: "string",
      enum: ["low", "medium", "high", "urgent"],
    },
    suggestedReminder: {
      type: ["string", "null"],
      description: "ISO 8601 UTC timestamp for the reminder, or null.",
    },
    confidence: {
      type: "number",
      description: "Confidence in [0, 1] that the email is actionable.",
    },
  },
} as const;

const RawSuggestionSchema = z.object({
  taskTitle: z.string(),
  summary: z.string(),
  dueDate: z.string().nullable(),
  priority: z.enum(["low", "medium", "high", "urgent"]),
  suggestedReminder: z.string().nullable(),
  confidence: z.number(),
});

type RawSuggestion = z.infer<typeof RawSuggestionSchema>;

const DEFAULT_TIMEOUT_MS = 20_000;

const MAX_TITLE_CHARS = 100;
const MAX_SUMMARY_CHARS = 240;

/**
 * LLM-backed extractor. Calls OpenAI with a deterministic JSON schema so
 * the response shape is guaranteed, then sanitizes / clamps the result and
 * applies safe fallback defaults for missing or malformed fields.
 *
 * On any failure (network error, API error, schema validation failure)
 * the deterministic mock extractor is returned so callers always get a
 * usable `TaskSuggestion`. The fallback's confidence stays low (0.4) so
 * downstream code can tell the difference.
 */
export async function llmExtractTask(
  payload: EmailPayload,
  config: AiConfig,
): Promise<TaskSuggestion> {
  if (!config.apiKey) {
    return mockExtractTask(payload);
  }

  const client = new OpenAI({
    apiKey: config.apiKey,
    baseURL: config.baseURL,
    timeout: config.timeoutMs ?? DEFAULT_TIMEOUT_MS,
    maxRetries: 2,
  });

  let raw: RawSuggestion;
  try {
    const completion = await client.chat.completions.create({
      model: config.model,
      temperature: 0,
      messages: [
        { role: "system", content: EXTRACTION_SYSTEM_PROMPT },
        { role: "user", content: buildUserPrompt(payload) },
      ],
      response_format: {
        type: "json_schema",
        json_schema: {
          name: "task_suggestion",
          strict: true,
          schema: TASK_SUGGESTION_JSON_SCHEMA,
        },
      },
    });

    const content = completion.choices[0]?.message?.content;
    if (!content) {
      return mockExtractTask(payload);
    }

    const parsed = RawSuggestionSchema.safeParse(JSON.parse(content));
    if (!parsed.success) {
      return mockExtractTask(payload);
    }
    raw = parsed.data;
  } catch {
    return mockExtractTask(payload);
  }

  return sanitize(raw, payload);
}

function buildUserPrompt(payload: EmailPayload): string {
  return [
    "Email to convert into a task:",
    `- subject: ${payload.subject}`,
    `- sender: ${payload.sender}`,
    `- timestamp: ${payload.timestamp}`,
    `- sourceUrl: ${payload.sourceUrl}`,
    "- body:",
    payload.body,
  ].join("\n");
}

/**
 * Coerce the raw LLM output into a safe, well-formed `TaskSuggestion`.
 * Anything obviously bad (bad ISO date, dueDate before the email timestamp,
 * reminder after due date, confidence outside [0, 1], empty title, etc.)
 * is repaired or replaced with the deterministic-mock fallback for that
 * field.
 */
function sanitize(raw: RawSuggestion, payload: EmailPayload): TaskSuggestion {
  const fallback = mockExtractTask(payload);
  const receivedAt = parseIso(payload.timestamp) ?? new Date();

  const taskTitle = clampNonEmpty(raw.taskTitle, MAX_TITLE_CHARS) ?? fallback.taskTitle;
  const summary = clampNonEmpty(raw.summary, MAX_SUMMARY_CHARS) ?? fallback.summary;
  const priority = raw.priority;

  const parsedDue = raw.dueDate ? parseIso(raw.dueDate) : null;
  const dueDate = parsedDue && parsedDue.getTime() >= receivedAt.getTime() ? parsedDue : null;

  let reminder: Date | null = raw.suggestedReminder ? parseIso(raw.suggestedReminder) : null;
  if (reminder) {
    if (reminder.getTime() < receivedAt.getTime()) reminder = null;
    if (dueDate && reminder && reminder.getTime() > dueDate.getTime()) reminder = null;
  }
  if (!reminder && dueDate) {
    reminder = deriveReminder(dueDate, receivedAt, priority);
  }

  const confidence = clampConfidence(raw.confidence);

  return {
    taskTitle,
    summary,
    dueDate: dueDate ? dueDate.toISOString() : null,
    priority,
    suggestedReminder: reminder ? reminder.toISOString() : null,
    confidence,
  };
}

function clampNonEmpty(value: string, max: number): string | null {
  const trimmed = value.trim();
  if (trimmed.length === 0) return null;
  if (trimmed.length <= max) return trimmed;
  return `${trimmed.slice(0, max - 1).trimEnd()}…`;
}

function clampConfidence(value: number): number {
  if (!Number.isFinite(value)) return 0.5;
  if (value < 0) return 0;
  if (value > 1) return 1;
  return Math.round(value * 100) / 100;
}

function parseIso(value: string): Date | null {
  const ms = Date.parse(value);
  if (Number.isNaN(ms)) return null;
  return new Date(ms);
}

function deriveReminder(
  dueDate: Date,
  receivedAt: Date,
  priority: TaskSuggestion["priority"],
): Date {
  const offsetMs = priority === "urgent" ? 2 * 60 * 60 * 1000 : 24 * 60 * 60 * 1000;
  const reminder = new Date(dueDate.getTime() - offsetMs);
  if (reminder.getTime() <= receivedAt.getTime()) {
    return new Date(receivedAt.getTime() + 60 * 60 * 1000);
  }
  return reminder;
}
