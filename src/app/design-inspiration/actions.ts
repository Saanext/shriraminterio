'use server';

import { generateDesignInspiration, DesignInspirationInput, DesignInspirationOutput } from '@/ai/flows/design-inspiration';
import { z } from 'zod';

const DesignInspirationInputSchema = z.object({
  style: z.string().min(1, 'Style is required.'),
  colorPalette: z.string().min(1, 'Color palette is required.'),
  roomType: z.string().min(1, 'Room type is required.'),
});

export async function getInspiration(input: DesignInspirationInput): Promise<{ data: DesignInspirationOutput | null; error: string | null }> {
  try {
    const validatedInput = DesignInspirationInputSchema.parse(input);
    const result = await generateDesignInspiration(validatedInput);
    if (!result || !result.designDescription || !result.imageUri) {
      throw new Error('The AI model did not return a valid response.');
    }
    return { data: result, error: null };
  } catch (e) {
    console.error('Error in getInspiration action:', e);
    const errorMessage = e instanceof Error ? e.message : 'An unknown error occurred.';
    return { data: null, error: `Failed to generate design inspiration: ${errorMessage}` };
  }
}
