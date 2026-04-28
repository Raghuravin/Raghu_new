export interface Email {
  id: string;
  userId: string;
  gmailMessageId: string;
  gmailThreadId: string;
  subject: string;
  from: string;
  to: string[];
  snippet: string;
  bodyText: string | null;
  bodyHtml: string | null;
  receivedAt: string;
  createdAt: string;
}
