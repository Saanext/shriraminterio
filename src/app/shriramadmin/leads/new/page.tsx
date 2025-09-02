
import { LeadEditor } from '@/components/lead-editor';
import { createClient } from '@/lib/supabase/server';

async function getSalesPersons() {
    const supabase = createClient();
    const { data, error } = await supabase.from('sales_persons').select('id, name').order('name');
    if (error) {
        console.error("Error fetching sales persons:", error);
        return [];
    }
    return data;
}

export default async function NewLeadPage() {
    const salesPersons = await getSalesPersons();
    return <LeadEditor salesPersons={salesPersons} />;
}
