import type { AiConfig, ExtractedTask, ExtractionInput } from "./types.js";

/**
 * Extracts tasks from an email body.
 *
 * Scaffold implementation: returns an empty array. Wire to an LLM provider
 * (OpenAI, Anthropic, etc.) when implementing the feature.
 */
export async function extractTasksFromEmail(
  _input: ExtractionInput,
  _config: AiConfig,
): Promise<ExtractedTask[]> {
  return [];
}
