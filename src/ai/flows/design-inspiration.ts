'use server';
/**
 * @fileOverview AI-powered design inspiration tool.
 *
 * - generateDesignInspiration - A function that generates design ideas based on user preferences.
 * - DesignInspirationInput - The input type for the generateDesignInspiration function.
 * - DesignInspirationOutput - The return type for the generateDesignInspiration function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const DesignInspirationInputSchema = z.object({
  style: z.string().describe('The desired design style (e.g., modern, minimalist, rustic).'),
  colorPalette: z.string().describe('The preferred color palette (e.g., warm, cool, neutral).'),
  roomType: z.string().describe('The type of room (e.g., living room, kitchen, bedroom).'),
});
export type DesignInspirationInput = z.infer<typeof DesignInspirationInputSchema>;

const DesignInspirationOutputSchema = z.object({
  designDescription: z.string().describe('A detailed description of the generated design idea.'),
  imageUri: z.string().describe('A data URI containing a generated image of the design idea.'),
});
export type DesignInspirationOutput = z.infer<typeof DesignInspirationOutputSchema>;

export async function generateDesignInspiration(input: DesignInspirationInput): Promise<DesignInspirationOutput> {
  return designInspirationFlow(input);
}

const designInspirationPrompt = ai.definePrompt({
  name: 'designInspirationPrompt',
  input: {schema: DesignInspirationInputSchema},
  output: {schema: DesignInspirationOutputSchema},
  prompt: `You are an expert interior designer. Generate a design idea based on the following preferences:

Style: {{{style}}}
Color Palette: {{{colorPalette}}}
Room Type: {{{roomType}}}

Provide a detailed description of the design idea and generate an image of the design.

Description:

Image: {{media url=imageUri}}`,
});

const designInspirationFlow = ai.defineFlow(
  {
    name: 'designInspirationFlow',
    inputSchema: DesignInspirationInputSchema,
    outputSchema: DesignInspirationOutputSchema,
  },
  async input => {
    const imageGenerationResult = await ai.generate({
      model: 'googleai/gemini-2.0-flash-preview-image-generation',
      prompt: `Generate an image of a ${input.style} ${input.roomType} with a ${input.colorPalette} color palette.`,
      config: {
        responseModalities: ['TEXT', 'IMAGE'],
      },
    });

    const {output} = await designInspirationPrompt({
      ...input,
      imageUri: imageGenerationResult.media?.url,
    });

    return output!;
  }
);
