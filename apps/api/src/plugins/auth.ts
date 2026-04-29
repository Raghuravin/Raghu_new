import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import fp from "fastify-plugin";

import { AppError } from "../lib/errors.js";
import { JwtVerificationError, verifySupabaseJwt, type VerifiedUser } from "../lib/jwt.js";

/**
 * Deterministic dev user used when `AUTH_DEV_MODE=true` and no Bearer
 * token is present. UUID v4 generated once and frozen so the dashboard
 * sees a stable owner for in-memory data.
 */
const DEV_USER: VerifiedUser = {
  id: "00000000-0000-0000-0000-0000000000aa",
  email: "dev@task-capture.local",
  claims: { sub: "00000000-0000-0000-0000-0000000000aa", role: "dev" },
  accessToken: "",
};

async function authPlugin(app: FastifyInstance): Promise<void> {
  const { SUPABASE_JWT_SECRET, AUTH_DEV_MODE, NODE_ENV } = app.config;
  const devModeEnabled = AUTH_DEV_MODE ?? NODE_ENV !== "production";

  /**
   * `onRequest` hook: best-effort attach `request.user` from a Bearer
   * token if one is present and a JWT secret is configured. Routes that
   * require auth call `app.requireAuth(request)` to enforce.
   */
  app.addHook("onRequest", async (request: FastifyRequest) => {
    const header = request.headers.authorization ?? request.headers.Authorization;
    if (typeof header !== "string") return;
    const match = /^Bearer\s+(.+)$/i.exec(header.trim());
    if (!match) return;
    const token = match[1] ?? "";

    if (!SUPABASE_JWT_SECRET) {
      request.log.warn(
        "Bearer token received but SUPABASE_JWT_SECRET is not configured; ignoring token",
      );
      return;
    }

    try {
      request.user = await verifySupabaseJwt(token, SUPABASE_JWT_SECRET);
    } catch (err) {
      if (err instanceof JwtVerificationError) {
        throw AppError.unauthorized(`invalid bearer token: ${err.message}`);
      }
      throw err;
    }
  });

  /**
   * Decorator that route handlers (or per-route preHandlers) call to
   * enforce authentication. Returns the verified user.
   */
  app.decorate("requireAuth", function requireAuth(request: FastifyRequest): VerifiedUser {
    if (request.user) return request.user;
    if (devModeEnabled) {
      request.log.debug({ devUser: DEV_USER.id }, "auth: dev-mode, using dev user");
      request.user = DEV_USER;
      return DEV_USER;
    }
    throw AppError.unauthorized("authentication required");
  });

  app.decorate(
    "preHandlerRequireAuth",
    async function preHandlerRequireAuth(request: FastifyRequest, _reply: FastifyReply) {
      app.requireAuth(request);
    },
  );

  if (!SUPABASE_JWT_SECRET) {
    app.log.warn(
      { devMode: devModeEnabled },
      devModeEnabled
        ? "auth: SUPABASE_JWT_SECRET not set; running in dev-auth mode"
        : "auth: SUPABASE_JWT_SECRET not set and dev mode disabled — protected routes will 401",
    );
  } else {
    app.log.info("auth: Supabase JWT verification enabled");
  }
}

export default fp(authPlugin, { name: "auth", dependencies: ["config"] });
