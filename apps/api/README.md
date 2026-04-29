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

| Method | Path                   | Description                                           |
| ------ | ---------------------- | ----------------------------------------------------- |
| GET    | `/health`              | Liveness + dependency report                          |
| GET    | `/api/v1/tasks`        | Placeholder (returns `[]`)                            |
| POST   | `/api/v1/extract-task` | Convert a Gmail email payload into a `TaskSuggestion` |

### `POST /api/v1/extract-task`

**Body** (validated by Zod, see `src/schemas/extraction.schema.ts`):

```json
{
  "subject": "Please approve the Q3 budget",
  "sender": "Alex <alex@example.com>",
  "body": "Hi — can you review and approve the attached budget by tomorrow?",
  "timestamp": "2026-04-28T10:00:00.000Z",
  "sourceUrl": "https://mail.google.com/mail/u/0/#inbox/abc123"
}
```

**Response** — `ApiResponse<TaskSuggestion>`:

```json
{
  "ok": true,
  "data": {
    "taskTitle": "Approve Q3 budget",
    "summary": "From Alex: review and approve the attached budget by tomorrow.",
    "dueDate": "2026-04-29T23:59:00.000Z",
    "priority": "high",
    "suggestedReminder": "2026-04-28T23:59:00.000Z",
    "confidence": 0.86
  }
}
```

### Extraction strategy

When `OPENAI_API_KEY` is set, the request is run through the LLM extractor
(`@task-capture/ai` → `llmExtractTask`):

- A deterministic JSON schema is sent with `response_format: json_schema`
  and `strict: true`, so OpenAI returns exactly the fields above.
- `temperature` is `0` for reproducibility.
- The result is sanitized: titles/summaries are clamped to length, the
  priority must be one of `low | medium | high | urgent`, `dueDate` must
  be `>=` the email timestamp or it is set to `null`, the reminder is
  recomputed if it falls outside `(receivedAt, dueDate]`, and `confidence`
  is clamped to `[0, 1]`.
- On any provider / network / schema error, the service falls back to the
  deterministic mock extractor (`mockExtractTask`) so the endpoint never
  fails because of LLM problems. The mock's confidence is `0.4`.

When `OPENAI_API_KEY` is **not** set the service uses the mock extractor
directly. This is also what the local-dev default is.

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
