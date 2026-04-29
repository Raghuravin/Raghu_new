import { llmExtractTask, mockExtractTask, type AiConfig } from "@task-capture/ai";
import type { EmailPayload, TaskSuggestion } from "@task-capture/shared";
import type { Logger } from "pino";

/**
 * Owns the policy for converting an `EmailPayload` into a `TaskSuggestion`.
 *
 * - When an OpenAI API key is configured, runs the LLM extractor.
 * - When no key is configured, runs the deterministic mock extractor.
 * - The LLM extractor itself falls back to the mock on any provider error
 *   or schema-validation failure, so this service never throws.
 */
export interface ExtractionServiceDeps {
  aiConfig: AiConfig | null;
  logger?: Logger;
}

export class ExtractionService {
  private readonly aiConfig: AiConfig | null;
  private readonly logger: Logger | undefined;

  constructor(deps: ExtractionServiceDeps) {
    this.aiConfig = deps.aiConfig;
    this.logger = deps.logger;
  }

  async extract(payload: EmailPayload): Promise<TaskSuggestion> {
    if (!this.aiConfig) {
      return mockExtractTask(payload);
    }

    try {
      return await llmExtractTask(payload, this.aiConfig);
    } catch (err) {
      this.logger?.warn({ err }, "LLM extraction failed, falling back to mock");
      return mockExtractTask(payload);
    }
  }
}
