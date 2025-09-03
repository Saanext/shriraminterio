
'use server';

import { createClient } from '@/lib/supabase/server';
import { revalidatePath } from 'next/cache';
import { z } from 'zod';

const leadSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1, 'Name is required'),
  email: z.string().email('Invalid email address').optional().or(z.literal('')),
  mobile: z.string().min(10, 'Mobile number is required'),
  services: z.array(z.string()).optional(),
  message: z.string().optional(),
  assigned_to_id: z.string().uuid().optional().nullable(),
  status: z.string().min(1, 'Status is required'),
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

export async function saveLead(values: z.infer<typeof leadSchema>) {
  const supabase = createClient();
  
  const { id, ...leadData } = values;

  let slug = leadData.slug || generateSlug(leadData.name);
  if (!id) { // Only check for slug uniqueness on creation
    let isUnique = false;
    let counter = 1;
    const baseSlug = slug;
    while(!isUnique) {
      const { data: existing } = await supabase.from('leads').select('id').eq('slug', slug).single();
      if (!existing) {
        isUnique = true;
      } else {
        slug = `${baseSlug}-${counter}`;
        counter++;
      }
    }
  }

  const dataToUpsert = {
    ...leadData,
    slug,
    assigned_to_id: leadData.assigned_to_id || null,
  };

  try {
    let error;
    if (id) {
      const result = await supabase.from('leads').update(dataToUpsert).eq('id', id);
      error = result.error;
    } else {
      const result = await supabase.from('leads').insert(dataToUpsert);
      error = result.error;
    }
    
    if (error) throw error;

    revalidatePath('/shriramadmin/leads');
    if (id) {
        revalidatePath(`/shriramadmin/leads/edit/${slug}`);
    }

    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving lead:', error);
    return { success: false, error: 'Failed to save the lead.' };
  }
}

export async function deleteLead(leadId: number) {
    const supabase = createClient();
    try {
        const { error } = await supabase.from('leads').delete().eq('id', leadId);
        if (error) throw error;

        revalidatePath('/shriramadmin/leads');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting lead:', error);
        return { success: false, error: 'Failed to delete the lead.' };
    }
}
