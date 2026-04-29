import type { ApiResponse, Reminder, Task, TaskSource } from "@task-capture/shared";
import type { FastifyReply, FastifyRequest } from "fastify";

import { AppError } from "../lib/errors.js";
import type { VerifiedUser } from "../lib/jwt.js";
import { CreateTaskBodySchema } from "../schemas/tasks.schema.js";
import type { TasksService } from "../services/tasks.service.js";

export interface CreateTaskResponseBody {
  task: Task;
  source: TaskSource | null;
  reminder: Reminder | null;
}

export class TasksController {
  constructor(
    private readonly service: TasksService,
    private readonly requireAuth: (request: FastifyRequest) => VerifiedUser,
  ) {}

  list = async (request: FastifyRequest, reply: FastifyReply): Promise<FastifyReply> => {
    const user = this.requireAuth(request);
    const items = await this.service.list({ userId: user.id });
    const body: ApiResponse<Task[]> = { ok: true, data: items };
    return reply.status(200).send(body);
  };

  create = async (request: FastifyRequest, reply: FastifyReply): Promise<FastifyReply> => {
    const user = this.requireAuth(request);

    const parsed = CreateTaskBodySchema.safeParse(request.body);
    if (!parsed.success) {
      throw AppError.badRequest("Invalid task payload", parsed.error.issues);
    }

    const created = await this.service.create(user.id, parsed.data);
    const body: ApiResponse<CreateTaskResponseBody> = { ok: true, data: created };
    return reply.status(201).send(body);
  };
}
