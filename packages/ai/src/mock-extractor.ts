import type { EmailPayload, TaskPriority, TaskSuggestion } from "@task-capture/shared";

/**
 * Deterministic, dependency-free task extractor. Used as a placeholder until
 * a real LLM-backed extractor is wired in via `extractTasksFromEmail`.
 *
 * Pure function: same input always produces the same output. Easy to unit
 * test and to use as a fallback when no LLM credentials are configured.
 */

const URGENT_KEYWORDS = ["asap", "urgent", "immediately", "today", "right now", "critical"];
const HIGH_KEYWORDS = [
  "important",
  "priority",
  "deadline",
  "by tomorrow",
  "by eod",
  "by end of day",
];
const LOW_KEYWORDS = ["fyi", "no rush", "whenever", "when you have time", "low priority"];

const ACTION_VERBS = [
  "review",
  "approve",
  "sign",
  "send",
  "reply",
  "respond",
  "schedule",
  "book",
  "confirm",
  "submit",
  "complete",
  "finish",
  "prepare",
  "share",
  "follow up",
  "follow-up",
  "pay",
  "renew",
  "update",
];

const MS_PER_DAY = 24 * 60 * 60 * 1000;

export function mockExtractTask(payload: EmailPayload): TaskSuggestion {
  const subject = payload.subject.trim();
  const body = payload.body.trim();
  const haystack = `${subject}\n${body}`.toLowerCase();

  const priority = inferPriority(haystack);
  const taskTitle = buildTitle(subject, body);
  const summary = buildSummary(payload, body);
  const receivedAt = parseTimestamp(payload.timestamp);
  const dueDate = inferDueDate(haystack, receivedAt);
  const suggestedReminder = inferReminder(dueDate, receivedAt, priority);

  return {
    taskTitle,
    summary,
    dueDate: dueDate ? dueDate.toISOString() : null,
    priority,
    suggestedReminder: suggestedReminder ? suggestedReminder.toISOString() : null,
  };
}

function inferPriority(haystack: string): TaskPriority {
  if (URGENT_KEYWORDS.some((k) => haystack.includes(k))) return "urgent";
  if (HIGH_KEYWORDS.some((k) => haystack.includes(k))) return "high";
  if (LOW_KEYWORDS.some((k) => haystack.includes(k))) return "low";
  return "medium";
}

function buildTitle(subject: string, body: string): string {
  const cleanedSubject = stripReplyPrefixes(subject);
  if (cleanedSubject.length > 0) {
    const verb = ACTION_VERBS.find((v) => `${cleanedSubject} ${body}`.toLowerCase().includes(v));
    const base = truncate(cleanedSubject, 80);
    if (verb && !base.toLowerCase().includes(verb)) {
      return truncate(`${capitalize(verb)}: ${base}`, 100);
    }
    return base;
  }
  const firstLine = body.split(/\r?\n/).find((l) => l.trim().length > 0) ?? "Email task";
  return truncate(firstLine.trim(), 100);
}

function buildSummary(payload: EmailPayload, body: string): string {
  const senderLabel = extractSenderLabel(payload.sender);
  const firstSentence =
    body
      .split(/(?<=[.!?])\s+/)
      .map((s) => s.trim())
      .find((s) => s.length > 0) ?? body;
  const compact = truncate(firstSentence.replace(/\s+/g, " "), 240);
  return senderLabel ? `From ${senderLabel}: ${compact}` : compact;
}

function inferDueDate(haystack: string, receivedAt: Date): Date | null {
  if (/\btoday\b/.test(haystack)) return endOfDay(receivedAt);
  if (/\btomorrow\b/.test(haystack)) return endOfDay(addDays(receivedAt, 1));
  if (/\bby (eod|end of day)\b/.test(haystack)) return endOfDay(receivedAt);
  if (/\bnext week\b/.test(haystack)) return endOfDay(addDays(receivedAt, 7));
  if (/\bthis week\b/.test(haystack)) return endOfDay(nextFriday(receivedAt));

  const inDays = haystack.match(/\bin (\d{1,2}) days?\b/);
  if (inDays && inDays[1]) {
    return endOfDay(addDays(receivedAt, parseInt(inDays[1], 10)));
  }

  if (URGENT_KEYWORDS.some((k) => haystack.includes(k))) {
    return endOfDay(receivedAt);
  }
  if (HIGH_KEYWORDS.some((k) => haystack.includes(k))) {
    return endOfDay(addDays(receivedAt, 1));
  }
  return null;
}

function inferReminder(
  dueDate: Date | null,
  receivedAt: Date,
  priority: TaskPriority,
): Date | null {
  if (dueDate) {
    const offsetMs = priority === "urgent" ? 2 * 60 * 60 * 1000 : MS_PER_DAY;
    const reminder = new Date(dueDate.getTime() - offsetMs);
    if (reminder.getTime() <= receivedAt.getTime()) {
      return new Date(receivedAt.getTime() + 60 * 60 * 1000);
    }
    return reminder;
  }
  if (priority === "high") return addDays(receivedAt, 1);
  if (priority === "low") return null;
  return addDays(receivedAt, 3);
}

function parseTimestamp(value: string): Date {
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) {
    return new Date();
  }
  return date;
}

function addDays(date: Date, days: number): Date {
  return new Date(date.getTime() + days * MS_PER_DAY);
}

function endOfDay(date: Date): Date {
  const d = new Date(date);
  d.setUTCHours(23, 59, 0, 0);
  return d;
}

function nextFriday(date: Date): Date {
  const d = new Date(date);
  const day = d.getUTCDay();
  const offset = (5 - day + 7) % 7 || 7;
  return addDays(d, offset);
}

function stripReplyPrefixes(subject: string): string {
  return subject.replace(/^((re|fwd|fw)\s*:\s*)+/i, "").trim();
}

function extractSenderLabel(sender: string): string | null {
  const match = sender.match(/^\s*"?([^"<]+?)"?\s*<[^>]+>\s*$/);
  if (match && match[1]) return match[1].trim();
  const trimmed = sender.trim();
  return trimmed.length > 0 ? trimmed : null;
}

function truncate(text: string, max: number): string {
  if (text.length <= max) return text;
  return `${text.slice(0, max - 1).trimEnd()}…`;
}

function capitalize(text: string): string {
  if (text.length === 0) return text;
  return text.charAt(0).toUpperCase() + text.slice(1);
}
