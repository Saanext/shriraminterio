
'use server'

import { createClient } from '@/lib/supabase/server'
import { z } from 'zod'
import { revalidatePath } from 'next/cache'

const appointmentSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
  phone: z.string().min(10),
  appointmentDate: z.date(),
  timeSlot: z.string(),
  floorplan: z.string(),
  purpose: z.string(),
  services: z.array(z.string()),
  message: z.string().optional(),
});

export async function saveAppointment(data: z.infer<typeof appointmentSchema>) {
  const supabase = createClient();
  
  const { appointmentDate, timeSlot, ...rest } = data;
  
  const dataToInsert = {
    ...rest,
    appointment_date: appointmentDate.toISOString().split('T')[0], // Format date to YYYY-MM-DD
    time_slot: timeSlot,
  };

  try {
    const { error } = await supabase.from('appointments').insert(dataToInsert);
    if (error) throw error;

    revalidatePath('/shriramadmin/appointments');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving appointment:', error);
    return { success: false, error: error.message };
  }
}
