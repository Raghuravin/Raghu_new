import type { ApiError } from "@task-capture/shared";
import type { ErrorRequestHandler } from "express";

export const errorHandler: ErrorRequestHandler = (err, req, res, _next) => {
  req.log?.error({ err }, "Unhandled error in request");
  const body: ApiError = {
    ok: false,
    error: {
      code: "internal_error",
      message: err instanceof Error ? err.message : "Internal server error",
    },
  };
  res.status(500).json(body);
};
