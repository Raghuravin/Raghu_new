/**
 * Placeholder Supabase database types.
 *
 * Regenerate with:
 *   pnpm --filter @task-capture/db run db:types
 *
 * (requires `supabase start` running locally)
 */
export type Json = string | number | boolean | null | { [key: string]: Json } | Json[];

export interface Database {
  public: {
    Tables: Record<string, never>;
    Views: Record<string, never>;
    Functions: Record<string, never>;
    Enums: Record<string, never>;
    CompositeTypes: Record<string, never>;
  };
}
