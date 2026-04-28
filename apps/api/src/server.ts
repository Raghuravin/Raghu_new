import cors from "@fastify/cors";
import helmet from "@fastify/helmet";
import sensible from "@fastify/sensible";
import Fastify, { type FastifyInstance } from "fastify";

import type { Env } from "./config/env.js";
import { buildLoggerOptions } from "./lib/logger.js";
import configPlugin from "./plugins/config.js";
import errorHandlerPlugin from "./plugins/error-handler.js";
import supabasePlugin from "./plugins/supabase.js";
import { registerRoutes } from "./routes/index.js";

/**
 * Builds and returns a fully-wired Fastify instance.
 *
 * Order matters:
 *   1. config plugin (decorates app.config)
 *   2. error handler plugin (registers central handlers)
 *   3. cross-cutting plugins (helmet, cors, sensible)
 *   4. infra plugins that need config (supabase)
 *   5. feature routes
 */
export async function buildServer(env: Env): Promise<FastifyInstance> {
  const app = Fastify({
    logger: buildLoggerOptions(env),
    disableRequestLogging: false,
    trustProxy: true,
    bodyLimit: 1_048_576,
    ajv: {
      customOptions: { removeAdditional: "all", coerceTypes: true },
    },
  });

  await app.register(configPlugin, { env });
  await app.register(errorHandlerPlugin);
  await app.register(sensible);
  await app.register(helmet, { contentSecurityPolicy: false });
  await app.register(cors, {
    origin: parseCorsOrigin(env.API_CORS_ORIGIN),
    credentials: true,
  });
  await app.register(supabasePlugin);
  await app.register(registerRoutes);

  return app;
}

function parseCorsOrigin(raw: string): true | string[] {
  if (raw === "*") return true;
  return raw
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean);
}
