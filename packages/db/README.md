# @task-capture/db

Database integration for Task Capture: typed Supabase client, hand-maintained
`Database` types, SQL migrations, and repository helpers that return domain
shapes from `@task-capture/shared`.

## Schema overview

Three core tables, all owned by `auth.users` and protected by row-level
security:

```
tasks ─┬─< task_sources       (where the task came from: Gmail, ...)
       └─< reminders          (zero or more scheduled notifications)
```

| Table          | Purpose                                                               |
| -------------- | --------------------------------------------------------------------- |
| `tasks`        | Primary user-facing records: title, status, priority, due date        |
| `task_sources` | Forward-compatible reference to the artifact a task was captured from |
| `reminders`    | Scheduled notifications for a task (multiple per task allowed)        |

Migrations live in `supabase/migrations/`:

- `20260428120000_init_extensions.sql` — `uuid-ossp`, `pgcrypto`, shared `set_updated_at` trigger function
- `20260428120100_tasks.sql` — `tasks` + enums + RLS + `tasks_set_updated_at` trigger
- `20260428120200_task_sources.sql` — `task_sources` + RLS
- `20260428120300_reminders.sql` — `reminders` + partial index for the worker

Every table has:

- `created_at` / `updated_at` (`updated_at` maintained by the shared trigger)
- `user_id` references `auth.users(id) on delete cascade`
- RLS policies for `select`/`insert`/`update`/`delete` keyed on `auth.uid()`

## TypeScript types

`src/database.types.ts` is hand-maintained to mirror what
`supabase gen types typescript` would produce. Once a Supabase project is
available, regenerate it with:

```bash
pnpm --filter @task-capture/db run db:types
```

Domain types (`Task`, `TaskSource`, `Reminder`, etc.) live in
`@task-capture/shared`; `src/mappers.ts` converts rows to domain shapes.

## Repositories

Importable from `@task-capture/db`:

```ts
import {
  createDbClient,
  createUserDbClient,
  TasksRepository,
  TaskSourcesRepository,
  RemindersRepository,
  DbError,
} from "@task-capture/db";

const db = createDbClient({
  url: process.env.SUPABASE_URL!,
  key: process.env.SUPABASE_SERVICE_ROLE_KEY!,
});

const tasks = new TasksRepository(db);
const sources = new TaskSourcesRepository(db);
const reminders = new RemindersRepository(db);

await tasks.list({ userId, status: "pending" });
await sources.create({
  taskId,
  userId,
  provider: "gmail",
  externalId: gmailMessageId,
  subject: "...",
  sender: "...",
  sourceUrl: "...",
});
await reminders.listDue(new Date().toISOString());
```

For end-user requests prefer `createUserDbClient({ url, key, accessToken })`
so Postgres-level RLS is enforced based on the user's JWT.

All repositories return domain shapes (`Task`, `TaskSource`, `Reminder`)
and throw `DbError` on Postgres errors.

## Local development

```bash
# 1. Boot a local Supabase stack (Docker required)
pnpm --filter @task-capture/db run db:start

# 2. Migrations are applied automatically on start; to reset:
pnpm --filter @task-capture/db run db:reset

# 3. Regenerate types from the live local DB
pnpm --filter @task-capture/db run db:types
```

See `.env.example` for the variables the package and the Supabase CLI need.
