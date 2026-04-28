import type { ApiResponse, Task } from "@task-capture/shared";
import { Router, type Router as ExpressRouter } from "express";

export const tasksRouter: ExpressRouter = Router();

tasksRouter.get("/", (_req, res) => {
  const body: ApiResponse<Task[]> = { ok: true, data: [] };
  res.json(body);
});
