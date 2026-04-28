import type { FastifyInstance } from "fastify";
import fp from "fastify-plugin";

import { createSupabaseClient } from "../lib/supabase.js";

/**
 * Decorates the Fastify instance with `app.supabase`.
 * Reads from `app.config`, so this plugin must be registered after the
 * config plugin.
 */
async function supabasePlugin(app: FastifyInstance): Promise<void> {
  const client = createSupabaseClient(app.config);
  app.decorate("supabase", client);

  if (!client) {
    app.log.warn(
      "Supabase client not initialized: SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY missing",
    );
  } else {
    app.log.info("Supabase client initialized");
  }
}

export default fp(supabasePlugin, {
  name: "supabase",
  dependencies: ["config"],
});
