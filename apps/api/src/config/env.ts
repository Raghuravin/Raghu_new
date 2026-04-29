import { z } from "zod";

/**
 * Environment variable schema. Every variable the API depends on MUST be
 * declared here so the server fails fast at boot if anything is missing or
 * malformed.
 */
const EnvSchema = z.object({
  NODE_ENV: z.enum(["development", "test", "production"]).default("development"),

  API_HOST: z.string().min(1).default("0.0.0.0"),
  API_PORT: z.coerce.number().int().positive().max(65535).default(4000),
  API_LOG_LEVEL: z
    .enum(["fatal", "error", "warn", "info", "debug", "trace", "silent"])
    .default("info"),
  API_CORS_ORIGIN: z
    .string()
    .min(1)
    .default("http://localhost:3000")
    .describe("Comma-separated list of allowed origins, or '*'"),

  SUPABASE_URL: z.string().url().optional(),
  SUPABASE_SERVICE_ROLE_KEY: z.string().min(1).optional(),
  SUPABASE_ANON_KEY: z.string().min(1).optional(),
  /**
   * HS256 JWT secret used by Supabase Auth to sign access tokens.
   * Required to verify Bearer tokens on `requireAuth` routes. Without it,
   * the API runs in "dev auth" mode (see plugins/auth.ts).
   */
  SUPABASE_JWT_SECRET: z.string().min(1).optional(),
  /**
   * When true, requireAuth allows requests without a Bearer token and
   * substitutes a deterministic dev user. Use only for local development.
   * Defaults to true in development, false otherwise.
   */
  AUTH_DEV_MODE: z
    .string()
    .optional()
    .transform((v) => (v === undefined ? undefined : v.toLowerCase() === "true")),

  OPENAI_API_KEY: z.string().min(1).optional(),
  AI_MODEL: z.string().min(1).default("gpt-4o-mini"),

  GOOGLE_CLIENT_ID: z.string().optional(),
  GOOGLE_CLIENT_SECRET: z.string().optional(),
  GOOGLE_REDIRECT_URI: z.string().url().optional(),
});

export type Env = z.infer<typeof EnvSchema>;

export function loadEnv(source: NodeJS.ProcessEnv = process.env): Env {
  const parsed = EnvSchema.safeParse(source);
  if (!parsed.success) {
    const issues = parsed.error.issues
      .map((issue) => `  - ${issue.path.join(".") || "(root)"}: ${issue.message}`)
      .join("\n");
    throw new Error(`Invalid environment configuration:\n${issues}`);
  }
  return parsed.data;
}
