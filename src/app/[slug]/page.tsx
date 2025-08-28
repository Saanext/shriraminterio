
import { createClient as createServerClient } from '@/lib/supabase/server';
import { createClient as createBrowserClient } from '@/lib/supabase/client';
import { notFound } from 'next/navigation';
import { DynamicPageClient } from '@/components/dynamic-page-client';

async function getPageContent(slug: string) {
    const supabase = createServerClient();
    const { data: page, error } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', slug)
        .single();
    
    if (error || !page) {
        return null;
    }
    
    page.sections.sort((a, b) => a.order - b.order);

    return page;
}

export default async function DynamicPage({ params }: { params: { slug: string } }) {
    // Exclude special routes from this dynamic page handler
    const excludedSlugs = ['shriramadmin', 'login', 'auth'];
    if (excludedSlugs.some(excluded => params.slug.startsWith(excluded))) {
        notFound();
    }
        
    const pageContent = await getPageContent(params.slug);
    if (!pageContent) {
        notFound();
    }

    return <DynamicPageClient initialPageContent={pageContent} />;
}

export async function generateStaticParams() {
    const supabase = createBrowserClient();
    const { data: pages } = await supabase.from('pages').select('slug, parent_slug');

    return pages?.map(({ slug, parent_slug }) => ({
        slug: parent_slug ? `${parent_slug}/${slug}` : slug,
    })).filter(page => page.slug && page.slug !== 'home') || [];
}
