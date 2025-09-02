
'use server';

import { createClient } from '@/lib/supabase/server';
import { revalidatePath } from 'next/cache';
import { z } from 'zod';

const leadSchema = z.object({
  name: z.string().min(1, 'Name is required'),
  email: z.string().email('Invalid email address').optional().or(z.literal('')),
  mobile: z.string().min(10, 'Mobile number is required'),
  services: z.array(z.string()).optional(),
  message: z.string().optional(),
  assigned_to_id: z.string().uuid().optional().nullable(),
});

export async function createLead(values: z.infer<typeof leadSchema>) {
  const supabase = createClient();
  
  const { error } = await supabase.from('leads').insert({
    ...values,
    assigned_to_id: values.assigned_to_id || null
  });

  if (error) {
    console.error('Error creating lead:', error);
    return { success: false, error: 'Failed to create the lead.' };
  }

  revalidatePath('/shriramadmin/leads');

  return { success: true, error: null };
}
