
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { SalesPersonEditor } from '@/components/sales-person-editor';

async function getSalesPersonData(id: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('sales_persons')
        .select('*')
        .eq('id', id)
        .single();

    if (error || !data) {
        console.error('Error fetching sales person data:', error);
        return null;
    }
    
    return data;
}

export default async function EditSalesPersonPage({ params }: { params: { id: string } }) {
    const personId = params.id;

    if (!personId) {
        notFound();
    }

    const personData = await getSalesPersonData(personId);
     if (!personData) {
        notFound();
    }

    return (
        <SalesPersonEditor initialData={personData} />
    )
}
