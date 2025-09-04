
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { SocialLinkEditor } from '@/components/social-link-editor';

async function getLinkData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('social_links')
        .select('*')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching social link data:', error);
        return null;
    }
    
    return data;
}

export default async function EditSocialLinkPage({ params }: { params: { slug: string } }) {
    const linkSlug = params.slug;

    if (!linkSlug) {
        notFound();
    }

    const linkData = await getLinkData(linkSlug);
     if (!linkData) {
        notFound();
    }

    return (
        <SocialLinkEditor initialData={linkData} />
    )
}
