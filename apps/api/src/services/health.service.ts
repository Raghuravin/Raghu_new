import type { DbClient } from "../lib/supabase.js";

export interface HealthStatus {
  ok: true;
  status: "healthy";
  uptimeSeconds: number;
  timestamp: string;
  version: string;
  checks: {
    supabase: "configured" | "not_configured";
  };
}

export class HealthService {
  constructor(
    private readonly deps: {
      supabase: DbClient | null;
      version: string;
      startedAt: number;
    },
  ) {}

  getStatus(): HealthStatus {
    return {
      ok: true,
      status: "healthy",
      uptimeSeconds: Math.round((Date.now() - this.deps.startedAt) / 1000),
      timestamp: new Date().toISOString(),
      version: this.deps.version,
      checks: {
        supabase: this.deps.supabase ? "configured" : "not_configured",
      },
    };
  }
}
