import type { ApiResponse } from "@task-capture/shared";
import type { FastifyReply, FastifyRequest } from "fastify";

import type { HealthService, HealthStatus } from "../services/health.service.js";

export class HealthController {
  constructor(private readonly service: HealthService) {}

  get = async (_request: FastifyRequest, reply: FastifyReply): Promise<FastifyReply> => {
    const status = this.service.getStatus();
    const body: ApiResponse<HealthStatus> = { ok: true, data: status };
    return reply.status(200).send(body);
  };
}
