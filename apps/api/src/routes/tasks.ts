import type { FastifyInstance } from "fastify";

import { TasksController } from "../controllers/tasks.controller.js";
import { TasksService } from "../services/tasks.service.js";

export async function tasksRoutes(app: FastifyInstance): Promise<void> {
  const service = new TasksService({ supabase: app.supabase });
  const controller = new TasksController(service);

  app.get("/", controller.list);
}
