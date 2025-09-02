
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
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving sales person:', error);
    return { success: false, error: error.message };
  }
}
