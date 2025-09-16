
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { ContactEditor } from '@/components/contact-editor';

async function getDetailData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('contact_details')
        .select('*')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching contact detail data:', error);
        return null;
    }
    
    return data;
}

export default async function EditContactDetailPage({ params }: { params: { slug: string } }) {
    const detailSlug = params.slug;

    if (!detailSlug) {
        notFound();
    }

    const detailData = await getDetailData(detailSlug);
     if (!detailData) {
        notFound();
    }

    return (
        <ContactEditor initialData={detailData} />
    )
}
