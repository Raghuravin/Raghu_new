/**
 * Application-level error class. Throw `AppError` (or a subclass) anywhere in
 * a controller/service to produce a consistent JSON response with a stable
 * machine-readable `code`.
 *
 * Unknown errors thrown elsewhere are caught by the central error handler and
 * mapped to a generic 500 response.
 */
export class AppError extends Error {
  public readonly statusCode: number;
  public readonly code: string;
  public readonly details?: unknown;

  constructor(params: { statusCode: number; code: string; message: string; details?: unknown }) {
    super(params.message);
    this.name = "AppError";
    this.statusCode = params.statusCode;
    this.code = params.code;
    this.details = params.details;
  }

  static badRequest(message: string, details?: unknown): AppError {
    return new AppError({ statusCode: 400, code: "bad_request", message, details });
  }

  static unauthorized(message = "Unauthorized"): AppError {
    return new AppError({ statusCode: 401, code: "unauthorized", message });
  }

  static forbidden(message = "Forbidden"): AppError {
    return new AppError({ statusCode: 403, code: "forbidden", message });
  }

  static notFound(message = "Not found"): AppError {
    return new AppError({ statusCode: 404, code: "not_found", message });
  }

  static conflict(message: string, details?: unknown): AppError {
    return new AppError({ statusCode: 409, code: "conflict", message, details });
  }

  static internal(message = "Internal server error", details?: unknown): AppError {
    return new AppError({ statusCode: 500, code: "internal_error", message, details });
  }
}

export function isAppError(value: unknown): value is AppError {
  return value instanceof AppError;
}
