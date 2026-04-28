# @task-capture/api

Backend API for **Task Capture**, built on [Fastify](https://fastify.dev/) and TypeScript.

This package contains the foundation only — no task / Gmail / AI logic yet.

## Folder structure

```
src/
  config/         # Env schema + loader (Zod)
  lib/            # Pure infrastructure: logger, errors, supabase factory
  plugins/        # Fastify plugins (config, error handler, supabase)
  routes/         # HTTP route registration (per feature)
  controllers/    # Map HTTP requests to services
  services/       # Business logic (stubs at this stage)
  types/          # Module augmentation + shared API types
  server.ts       # buildServer(env) -> FastifyInstance
  index.ts        # Process entrypoint
```

### Conventions

- **Routes** only declare URL → controller mappings and (eventually) Fastify schemas.
- **Controllers** are thin: parse input, call a service, shape the HTTP response.
- **Services** own business logic and talk to Supabase / external APIs via `lib/`.
- **lib/** holds framework-agnostic primitives (logger, errors, db client factory).
- **plugins/** are Fastify-specific bindings that decorate `app` with `config`, `supabase`, etc.

## Local development

```bash
cp .env.example .env
pnpm --filter @task-capture/api dev      # tsx watch
pnpm --filter @task-capture/api build    # tsc
pnpm --filter @task-capture/api start    # node dist/index.js
```

## Routes

| Method | Path            | Description                  |
| ------ | --------------- | ---------------------------- |
| GET    | `/health`       | Liveness + dependency report |
| GET    | `/api/v1/tasks` | Placeholder (returns `[]`)   |

All responses follow the shared `ApiResponse<T>` shape from `@task-capture/shared`:

```ts
type ApiResponse<T> =
  | { ok: true; data: T }
  | { ok: false; error: { code: string; message: string; details?: unknown } };
```

## Error handling

Throw `AppError` (or use its static helpers) anywhere in a controller/service:

```ts
import { AppError } from "./lib/errors.js";

throw AppError.notFound("Task not found");
throw AppError.badRequest("Invalid cursor", { cursor });
```

Unknown errors and `ZodError` are converted to a consistent JSON body by the
central error handler plugin.

## Env

`src/config/env.ts` is the single source of truth. The server fails fast at
boot if anything is missing or malformed. See `.env.example` for all variables.
