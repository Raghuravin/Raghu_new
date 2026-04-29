import type { ApiError } from "@task-capture/shared";
import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import fp from "fastify-plugin";
import { ZodError } from "zod";

import { AppError, isAppError } from "../lib/errors.js";

interface FastifyLikeError {
  statusCode?: number;
  code?: string;
  message?: string;
  validation?: unknown;
}

function toApiError(
  err: unknown,
  request: FastifyRequest,
): { statusCode: number; body: ApiError; logLevel: "error" | "warn" | "info" } {
  if (isAppError(err)) {
    return {
      statusCode: err.statusCode,
      logLevel: err.statusCode >= 500 ? "error" : "warn",
      body: {
        ok: false,
        error: { code: err.code, message: err.message, details: err.details },
      },
    };
  }

  if (err instanceof ZodError) {
    return {
      statusCode: 400,
      logLevel: "warn",
      body: {
        ok: false,
        error: {
          code: "validation_error",
          message: "Request validation failed",
          details: err.issues,
        },
      },
    };
  }

  const fErr = err as FastifyLikeError;
  if (fErr && typeof fErr === "object" && typeof fErr.statusCode === "number") {
    const status = fErr.statusCode;
    return {
      statusCode: status,
      logLevel: status >= 500 ? "error" : "warn",
      body: {
        ok: false,
        error: {
          code: fErr.code ?? (status >= 500 ? "internal_error" : "request_error"),
          message: fErr.message ?? "Request failed",
          details: fErr.validation,
        },
      },
    };
  }

  request.log.error({ err }, "Unhandled error");
  return {
    statusCode: 500,
    logLevel: "error",
    body: {
      ok: false,
      error: { code: "internal_error", message: "Internal server error" },
    },
  };
}

async function errorHandlerPlugin(app: FastifyInstance): Promise<void> {
  app.setErrorHandler((err: unknown, request: FastifyRequest, reply: FastifyReply) => {
    const { statusCode, body, logLevel } = toApiError(err, request);
    request.log[logLevel]({ err, statusCode, code: body.error.code }, "Request failed");
    void reply.status(statusCode).send(body);
  });

  app.setNotFoundHandler((_request: FastifyRequest, reply: FastifyReply) => {
    const body: ApiError = {
      ok: false,
      error: { code: "not_found", message: "Route not found" },
    };
    void reply.status(404).send(body);
  });
}

export default fp(errorHandlerPlugin, { name: "error-handler" });
export { AppError };
