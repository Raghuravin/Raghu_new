/**
 * Hand-maintained Supabase database types.
 *
 * Keep in sync with the SQL files in `supabase/migrations/`. Once a Supabase
 * project is provisioned this file should be regenerated automatically with:
 *
 *   pnpm --filter @task-capture/db run db:types
 *
 * The shape mirrors what `supabase gen types typescript` produces so the
 * generated file can drop in here without touching downstream code.
 *
 * NOTE: rows / inserts / updates are declared as `type` aliases rather than
 * `interface` so they implicitly satisfy Supabase's `Record<string, unknown>`
 * generic constraint (interfaces don't get an implicit index signature).
 */
export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[];

export type TaskStatus = "pending" | "in_progress" | "done" | "snoozed" | "archived";
export type TaskPriority = "low" | "medium" | "high" | "urgent";
export type TaskSourceProvider = "gmail" | "manual" | "other";
export type ReminderStatus = "scheduled" | "sent" | "cancelled" | "failed";

export type TaskRow = {
  id: string;
  user_id: string;
  title: string;
  description: string | null;
  status: TaskStatus;
  priority: TaskPriority;
  due_at: string | null;
  completed_at: string | null;
  created_at: string;
  updated_at: string;
};

export type TaskInsert = {
  id?: string;
  user_id: string;
  title: string;
  description?: string | null;
  status?: TaskStatus;
  priority?: TaskPriority;
  due_at?: string | null;
  completed_at?: string | null;
  created_at?: string;
  updated_at?: string;
};

export type TaskUpdate = {
  id?: string;
  user_id?: string;
  title?: string;
  description?: string | null;
  status?: TaskStatus;
  priority?: TaskPriority;
  due_at?: string | null;
  completed_at?: string | null;
  updated_at?: string;
};

export type TaskSourceRow = {
  id: string;
  task_id: string;
  user_id: string;
  provider: TaskSourceProvider;
  external_id: string | null;
  subject: string | null;
  sender: string | null;
  source_url: string | null;
  received_at: string | null;
  snippet: string | null;
  metadata: Json;
  created_at: string;
  updated_at: string;
};

export type TaskSourceInsert = {
  id?: string;
  task_id: string;
  user_id: string;
  provider: TaskSourceProvider;
  external_id?: string | null;
  subject?: string | null;
  sender?: string | null;
  source_url?: string | null;
  received_at?: string | null;
  snippet?: string | null;
  metadata?: Json;
  created_at?: string;
  updated_at?: string;
};

export type TaskSourceUpdate = {
  id?: string;
  task_id?: string;
  user_id?: string;
  provider?: TaskSourceProvider;
  external_id?: string | null;
  subject?: string | null;
  sender?: string | null;
  source_url?: string | null;
  received_at?: string | null;
  snippet?: string | null;
  metadata?: Json;
  updated_at?: string;
};

export type ReminderRow = {
  id: string;
  task_id: string;
  user_id: string;
  remind_at: string;
  status: ReminderStatus;
  sent_at: string | null;
  channel: string | null;
  metadata: Json;
  created_at: string;
  updated_at: string;
};

export type ReminderInsert = {
  id?: string;
  task_id: string;
  user_id: string;
  remind_at: string;
  status?: ReminderStatus;
  sent_at?: string | null;
  channel?: string | null;
  metadata?: Json;
  created_at?: string;
  updated_at?: string;
};

export type ReminderUpdate = {
  id?: string;
  task_id?: string;
  user_id?: string;
  remind_at?: string;
  status?: ReminderStatus;
  sent_at?: string | null;
  channel?: string | null;
  metadata?: Json;
  updated_at?: string;
};

export type Database = {
  __InternalSupabase: {
    PostgrestVersion: "12";
  };
  public: {
    Tables: {
      tasks: {
        Row: TaskRow;
        Insert: TaskInsert;
        Update: TaskUpdate;
        Relationships: [];
      };
      task_sources: {
        Row: TaskSourceRow;
        Insert: TaskSourceInsert;
        Update: TaskSourceUpdate;
        Relationships: [];
      };
      reminders: {
        Row: ReminderRow;
        Insert: ReminderInsert;
        Update: ReminderUpdate;
        Relationships: [];
      };
    };
    Views: { [_ in never]: never };
    Functions: { [_ in never]: never };
    Enums: {
      task_status: TaskStatus;
      task_priority: TaskPriority;
      task_source_provider: TaskSourceProvider;
      reminder_status: ReminderStatus;
    };
    CompositeTypes: { [_ in never]: never };
  };
};
