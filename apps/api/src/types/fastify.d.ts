import type { Env } from "../config/env.js";
import type { VerifiedUser } from "../lib/jwt.js";
import type { DbClient } from "../lib/supabase.js";

declare module "fastify" {
  interface FastifyInstance {
    /** Validated environment configuration. */
    config: Env;
    /** Supabase client (null if not configured). */
    supabase: DbClient | null;
    /** Throws AppError.unauthorized if the request is not authenticated. */
    requireAuth(request: FastifyRequest): VerifiedUser;
    /** preHandler form of requireAuth for route-level enforcement. */
    preHandlerRequireAuth(request: FastifyRequest, reply: FastifyReply): Promise<void>;
  }
  interface FastifyRequest {
    /** Set by the auth plugin's onRequest hook when a valid Bearer token is present. */
    user?: VerifiedUser;
  }
}
