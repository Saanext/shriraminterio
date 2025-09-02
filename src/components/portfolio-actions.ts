
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const portfolioSchema = z.object({
  id: z.number().optional().nullable(),
  title: z.string().min(1),
  slug: z.string().min(1),
  content: z.string().optional(),
  main_image: z.string().url(),
  gallery: z.array(z.string()).optional(),
});


export async function savePortfolioItem(data: z.infer<typeof portfolioSchema>) {
  const supabase = createClient()
  
  const { id, ...portfolioData } = data;
  
  try {
    if (id) {
      const { error } = await supabase.from('portfolio').update(portfolioData).eq('id', id);
      if (error) throw error;
    } else {
      const { error } = await supabase.from('portfolio').insert(portfolioData);
      if (error) throw error;
    }

    revalidatePath('/portfolio');
    revalidatePath(`/portfolio/${portfolioData.slug}`);
    revalidatePath('/shriramadmin/portfolio');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving portfolio item:', error);
    return { success: false, error: error.message };
  }
}

export async function deletePortfolioItem(portfolioId: number) {
    const supabase = createClient();
    try {
        const { error } = await supabase.from('portfolio').delete().eq('id', portfolioId);
        if (error) throw error;

        revalidatePath('/shriramadmin/portfolio');
        revalidatePath('/portfolio');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting portfolio item:', error);
        return { success: false, error: error.message };
    }
}
