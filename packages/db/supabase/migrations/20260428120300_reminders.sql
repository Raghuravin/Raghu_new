-- Reminders: scheduled notifications for a task.
-- A task may have multiple reminders (e.g. day-before + hour-before).

create type public.reminder_status as enum (
  'scheduled',
  'sent',
  'cancelled',
  'failed'
);

create table public.reminders (
  id uuid primary key default gen_random_uuid(),
  task_id uuid not null references public.tasks(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  remind_at timestamptz not null,
  status public.reminder_status not null default 'scheduled',
  sent_at timestamptz,
  channel text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index reminders_task_id_idx on public.reminders (task_id);
create index reminders_user_id_idx on public.reminders (user_id);
-- Critical for the worker that polls "what should fire next?".
create index reminders_due_idx
  on public.reminders (status, remind_at)
  where status = 'scheduled';

create trigger reminders_set_updated_at
before update on public.reminders
for each row execute function public.set_updated_at();

alter table public.reminders enable row level security;

create policy "reminders_select_own"
  on public.reminders for select
  using (auth.uid() = user_id);

create policy "reminders_insert_own"
  on public.reminders for insert
  with check (auth.uid() = user_id);

create policy "reminders_update_own"
  on public.reminders for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "reminders_delete_own"
  on public.reminders for delete
  using (auth.uid() = user_id);
