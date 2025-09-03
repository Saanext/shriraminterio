
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const salesPersonSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1),
  contact_number: z.string().min(1),
  profile_image_url: z.string().url(),
});

export async function saveSalesPerson(data: z.infer<typeof salesPersonSchema>) {
  const supabase = createClient()
  
  const { id, ...personData } = data;
  
  try {
    if (id) {
      // Update existing person
      const { error } = await supabase.from('sales_persons').update(personData).eq('id', id);
      if (error) throw error;
    } else {
      // Create new person
      const { error } = await supabase.from('sales_persons').insert(personData);
      if (error) throw error;
    }

    revalidatePath('/shriramadmin/sales-persons');
    revalidatePath('/shriramadmin/leads');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving sales person:', error);
    return { success: false, error: error.message };
  }
}

export async function deleteSalesPerson(personId: number) {
    const supabase = createClient();
    try {
        // Before deleting a sales person, you might want to handle leads assigned to them.
        // For simplicity, we'll just delete the person. You could also set assigned_to_id to null for leads.
        const { error: updateError } = await supabase
            .from('leads')
            .update({ assigned_to_id: null })
            .eq('assigned_to_id', personId);

        if (updateError) {
             console.error('Error un-assigning leads:', updateError);
             throw new Error('Failed to update leads before deleting sales person.');
        }

        const { error } = await supabase.from('sales_persons').delete().eq('id', personId);
        if (error) throw error;

        revalidatePath('/shriramadmin/sales-persons');
        revalidatePath('/shriramadmin/leads');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting sales person:', error);
        return { success: false, error: 'Failed to delete the sales person.' };
    }
}
