import type { FastifyInstance } from "fastify";

import { extractionRoutes } from "./extraction.js";
import { healthRoutes } from "./health.js";
import { tasksRoutes } from "./tasks.js";

/**
 * Registers all HTTP routes under their version/scope prefixes.
 * Add new feature route modules here.
 */
export async function registerRoutes(app: FastifyInstance): Promise<void> {
  await app.register(healthRoutes, { prefix: "/health" });
  await app.register(tasksRoutes, { prefix: "/api/v1/tasks" });
  await app.register(extractionRoutes, { prefix: "/api/v1/extract-task" });
}
