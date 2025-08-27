'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const galleryItemSchema = z.object({
  src: z.string().url(),
  alt: z.string(),
  dataAiHint: z.string().optional(),
});

const storySchema = z.object({
  id: z.number().optional().nullable(),
  slug: z.string().min(1).regex(/^[a-z0-9-]+$/),
  title: z.string().min(1),
  image: z.string().url(),
  dataAiHint: z.string().optional(),
  category: z.string().min(1),
  excerpt: z.string().min(1),
  author: z.string().min(1),
  authorAvatar: z.string().url(),
  date: z.string().min(1),
  clientImage: z.string().url(),
  location: z.string().min(1),
  project: z.string().min(1),
  size: z.string().min(1),
  quote: z.string().min(1),
  content: z.string().min(1),
  gallery: z.array(galleryItemSchema),
});

export async function saveStory(data: z.infer<typeof storySchema>) {
  const supabase = createClient()
  
  const { id, ...storyData } = data;
  
  try {
    if (id) {
      // Update existing story
      const { error } = await supabase.from('stories').update(storyData).eq('id', id);
      if (error) throw error;
    } else {
      // Create new story
      const { error } = await supabase.from('stories').insert(storyData);
      if (error) throw error;
    }

    // Revalidate paths
    revalidatePath('/customer-stories');
    revalidatePath(`/customer-stories/${storyData.slug}`);
    revalidatePath('/shriramadmin/stories');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving story:', error);
    return { success: false, error: error.message };
  }
}
