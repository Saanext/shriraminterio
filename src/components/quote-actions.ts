
'use server'

import { createClient } from '@/lib/supabase/server'
import { z } from 'zod'
import { revalidatePath } from 'next/cache'

const quoteSchema = z.object({
  name: z.string().min(2, { message: "Name must be at least 2 characters." }),
  email: z.string().email({ message: "Please enter a valid email address." }),
  phone: z.string().min(10, { message: "Phone number must be at least 10 digits." }),
  floorplan: z.string().optional(),
  purpose: z.string().optional(),
  message: z.string().optional(),
});


export async function saveQuote(data: z.infer<typeof quoteSchema>) {
  const supabase = createClient()
  
  try {
    const { error } = await supabase.from('quotes').insert(data);
    if (error) throw error;

    revalidatePath('/shriramadmin/quotes');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving quote:', error);
    return { success: false, error: error.message };
  }
}
