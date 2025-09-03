
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
  progress: z.number().min(0).max(100),
});

export async function saveLead(values: z.infer<typeof leadSchema>) {
  const supabase = createClient();
  
  const { id, ...leadData } = values;
  
  const dataToUpsert = {
    ...leadData,
    assigned_to_id: leadData.assigned_to_id || null,
    progress: Number(leadData.progress),
  };

  try {
    let error;
    if (id) {
      // Update existing lead
      const result = await supabase.from('leads').update(dataToUpsert).eq('id', id);
      error = result.error;
    } else {
      // Create new lead
      const result = await supabase.from('leads').insert(dataToUpsert);
      error = result.error;
    }
    
    if (error) throw error;

    revalidatePath('/shriramadmin/leads');
    if (id) {
        revalidatePath(`/shriramadmin/leads/edit/${id}`);
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
