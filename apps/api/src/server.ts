import cors from "cors";
import express, { type Express } from "express";
import type { Logger } from "pino";
import { pinoHttp } from "pino-http";

import type { Config } from "./config.js";
import { errorHandler } from "./middleware/error-handler.js";
import { healthRouter } from "./routes/health.js";
import { tasksRouter } from "./routes/tasks.js";

export function createServer(config: Config, logger: Logger): Express {
  const app = express();

  app.use(pinoHttp({ logger }));
  app.use(cors({ origin: config.API_CORS_ORIGIN, credentials: true }));
  app.use(express.json({ limit: "1mb" }));

  app.use("/health", healthRouter);
  app.use("/api/tasks", tasksRouter);

  app.use(errorHandler);

  return app;
}
