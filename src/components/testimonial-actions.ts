
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const testimonialSchema = z.object({
  id: z.number().optional().nullable(),
  is_featured: z.boolean().default(false),
  client_name: z.string().min(1, "Client name is required"),
  client_image_url: z.string().url("A valid image URL is required").optional().nullable(),
  location: z.string().optional().nullable(),
  project_type: z.string().optional().nullable(),
  project_size: z.string().optional().nullable(),
  quote: z.string().optional().nullable(),
  full_review: z.string().optional().nullable(),
});

export async function saveTestimonial(data: z.infer<typeof testimonialSchema>) {
  const supabase = createClient()
  
  const { id, ...testimonialData } = data;

  try {
    // If setting this testimonial as featured, un-feature all others.
    if (testimonialData.is_featured) {
        const { error: unfeatureError } = await supabase
            .from('testimonials')
            .update({ is_featured: false })
            .eq('is_featured', true);
        if (unfeatureError) throw unfeatureError;
    }

    if (id) {
      const { error } = await supabase.from('testimonials').update(testimonialData).eq('id', id);
      if (error) throw error;
    } else {
      const { error } = await supabase.from('testimonials').insert(testimonialData);
      if (error) throw error;
    }

    revalidatePath('/shriramadmin/testimonials');
    revalidatePath('/clients');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving testimonial:', error);
    return { success: false, error: error.message };
  }
}

export async function deleteTestimonial(testimonialId: number) {
    const supabase = createClient();
    try {
        const { error } = await supabase.from('testimonials').delete().eq('id', testimonialId);
        if (error) throw error;

        revalidatePath('/shriramadmin/testimonials');
        revalidatePath('/clients');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting testimonial:', error);
        return { success: false, error: error.message };
    }
}
