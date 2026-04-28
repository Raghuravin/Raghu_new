-- Bootstrap: extensions and shared utilities used across the schema.

create extension if not exists "uuid-ossp";
create extension if not exists "pgcrypto";

-- Generic trigger to keep `updated_at` in sync on UPDATE.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;
