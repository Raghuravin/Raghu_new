import { createDbClient, type DbClient } from "@task-capture/db";

import type { Env } from "../config/env.js";

/**
 * Creates the Supabase client used by the API. Returns `null` when Supabase
 * credentials are not configured so the rest of the app can boot during local
 * development without crashing — services that require the client should
 * throw `AppError.internal("supabase not configured")`.
 */
export function createSupabaseClient(env: Env): DbClient | null {
  if (!env.SUPABASE_URL || !env.SUPABASE_SERVICE_ROLE_KEY) {
    return null;
  }
  return createDbClient({
    url: env.SUPABASE_URL,
    key: env.SUPABASE_SERVICE_ROLE_KEY,
  });
}

export type { DbClient };
