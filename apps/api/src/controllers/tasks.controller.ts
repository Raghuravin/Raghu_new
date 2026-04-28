import type { ApiResponse, Task } from "@task-capture/shared";
import type { FastifyReply, FastifyRequest } from "fastify";

import type { TasksService } from "../services/tasks.service.js";

export class TasksController {
  constructor(private readonly service: TasksService) {}

  list = async (_request: FastifyRequest, reply: FastifyReply): Promise<FastifyReply> => {
    const items = await this.service.list();
    const body: ApiResponse<Task[]> = { ok: true, data: items };
    return reply.status(200).send(body);
  };
}
