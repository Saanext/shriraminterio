
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { HomePageClient } from '@/components/home-page-client';

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'home')
        .single();
    
    if (!page) {
        return null;
    }
    
    const content: { [key: string]: any } = {};
    for (const section of page.sections) {
        // Use section.type for the key, as it's more reliable than title
        const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
        content[sectionKey] = {
            ...section, // Keep all section data
        };
    }
    
    return { ...content, meta: { title: page.meta_title, description: page.meta_description } };
}


export default async function Home() {
  const pageContent = await getContent();

  if (!pageContent) {
    notFound();
  }

  return <HomePageClient pageContent={pageContent} />;
}
