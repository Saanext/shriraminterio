
'use server';
/**
 * @fileOverview A flow for generating website section content.
 *
 * - generateSectionContent - A function that handles the content generation.
 * - GenerateSectionContentInput - The input type for the function.
 * - GenerateSectionContentOutput - The return type for the function.
 */

import {ai} from '@/ai/genkit';
import {googleAI} from '@genkit-ai/googleai';
import {z} from 'zod';

const GenerateSectionContentInputSchema = z.object({
  context: z.string().describe('The context of the section (e.g., "Hero section of a homepage for an interior design company").'),
  currentContent: z.any().describe('The current content of the section as a JSON object. The AI should aim to fill a similar structure.'),
  contentStructure: z.any().describe('The structure of the content as a JSON object, with fields and their types (e.g., text, textarea, image, repeater). This defines the expected output format.'),
  keywords: z.string().describe('A comma-separated list of keywords or ideas the user wants to include.'),
});
export type GenerateSectionContentInput = z.infer<typeof GenerateSectionContentInputSchema>;

// Define a new schema for the prompt's input, including the stringified JSON
const PromptInputSchema = GenerateSectionContentInputSchema.extend({
    stringifiedContentStructure: z.string(),
    stringifiedCurrentContent: z.string(),
});

const GenerateSectionContentOutputSchema = z.object({
    content: z.any().describe("The newly generated content for the section, matching the provided content structure."),
});
export type GenerateSectionContentOutput = z.infer<typeof GenerateSectionContentOutputSchema>;


export async function generateSectionContent(input: GenerateSectionContentInput): Promise<GenerateSectionContentOutput> {
  return generateSectionContentFlow(input);
}

const prompt = ai.definePrompt({
  name: 'generateSectionContentPrompt',
  model: googleAI.model('gemini-1.5-flash-latest'),
  input: {schema: PromptInputSchema},
  output: {schema: GenerateSectionContentOutputSchema},
  prompt: `You are an expert copywriter and content strategist for a web development agency.
Your task is to generate compelling content for a specific section of a website based on the user's requirements.

**IMPORTANT RULE:**
- **Do NOT change existing image URLs.** If a field of type 'image' in the \`currentContent\` already has a URL, you MUST use that exact same URL in your output.
- Only generate descriptive placeholder text for 'image' fields if they are empty or do not contain a URL.

**Instructions:**

1.  **Analyze the Input:** Carefully review the provided context, current content, content structure, and keywords.
2.  **Understand the Structure:** The \`contentStructure\` defines the exact JSON format you must produce.
3.  **Preserve Images:** For any field with type 'image' (like a background image or a gallery item), check the \`currentContent\`. If an image URL is already present, you must keep it. Do not change it.
4.  **Incorporate Keywords:** Naturally weave the user's \`keywords\` into the generated text content.
5.  **Generate Text Content:** Create new content for text-based fields (text, textarea) that is engaging and professional. For fields of type 'repeater', generate a reasonable number of items (2-4 unless it's obvious more are needed).
6.  **Output JSON:** Return a single JSON object with a "content" key. The value must be a JSON object that exactly matches the \`contentStructure\`.

**Context:**
{{context}}

**Keywords:**
{{{keywords}}}

**Content Structure to Follow:**
\`\`\`json
{{{stringifiedContentStructure}}}
\`\`\`

**Current Content (for reference, preserve existing image URLs from here):**
\`\`\`json
{{{stringifiedCurrentContent}}}
\`\`\`

Produce only the final JSON object.
`,
});

const generateSectionContentFlow = ai.defineFlow(
  {
    name: 'generateSectionContentFlow',
    inputSchema: GenerateSectionContentInputSchema,
    outputSchema: GenerateSectionContentOutputSchema,
  },
  async (input) => {
    // Manually stringify the JSON objects before passing them to the prompt.
    const promptInput = {
        ...input,
        stringifiedContentStructure: JSON.stringify(input.contentStructure, null, 2),
        stringifiedCurrentContent: JSON.stringify(input.currentContent, null, 2),
    };

    const {output} = await prompt(promptInput);
    return output!;
  }
);
