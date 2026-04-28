import type { ApiResponse, Reminder, Task, TaskSource } from "@task-capture/shared";
import type { FastifyReply, FastifyRequest } from "fastify";

import { AppError } from "../lib/errors.js";
import { CreateTaskBodySchema } from "../schemas/tasks.schema.js";
import type { TasksService } from "../services/tasks.service.js";

export interface CreateTaskResponseBody {
  task: Task;
  source: TaskSource | null;
  reminder: Reminder | null;
}

export class TasksController {
  constructor(private readonly service: TasksService) {}

  list = async (_request: FastifyRequest, reply: FastifyReply): Promise<FastifyReply> => {
    const items = await this.service.list();
    const body: ApiResponse<Task[]> = { ok: true, data: items };
    return reply.status(200).send(body);
  };

  create = async (
    request: FastifyRequest<{ Body: unknown }>,
    reply: FastifyReply,
  ): Promise<FastifyReply> => {
    const parsed = CreateTaskBodySchema.safeParse(request.body);
    if (!parsed.success) {
      throw AppError.badRequest("Invalid task payload", parsed.error.issues);
    }
    const created = await this.service.create(parsed.data);
    const body: ApiResponse<CreateTaskResponseBody> = { ok: true, data: created };
    return reply.status(201).send(body);
  };
}
