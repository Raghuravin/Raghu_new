import type { AiConfig } from "@task-capture/ai";
import type { FastifyInstance } from "fastify";

import { ExtractionController } from "../controllers/extraction.controller.js";
import { ExtractionService } from "../services/extraction.service.js";

export async function extractionRoutes(app: FastifyInstance): Promise<void> {
  const aiConfig: AiConfig | null = app.config.OPENAI_API_KEY
    ? { apiKey: app.config.OPENAI_API_KEY, model: app.config.AI_MODEL }
    : null;

  if (!aiConfig) {
    app.log.warn(
      "OPENAI_API_KEY not set: /api/v1/extract-task will use the deterministic mock extractor",
    );
  } else {
    app.log.info({ model: aiConfig.model }, "LLM extraction enabled");
  }

  const service = new ExtractionService({ aiConfig, logger: app.log });
  const controller = new ExtractionController(service);

  app.post("/", controller.extractTask);
}
