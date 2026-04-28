import type { Task } from "@task-capture/shared";

import type { DbClient } from "../lib/supabase.js";

/**
 * Tasks service. Business logic deliberately not implemented yet — this is
 * the foundation only. Methods are stubs that return empty data so the route
 * handlers and controllers can be wired and tested end-to-end.
 */
export interface TasksServiceDeps {
  supabase: DbClient | null;
}

export class TasksService {
  constructor(deps: TasksServiceDeps) {
    void deps;
  }

  async list(): Promise<Task[]> {
    return [];
  }
}
