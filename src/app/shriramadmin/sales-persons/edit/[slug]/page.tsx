
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { SalesPersonEditor } from '@/components/sales-person-editor';

async function getSalesPersonData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('sales_persons')
        .select('*')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching sales person data:', error);
        return null;
    }
    
    return data;
}

export default async function EditSalesPersonPage({ params }: { params: { slug: string } }) {
    const personSlug = params.slug;

    if (!personSlug) {
        notFound();
    }

    const personData = await getSalesPersonData(personSlug);
     if (!personData) {
        notFound();
    }

    return (
        <SalesPersonEditor initialData={personData} />
    )
}
