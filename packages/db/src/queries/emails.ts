import type { DbClient } from "../client.js";

export const emailQueries = {
  async listByUser(_db: DbClient, _userId: string): Promise<unknown[]> {
    return [];
  },

  async getById(_db: DbClient, _id: string): Promise<unknown | null> {
    return null;
  },
};
