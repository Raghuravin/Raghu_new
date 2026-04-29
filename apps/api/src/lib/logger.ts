import type { FastifyServerOptions } from "fastify";

import type { Env } from "../config/env.js";

/**
 * Builds the Pino logger configuration consumed by Fastify.
 *
 * - Uses ISO timestamps and a stable service name.
 * - Redacts common secret-shaped headers/body keys.
 * - In development we let Fastify use plain JSON output; pipe it to
 *   `pino-pretty` at the shell level if you want human-readable logs:
 *     pnpm --filter @task-capture/api dev | pino-pretty
 */
export function buildLoggerOptions(env: Env): FastifyServerOptions["logger"] {
  return {
    level: env.API_LOG_LEVEL,
    base: {
      service: "task-capture-api",
      env: env.NODE_ENV,
    },
    timestamp: () => `,"time":"${new Date().toISOString()}"`,
    redact: {
      paths: [
        "req.headers.authorization",
        "req.headers.cookie",
        "req.headers['x-api-key']",
        "headers.authorization",
        "headers.cookie",
        "*.password",
        "*.token",
        "*.apiKey",
        "*.api_key",
      ],
      censor: "[REDACTED]",
    },
    serializers: {
      req(req) {
        return {
          method: req.method,
          url: req.url,
          host: req.headers?.host,
          remoteAddress: req.ip,
        };
      },
      res(res) {
        return { statusCode: res.statusCode };
      },
    },
  };
}
