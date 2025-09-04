
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const socialLinkSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1, "Name is required"),
  url: z.string().url("A valid URL is required"),
  icon: z.string().min(1, "An icon is required"),
  slug: z.string().optional(),
});

function generateSlug(name: string) {
    return name
        .toLowerCase()
        .replace(/&/g, 'and')
        .replace(/[^a-z0-9-]+/g, ' ')
        .trim()
        .replace(/\s+/g, '-');
}

export async function saveSocialLink(data: z.infer<typeof socialLinkSchema>) {
  const supabase = createClient()
  
  const { id, ...linkData } = data;

  let slug = linkData.slug || generateSlug(linkData.name);
  if (!id) { // Only check for slug uniqueness on creation
    let isUnique = false;
    let counter = 1;
    const baseSlug = slug;
    while(!isUnique) {
      const { data: existing } = await supabase.from('social_links').select('id').eq('slug', slug).single();
      if (!existing) {
        isUnique = true;
      } else {
        slug = `${baseSlug}-${counter}`;
        counter++;
      }
    }
  }

  const dataToUpsert = { ...linkData, slug };
  
  try {
    if (id) {
      const { error } = await supabase.from('social_links').update(dataToUpsert).eq('id', id);
      if (error) throw error;
    } else {
      const { error } = await supabase.from('social_links').insert(dataToUpsert);
      if (error) throw error;
    }

    revalidatePath('/shriramadmin/social-links');
    revalidatePath('/'); // Revalidate home page for footer updates
    if (slug) {
        revalidatePath(`/shriramadmin/social-links/edit/${slug}`);
    }
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving social link:', error);
    return { success: false, error: error.message };
  }
}

export async function deleteSocialLink(linkId: number) {
    const supabase = createClient();
    try {
        const { error } = await supabase.from('social_links').delete().eq('id', linkId);
        if (error) throw error;

        revalidatePath('/shriramadmin/social-links');
        revalidatePath('/');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting social link:', error);
        return { success: false, error: error.message };
    }
}
