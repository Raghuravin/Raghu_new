import type { ApiResponse } from "@task-capture/shared";

/**
 * Server-side API base URL. Used inside Server Components and route
 * handlers running on the Next server. Falls back to `NEXT_PUBLIC_API_URL`
 * so the same env var works in client and server contexts.
 */
const SERVER_API_URL =
  process.env.API_INTERNAL_URL ?? process.env.NEXT_PUBLIC_API_URL ?? "http://localhost:4000";

export class ApiClientError extends Error {
  constructor(
    public readonly code: string,
    message: string,
    public readonly status: number,
    public readonly details?: unknown,
  ) {
    super(message);
    this.name = "ApiClientError";
  }
}

export interface ApiFetchInit extends Omit<RequestInit, "body" | "headers"> {
  body?: unknown;
  headers?: Record<string, string>;
  /** Optional Bearer token; passed through as `Authorization: Bearer <token>`. */
  bearer?: string;
}

/**
 * Typed JSON fetch that always returns `data` on success and throws
 * `ApiClientError` on any failure (network, 4xx, 5xx, malformed body,
 * `{ ok: false }` envelope). Pair with try/catch in callers.
 */
export async function apiFetch<T>(path: string, init: ApiFetchInit = {}): Promise<T> {
  const { body, bearer, headers, ...rest } = init;
  const response = await fetch(`${SERVER_API_URL}${path}`, {
    ...rest,
    headers: {
      accept: "application/json",
      ...(body !== undefined ? { "content-type": "application/json" } : {}),
      ...(bearer ? { authorization: `Bearer ${bearer}` } : {}),
      ...headers,
    },
    body: body === undefined ? undefined : JSON.stringify(body),
    cache: rest.cache ?? "no-store",
  });

  let parsed: ApiResponse<T> | null = null;
  try {
    parsed = (await response.json()) as ApiResponse<T>;
  } catch {
    throw new ApiClientError(
      "invalid_response",
      `API returned ${response.status} with non-JSON body`,
      response.status,
    );
  }

  if (!response.ok) {
    if (parsed && !parsed.ok) {
      throw new ApiClientError(
        parsed.error.code,
        parsed.error.message,
        response.status,
        parsed.error.details,
      );
    }
    throw new ApiClientError(
      "http_error",
      `API responded with ${response.status}`,
      response.status,
    );
  }
  if (!parsed || !parsed.ok) {
    if (parsed && !parsed.ok) {
      throw new ApiClientError(
        parsed.error.code,
        parsed.error.message,
        response.status,
        parsed.error.details,
      );
    }
    throw new ApiClientError("invalid_response", "Malformed success response", response.status);
  }
  return parsed.data;
}
