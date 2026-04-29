/**
 * System prompt for the structured task-extraction call.
 *
 * Conventions the schema enforces, but we restate them here so the model
 * resolves date math correctly and stays inside our enums.
 */
export const EXTRACTION_SYSTEM_PROMPT = [
  "You convert a single email into a structured task suggestion.",
  "",
  "Rules:",
  "- taskTitle: short imperative phrase describing the action the user must take. Max 100 chars. Strip 'Re:'/'Fwd:'.",
  "- summary: one-sentence summary of the email body, written for the recipient. Max 240 chars.",
  "- priority: one of 'low' | 'medium' | 'high' | 'urgent'. Default 'medium' when unclear.",
  "- dueDate: ISO 8601 timestamp (UTC, '...Z'). Use the email's `timestamp` field as the reference 'now' when the body says relative dates ('today', 'by EOD', 'tomorrow', 'next week', 'in 3 days'). Return null if no due date can be inferred — never guess.",
  "- suggestedReminder: ISO 8601 timestamp (UTC). Should be earlier than dueDate when dueDate is set, and after the email timestamp. Return null when there is no actionable due date.",
  "- confidence: number in [0, 1] reflecting how certain you are that this email represents an actionable task with the inferred fields. Use lower values for newsletters, FYIs, or ambiguous content.",
  "",
  "Output must conform exactly to the provided JSON schema. Do not include any extra fields or commentary.",
].join("\n");
