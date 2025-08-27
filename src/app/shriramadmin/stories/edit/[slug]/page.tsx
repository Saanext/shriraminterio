
import { Suspense } from 'react';
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { Skeleton } from '@/components/ui/skeleton';
import { StoryEditor } from '@/components/story-editor';

async function getStoryData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('stories')
        .select('*')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching story data:', error);
        return null;
    }
    
    return data;
}

function EditStorySkeleton() {
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
            </div>
        </div>
    );
}


export default async function EditStoryPage({ params }: { params: { slug: string } }) {
    const storySlug = params.slug;

    if (!storySlug) {
        notFound();
    }

    const storyData = await getStoryData(storySlug);
     if (!storyData) {
        notFound();
    }

    return (
        <Suspense fallback={<EditStorySkeleton />}>
            <StoryEditor initialData={storyData} />
        </Suspense>
    )
}
