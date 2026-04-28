import type { ApiResponse, TaskSuggestion } from "@task-capture/shared";
import type { FastifyReply, FastifyRequest } from "fastify";

import { AppError } from "../lib/errors.js";
import {
  EmailPayloadSchema,
  TaskSuggestionSchema,
  type EmailPayloadInput,
} from "../schemas/extraction.schema.js";
import type { ExtractionService } from "../services/extraction.service.js";

export class ExtractionController {
  constructor(private readonly service: ExtractionService) {}

  extractTask = async (
    request: FastifyRequest<{ Body: unknown }>,
    reply: FastifyReply,
  ): Promise<FastifyReply> => {
    const parsedRequest = EmailPayloadSchema.safeParse(request.body);
    if (!parsedRequest.success) {
      throw AppError.badRequest("Invalid email payload", parsedRequest.error.issues);
    }
    const payload: EmailPayloadInput = parsedRequest.data;

    const suggestion = await this.service.extract(payload);

    const parsedResponse = TaskSuggestionSchema.safeParse(suggestion);
    if (!parsedResponse.success) {
      request.log.error(
        { issues: parsedResponse.error.issues, suggestion },
        "Extractor produced an invalid TaskSuggestion",
      );
      throw AppError.internal("Extractor produced an invalid response");
    }

    const body: ApiResponse<TaskSuggestion> = { ok: true, data: parsedResponse.data };
    return reply.status(200).send(body);
  };
}
