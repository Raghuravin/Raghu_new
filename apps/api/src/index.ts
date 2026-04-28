import "dotenv/config";

import { loadConfig } from "./config.js";
import { createLogger } from "./logger.js";
import { createServer } from "./server.js";

async function main(): Promise<void> {
  const config = loadConfig();
  const logger = createLogger(config);
  const app = createServer(config, logger);

  app.listen(config.API_PORT, config.API_HOST, () => {
    logger.info(
      { port: config.API_PORT, host: config.API_HOST, env: config.NODE_ENV },
      "Task Capture API listening",
    );
  });
}

main().catch((err) => {
  console.error("Fatal error starting API:", err);
  process.exit(1);
});
