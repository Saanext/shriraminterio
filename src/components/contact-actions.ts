
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const contactDetailSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1, "Name is required"),
  value: z.string().min(1, "Value is required"),
  icon: z.string().optional().nullable(),
  slug: z.string().min(1, "Slug is required"),
  url_prefix: z.string().optional().nullable(),
});


function generateSlug(name: string) {
    return name
        .toLowerCase()
        .replace(/&/g, 'and')
        .replace(/[^a-z0-9-]+/g, ' ')
        .trim()
        .replace(/\s+/g, '-');
}

export async function saveContactDetail(data: z.infer<typeof contactDetailSchema>) {
  const supabase = createClient()
  
  const { id, ...detailData } = data;

  let slug = detailData.slug || generateSlug(detailData.name);
   if (!id) {
    let isUnique = false;
    let counter = 1;
    const baseSlug = slug;
    while(!isUnique) {
      const { data: existing } = await supabase.from('contact_details').select('id').eq('slug', slug).single();
      if (!existing) {
        isUnique = true;
      } else {
        slug = `${baseSlug}-${counter}`;
        counter++;
      }
    }
  }

  const dataToUpsert = { ...detailData, slug, url_prefix: detailData.url_prefix || null };
  
  try {
    if (id) {
      const { error } = await supabase.from('contact_details').update(dataToUpsert).eq('id', id);
      if (error) throw error;
    } else {
      const { error } = await supabase.from('contact_details').insert(dataToUpsert);
      if (error) throw error;
    }

    revalidatePath('/shriramadmin/contact');
    revalidatePath('/'); // Revalidate home page for footer updates
    if (slug) {
        revalidatePath(`/shriramadmin/contact/edit/${slug}`);
    }
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving contact detail:', error);
    return { success: false, error: error.message };
  }
}

export async function deleteContactDetail(detailId: number) {
    const supabase = createClient();
    try {
        const { error } = await supabase.from('contact_details').delete().eq('id', detailId);
        if (error) throw error;

        revalidatePath('/shriramadmin/contact');
        revalidatePath('/');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting contact detail:', error);
        return { success: false, error: error.message };
    }
}
