import { mockExtractTask } from "@task-capture/ai";
import type { EmailPayload, TaskSuggestion } from "@task-capture/shared";

/**
 * Owns the policy for converting an EmailPayload into a TaskSuggestion.
 *
 * Currently delegates to the deterministic mock extractor. When the LLM
 * extractor lands, this service will pick between the two based on config
 * (e.g. `OPENAI_API_KEY` presence, feature flag, request hint).
 */
export class ExtractionService {
  constructor(private readonly _deps: { aiEnabled: boolean }) {
    void this._deps;
  }

  async extract(payload: EmailPayload): Promise<TaskSuggestion> {
    return mockExtractTask(payload);
  }
}
