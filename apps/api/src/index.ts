import "dotenv/config";

import { loadEnv } from "./config/env.js";
import { buildServer } from "./server.js";

async function main(): Promise<void> {
  const env = loadEnv();
  const app = await buildServer(env);

  const close = async (signal: string): Promise<void> => {
    app.log.info({ signal }, "Shutting down");
    try {
      await app.close();
      process.exit(0);
    } catch (err) {
      app.log.error({ err }, "Error during shutdown");
      process.exit(1);
    }
  };

  process.on("SIGINT", () => void close("SIGINT"));
  process.on("SIGTERM", () => void close("SIGTERM"));
  process.on("unhandledRejection", (reason) => {
    app.log.error({ reason }, "Unhandled promise rejection");
  });
  process.on("uncaughtException", (err) => {
    app.log.fatal({ err }, "Uncaught exception");
    process.exit(1);
  });

  try {
    await app.listen({ host: env.API_HOST, port: env.API_PORT });
  } catch (err) {
    app.log.fatal({ err }, "Failed to start server");
    process.exit(1);
  }
}

main().catch((err) => {
  console.error("Fatal error during boot:", err);
  process.exit(1);
});
