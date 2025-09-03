
import { Suspense } from 'react';
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { Skeleton } from '@/components/ui/skeleton';
import { LeadEditor } from '@/components/lead-editor';

async function getLeadData(id: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('leads')
        .select('*')
        .eq('id', id)
        .single();

    if (error || !data) {
        console.error('Error fetching lead data:', error);
        return null;
    }
    
    return data;
}

async function getSalesPersons() {
    const supabase = createClient();
    const { data, error } = await supabase.from('sales_persons').select('id, name').order('name');
    if (error) {
        console.error("Error fetching sales persons:", error);
        return [];
    }
    return data;
}

function EditLeadSkeleton() {
    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <Skeleton className="h-9 w-64" />
                <Skeleton className="h-10 w-32" />
            </div>
            <div className="space-y-8">
                <Skeleton className="h-[700px] w-full" />
            </div>
        </div>
    );
}

// Re-export the component with a new name to avoid conflict with the async component
const LeadEditorClient = LeadEditor;

export default async function EditLeadPage({ params }: { params: { id: string } }) {
    const leadId = params.id;

    if (!leadId) {
        notFound();
    }

    const leadData = await getLeadData(leadId);
    const salesPersons = await getSalesPersons();

    if (!leadData) {
        notFound();
    }

    return (
        <Suspense fallback={<EditLeadSkeleton />}>
            <LeadEditorClient initialData={leadData} salesPersons={salesPersons} />
        </Suspense>
    )
}
