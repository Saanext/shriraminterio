
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { SocialLinkEditor } from '@/components/social-link-editor';

async function getLinkData(id: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('social_links')
        .select('*')
        .eq('id', id)
        .single();

    if (error || !data) {
        console.error('Error fetching social link data:', error);
        return null;
    }
    
    return data;
}

export default async function EditSocialLinkPage({ params }: { params: { id: string } }) {
    const linkId = params.id;

    if (!linkId) {
        notFound();
    }

    const linkData = await getLinkData(linkId);
     if (!linkData) {
        notFound();
    }

    return (
        <SocialLinkEditor initialData={linkData} />
    )
}
