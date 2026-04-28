# Task Capture

Convert Gmail emails into tasks with reminders.

Task Capture is a monorepo containing the web dashboard, backend API, Chrome
extension for Gmail, and shared packages for AI, database, types, and UI.

## Tech stack

- **Web** — [Next.js](https://nextjs.org/) 15, React 19
- **API** — Node.js + TypeScript (Express, Pino, Zod)
- **Database** — [Supabase](https://supabase.com/) (Postgres)
- **Extension** — Chrome MV3 extension built with Vite
- **AI** — Pluggable LLM-based task extraction
- **Tooling** — pnpm workspaces, TypeScript, ESLint, Prettier

## Repository layout

```
task-capture/
  apps/
    web                  # Next.js dashboard
    api                  # Node/TypeScript backend
    extension-gmail      # Chrome extension (Gmail integration)
  packages/
    ai                   # Task extraction logic
    db                   # Supabase schema + typed queries
    shared               # Shared types and utilities
    ui                   # Shared React UI components
```

Each app and package is a TypeScript project with its own `tsconfig.json`,
extending the shared `tsconfig.base.json` at the repo root.

## Prerequisites

- [Node.js](https://nodejs.org/) `>= 20`
- [pnpm](https://pnpm.io/) `>= 10` (`corepack enable && corepack prepare pnpm@10.33.0 --activate`)
- [Supabase CLI](https://supabase.com/docs/guides/cli) (optional, for local Postgres)
- A modern Chromium-based browser (for the extension)

## Local setup

```bash
# 1. Install dependencies for all workspaces
pnpm install

# 2. Copy environment templates
cp .env.example .env
cp apps/api/.env.example apps/api/.env
cp apps/web/.env.example apps/web/.env.local
cp apps/extension-gmail/.env.example apps/extension-gmail/.env

# 3. (Optional) Start a local Supabase stack
pnpm --filter @task-capture/db run db:start

# 4. Build all shared packages once
pnpm --filter "./packages/**" build

# 5. Run apps in parallel
pnpm dev
```

### Run a single app

```bash
pnpm --filter @task-capture/api dev
pnpm --filter @task-capture/web dev
pnpm --filter @task-capture/extension-gmail dev
```

### Load the Chrome extension

1. `pnpm --filter @task-capture/extension-gmail build`
2. Open `chrome://extensions`, enable **Developer mode**.
3. Click **Load unpacked** and select `apps/extension-gmail/dist`.

## Common scripts

Run from the repo root:

| Command          | Description                            |
| ---------------- | -------------------------------------- |
| `pnpm install`   | Install all workspace dependencies     |
| `pnpm dev`       | Run all apps in parallel (watch mode)  |
| `pnpm build`     | Build all packages, then all apps      |
| `pnpm lint`      | Lint all workspaces                    |
| `pnpm format`    | Format the entire repo with Prettier   |
| `pnpm typecheck` | Type-check every workspace             |
| `pnpm clean`     | Remove build output and `node_modules` |

## Environment variables

The root `.env.example` documents every variable used by the monorepo. Each
app additionally has its own `.env.example` listing the variables it consumes:

- `apps/api/.env.example` — API server (Supabase service role, OpenAI, Google OAuth)
- `apps/web/.env.example` — Next.js dashboard (`NEXT_PUBLIC_*` only)
- `apps/extension-gmail/.env.example` — Chrome extension build-time vars

Never commit real secrets. Use the Supabase dashboard, your own secret manager,
or the deployment platform's environment configuration in production.

## Database

The `packages/db` workspace contains:

- `supabase/config.toml` — Supabase CLI config (ports, auth, etc.)
- `supabase/migrations/` — SQL migrations
- `src/client.ts` — Typed Supabase client factory
- `src/queries/` — Reusable, typed query helpers
- `src/database.types.ts` — Generated Supabase types (regenerate with `pnpm --filter @task-capture/db run db:types`)

## Linting and formatting

- **ESLint** — root `.eslintrc.cjs` provides shared rules; `apps/web` extends `next/core-web-vitals`.
- **Prettier** — root `.prettierrc.json` defines formatting; run `pnpm format`.
- **EditorConfig** — `.editorconfig` keeps indentation consistent across editors.

## Continuous integration

`.github/workflows/ci.yml` runs `format:check`, `lint`, `typecheck`, and `build`
on every push and pull request to `main`.

## Status

This repository is a clean, production-ready scaffold. No product features are
implemented yet — only the foundation: workspace topology, TypeScript projects,
shared tooling, environment templates, and a buildable example endpoint per app.
