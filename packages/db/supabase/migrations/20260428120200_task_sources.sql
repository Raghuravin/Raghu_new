-- Task sources: the external artifact a task was captured from.
-- Today this is always a Gmail email; the schema is forward-compatible
-- with future providers (Outlook, Slack, manual, ...) via `provider`.
--
-- We keep this in a separate table (rather than columns on `tasks`) so:
--   - tasks remain lean
--   - one task could in theory link to multiple sources later
--   - we can store provider-specific metadata in `metadata` (jsonb)

create type public.task_source_provider as enum (
  'gmail',
  'manual',
  'other'
);

create table public.task_sources (
  id uuid primary key default gen_random_uuid(),
  task_id uuid not null references public.tasks(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  provider public.task_source_provider not null,
  external_id text,
  subject text,
  sender text,
  source_url text,
  received_at timestamptz,
  snippet text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  -- Same external item can only be linked once per (provider, user) pair.
  unique (provider, external_id, user_id)
);

create index task_sources_task_id_idx on public.task_sources (task_id);
create index task_sources_user_id_idx on public.task_sources (user_id);

create trigger task_sources_set_updated_at
before update on public.task_sources
for each row execute function public.set_updated_at();

alter table public.task_sources enable row level security;

create policy "task_sources_select_own"
  on public.task_sources for select
  using (auth.uid() = user_id);

create policy "task_sources_insert_own"
  on public.task_sources for insert
  with check (auth.uid() = user_id);

create policy "task_sources_update_own"
  on public.task_sources for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "task_sources_delete_own"
  on public.task_sources for delete
  using (auth.uid() = user_id);
