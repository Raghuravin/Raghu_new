import type { FastifyInstance } from "fastify";

import { ExtractionController } from "../controllers/extraction.controller.js";
import { ExtractionService } from "../services/extraction.service.js";

export async function extractionRoutes(app: FastifyInstance): Promise<void> {
  const service = new ExtractionService({
    aiEnabled: Boolean(app.config.OPENAI_API_KEY),
  });
  const controller = new ExtractionController(service);

  app.post("/", controller.extractTask);
}
