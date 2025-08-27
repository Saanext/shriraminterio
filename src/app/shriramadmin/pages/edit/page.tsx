
import { Suspense } from 'react';
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { PageEditor } from './page-editor';
import { Skeleton } from '@/components/ui/skeleton';

async function getPageData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching initial page data:', error);
        return null;
    }
    
    // Sort sections by order
    data.sections.sort((a, b) => a.order - b.order);
    
    return data;
}

function EditPageSkeleton() {
    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <Skeleton className="h-9 w-64" />
                <div className="flex gap-4">
                    <Skeleton className="h-10 w-24" />
                    <Skeleton className="h-10 w-32" />
                </div>
            </div>
            <div className="space-y-8">
                <Skeleton className="h-64 w-full" />
                <Skeleton className="h-80 w-full" />
                <Skeleton className="h-80 w-full" />
            </div>
        </div>
    );
}


export default async function EditPage({ searchParams }: { searchParams: { page?: string } }) {
    const pageSlug = searchParams?.page;

    if (!pageSlug) {
        notFound();
    }

    const pageData = await getPageData(pageSlug);

    return (
        <Suspense fallback={<EditPageSkeleton />}>
            <PageEditor initialPageData={pageData} pageSlug={pageSlug} />
        </Suspense>
    )
}
