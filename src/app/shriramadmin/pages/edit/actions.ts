'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'

export async function savePageContent(pageSlug: string, sections: any[]) {
  const supabase = createClient()
  
  try {
    // Fetch the page id from the slug
    const { data: pageData, error: pageError } = await supabase
      .from('pages')
      .select('id')
      .eq('slug', pageSlug)
      .single()

    if (pageError || !pageData) {
      throw new Error(`Failed to find page with slug: ${pageSlug}`)
    }

    const pageId = pageData.id;

    // Update each section
    for (const section of sections) {
      const { data, error } = await supabase
        .from('sections')
        .update({ content: section.content, visible: section.visible })
        .eq('id', section.id)
        .eq('page_id', pageId)
      
      if (error) {
        console.error(`Error updating section ${section.id}:`, error)
        throw new Error(`Failed to update section: ${section.title}`)
      }
    }

    // Revalidate the path to show changes
    const revalidationSlug = pageSlug === 'home' ? '/' : `/${pageSlug}`
    revalidatePath(revalidationSlug, 'page')
    revalidatePath(`/shriramadmin/pages/edit?page=${pageSlug}`, 'page')
    revalidatePath('/', 'layout'); // Revalidate all pages

    return { success: true }
  } catch (error: any) {
    console.error('Error saving page content:', error)
    return { success: false, error: error.message }
  }
}
