/**
 * Thrown when a Supabase query fails. Wraps the original Postgres error so
 * callers can inspect it without depending on `@supabase/supabase-js`.
 */
export class DbError extends Error {
  public readonly code: string | undefined;
  public readonly details: unknown;

  constructor(message: string, opts: { code?: string; details?: unknown; cause?: unknown } = {}) {
    super(message);
    this.name = "DbError";
    this.code = opts.code;
    this.details = opts.details;
    if (opts.cause !== undefined) {
      (this as { cause?: unknown }).cause = opts.cause;
    }
  }
}
