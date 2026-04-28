import type { DbClient } from "../client.js";

/**
 * Task queries. Implementations are intentionally left as stubs in the
 * scaffold; wire them to the `tasks` table once schema is finalized.
 */
export const taskQueries = {
  async listByUser(_db: DbClient, _userId: string): Promise<unknown[]> {
    return [];
  },

  async getById(_db: DbClient, _id: string): Promise<unknown | null> {
    return null;
  },
};
