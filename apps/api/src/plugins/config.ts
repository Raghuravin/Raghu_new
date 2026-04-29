import type { FastifyInstance } from "fastify";
import fp from "fastify-plugin";

import type { Env } from "../config/env.js";

/**
 * Decorates the Fastify instance with the validated env config so routes,
 * controllers, and other plugins can read it via `app.config`.
 */
async function configPlugin(app: FastifyInstance, opts: { env: Env }): Promise<void> {
  app.decorate("config", opts.env);
}

export default fp(configPlugin, { name: "config" });
