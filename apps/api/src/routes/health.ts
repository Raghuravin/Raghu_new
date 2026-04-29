import type { FastifyInstance } from "fastify";

import { HealthController } from "../controllers/health.controller.js";
import { HealthService } from "../services/health.service.js";

const SERVER_STARTED_AT = Date.now();
const VERSION = process.env.npm_package_version ?? "0.0.0";

export async function healthRoutes(app: FastifyInstance): Promise<void> {
  const service = new HealthService({
    supabase: app.supabase,
    version: VERSION,
    startedAt: SERVER_STARTED_AT,
  });
  const controller = new HealthController(service);

  app.get("/", controller.get);
}
