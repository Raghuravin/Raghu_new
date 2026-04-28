import type { CapturedEmail } from "../shared/types.js";

const SUBJECT_SELECTORS = ["h2.hP", "[data-thread-perm-id] h2"];
const SENDER_NAME_SELECTORS = [".gD", "span[email]"];
const BODY_SELECTORS = [".a3s.aiL", "div[role='listitem'] .a3s"];
const TIMESTAMP_SELECTORS = ["span.g3", ".g3 .gK"];

/**
 * Scrapes the currently open Gmail conversation pane. Gmail's DOM is not
 * stable across releases; the selectors below are best-effort and we
 * always degrade gracefully (returning null fields rather than throwing).
 */
export function captureCurrentEmail(): CapturedEmail | null {
  const subjectEl = pick(SUBJECT_SELECTORS);
  if (!subjectEl) return null;
  const subject = textOf(subjectEl);
  if (!subject) return null;

  const conversationRoot = subjectEl.closest('[role="main"]') ?? document;

  const senderEl = queryWithin(conversationRoot, SENDER_NAME_SELECTORS);
  const sender = buildSender(senderEl);

  const bodyEl = queryWithin(conversationRoot, BODY_SELECTORS);
  const body = bodyEl ? cleanText(bodyEl.textContent ?? "") : "";
  const snippet = body.length > 200 ? `${body.slice(0, 199)}…` : body;

  const timeEl = queryWithin(conversationRoot, TIMESTAMP_SELECTORS);
  const timestamp = parseTimestamp(timeEl) ?? new Date().toISOString();

  const sourceUrl = window.location.href;
  const gmailMessageId = extractGmailMessageId(sourceUrl);

  return {
    subject,
    sender,
    body: body.length > 0 ? body : subject,
    timestamp,
    sourceUrl,
    gmailMessageId,
    snippet,
  };
}

function pick(selectors: string[]): HTMLElement | null {
  for (const sel of selectors) {
    const el = document.querySelector<HTMLElement>(sel);
    if (el) return el;
  }
  return null;
}

function queryWithin(root: ParentNode, selectors: string[]): HTMLElement | null {
  for (const sel of selectors) {
    const el = root.querySelector<HTMLElement>(sel);
    if (el) return el;
  }
  return null;
}

function textOf(el: HTMLElement): string {
  return cleanText(el.textContent ?? "");
}

function cleanText(text: string): string {
  return text.replace(/\s+/g, " ").trim();
}

function buildSender(el: HTMLElement | null): string {
  if (!el) return "Unknown sender";
  const name = (el.getAttribute("name") ?? el.textContent ?? "").trim();
  const email = (el.getAttribute("email") ?? "").trim();
  if (name && email) return `${name} <${email}>`;
  return email || name || "Unknown sender";
}

function parseTimestamp(el: HTMLElement | null): string | null {
  if (!el) return null;
  const title = el.getAttribute("title");
  if (title) {
    const ms = Date.parse(title);
    if (!Number.isNaN(ms)) return new Date(ms).toISOString();
  }
  const text = el.textContent?.trim();
  if (text) {
    const ms = Date.parse(text);
    if (!Number.isNaN(ms)) return new Date(ms).toISOString();
  }
  return null;
}

function extractGmailMessageId(url: string): string | null {
  const hashMatch = url.match(/#(?:[^/]+\/)+([a-zA-Z0-9]+)$/);
  return hashMatch && hashMatch[1] ? hashMatch[1] : null;
}
