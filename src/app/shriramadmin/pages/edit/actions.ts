
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export async function savePageContent(pageId: number, pageSlug: string, sections: any[], metaTitle: string, metaDescription: string) {
  const supabase = createClient()
  
  try {
    // 1. Update page metadata
    const { error: pageUpdateError } = await supabase
      .from('pages')
      .update({ meta_title: metaTitle, meta_description: metaDescription })
      .eq('id', pageId)

    if (pageUpdateError) {
      console.error('Error updating page metadata:', pageUpdateError)
      throw new Error('Failed to update page settings.')
    }
    
    // 2. Update each section
    for (const section of sections) {
      const { id, page_id, order, title, type, content_structure, ...contentToUpdate } = section;
      const { error } = await supabase
        .from('sections')
        .update(contentToUpdate)
        .eq('id', section.id)
      
      if (error) {
        console.error(`Error updating section ${section.id}:`, error)
        throw new Error(`Failed to update section: ${section.title}`)
      }
    }

    // 3. Revalidate paths to show changes
    const revalidationSlug = pageSlug === 'home' ? '/' : `/${pageSlug}`
    revalidatePath(revalidationSlug, 'page')
    revalidatePath('/shriramadmin/pages/edit', 'page')
    revalidatePath('/', 'layout'); // Revalidate all pages that use the layout (e.g. for nav changes)

    return { success: true }
  } catch (error: any) {
    console.error('Error saving page content:', error)
    return { success: false, error: error.message }
  }
}
