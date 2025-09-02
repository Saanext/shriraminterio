
'use server';

import { createClient } from '@/lib/supabase/server';
import { revalidatePath } from 'next/cache';

export async function togglePageVisibility(pageId: number, currentState: boolean) {
  const supabase = createClient();
  
  const { data, error } = await supabase
    .from('pages')
    .update({ visible: !currentState })
    .eq('id', pageId)
    .select('slug')
    .single();

  if (error) {
    console.error('Error updating page visibility:', error);
    return { success: false, error: 'Failed to update page visibility.' };
  }

  // Revalidate the pages admin page
  revalidatePath('/shriramadmin/pages');
  
  // Revalidate the specific page path
  if (data?.slug) {
      if (data.slug === 'home') {
          revalidatePath('/', 'layout');
      } else {
          revalidatePath(`/${data.slug}`);
      }
  }

  // Revalidate the nav
  revalidatePath('/', 'layout');

  return { success: true, error: null };
}
