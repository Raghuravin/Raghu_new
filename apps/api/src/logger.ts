import { pino, type Logger } from "pino";

import type { Config } from "./config.js";

export function createLogger(config: Config): Logger {
  return pino({
    level: config.API_LOG_LEVEL,
    base: { service: "task-capture-api" },
    timestamp: pino.stdTimeFunctions.isoTime,
  });
}
