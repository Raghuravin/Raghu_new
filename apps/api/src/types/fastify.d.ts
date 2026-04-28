import type { Env } from "../config/env.js";
import type { DbClient } from "../lib/supabase.js";

declare module "fastify" {
  interface FastifyInstance {
    /** Validated environment configuration. */
    config: Env;
    /** Supabase client (null if not configured). */
    supabase: DbClient | null;
  }
}
