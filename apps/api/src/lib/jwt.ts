import { jwtVerify } from "jose";

export interface VerifiedUser {
  /** Supabase auth user UUID. */
  id: string;
  email: string | null;
  /** Raw, decoded JWT claims for downstream consumers. */
  claims: Record<string, unknown>;
  /** Original Bearer token, used to build user-scoped Supabase clients. */
  accessToken: string;
}

export class JwtVerificationError extends Error {
  constructor(
    message: string,
    public readonly cause?: unknown,
  ) {
    super(message);
    this.name = "JwtVerificationError";
  }
}

/**
 * Verifies a Supabase HS256 access token and returns the user it represents.
 * Throws `JwtVerificationError` for any failure (invalid signature, expired,
 * missing `sub`, etc).
 */
export async function verifySupabaseJwt(token: string, secret: string): Promise<VerifiedUser> {
  if (!token) throw new JwtVerificationError("missing token");
  if (!secret) throw new JwtVerificationError("missing JWT secret");

  let payload: Record<string, unknown>;
  try {
    const result = await jwtVerify(token, new TextEncoder().encode(secret));
    payload = result.payload as Record<string, unknown>;
  } catch (err) {
    throw new JwtVerificationError("invalid token", err);
  }

  const sub = payload["sub"];
  if (typeof sub !== "string" || sub.length === 0) {
    throw new JwtVerificationError("token missing sub");
  }

  const email = typeof payload["email"] === "string" ? (payload["email"] as string) : null;

  return { id: sub, email, claims: payload, accessToken: token };
}
