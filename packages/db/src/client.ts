import { createClient, type SupabaseClient } from "@supabase/supabase-js";

import type { Database } from "./database.types.js";

export interface SupabaseConfig {
  url: string;
  key: string;
}

export type DbClient = SupabaseClient<Database>;

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
