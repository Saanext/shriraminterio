
import { Suspense } from 'react';
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { Skeleton } from '@/components/ui/skeleton';
import { PortfolioEditor } from '@/components/portfolio-editor';

async function getPortfolioData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('portfolio')
        .select('*')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching portfolio item data:', error);
        return null;
    }
    
    return data;
}

function EditPortfolioSkeleton() {
    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <Skeleton className="h-9 w-64" />
                <Skeleton className="h-10 w-32" />
            </div>
            <div className="space-y-8">
                <Skeleton className="h-64 w-full" />
                <Skeleton className="h-80 w-full" />
            </div>
        </div>
    );
}

export default async function EditPortfolioItemPage({ params }: { params: { slug: string } }) {
    const portfolioSlug = params.slug;

    if (!portfolioSlug) {
        notFound();
    }

    const portfolioData = await getPortfolioData(portfolioSlug);
     if (!portfolioData) {
        notFound();
    }

    return (
        <Suspense fallback={<EditPortfolioSkeleton />}>
            <PortfolioEditor initialData={portfolioData} />
        </Suspense>
    )
}
