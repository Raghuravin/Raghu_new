import { createClient, type SupabaseClient } from "@supabase/supabase-js";

import type { Database } from "./database.types.js";

export interface SupabaseConfig {
  url: string;
  key: string;
}

export interface UserScopedConfig extends SupabaseConfig {
  /** End-user JWT (Bearer). Activates RLS based on the user's identity. */
  accessToken: string;
}

export type DbClient = SupabaseClient<Database>;

/**
 * Server-side Supabase client. Pair with the **service role key** for
 * trusted server contexts (workers, cron, internal endpoints) — RLS is
 * bypassed.
 *
 * Pair with the **anon key** plus a user JWT (via `createUserDbClient`) for
 * end-user requests so RLS policies are enforced.
 */
export function createDbClient(config: SupabaseConfig): DbClient {
  if (!config.url || !config.key) {
    throw new Error("createDbClient: missing Supabase URL or key");
  }
  return createClient<Database>(config.url, config.key, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
  });
}

/**
 * Builds a Supabase client that performs requests as a specific end user.
 * Use the anon key + the user's JWT so Postgres-level RLS policies apply.
 */
export function createUserDbClient(config: UserScopedConfig): DbClient {
  if (!config.url || !config.key || !config.accessToken) {
    throw new Error("createUserDbClient: missing Supabase URL, key, or accessToken");
  }
  return createClient<Database>(config.url, config.key, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
    global: {
      headers: { Authorization: `Bearer ${config.accessToken}` },
    },
  });
}
