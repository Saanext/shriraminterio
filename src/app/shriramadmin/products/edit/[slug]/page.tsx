

import { Suspense } from 'react';
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { Skeleton } from '@/components/ui/skeleton';
import { ProductEditor } from '@/components/product-editor';

async function getProductData(slug: string) {
    const supabase = createClient();
    const { data, error } = await supabase
        .from('products')
        .select('*')
        .eq('slug', slug)
        .single();

    if (error || !data) {
        console.error('Error fetching product data:', error);
        return null;
    }
    
    return data;
}

function EditProductSkeleton() {
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


export default async function EditProductPage({ params }: { params: { slug: string } }) {
    const productSlug = params.slug;

    if (!productSlug) {
        notFound();
    }

    const productData = await getProductData(productSlug);
     if (!productData) {
        notFound();
    }

    return (
        <Suspense fallback={<EditProductSkeleton />}>
            <ProductEditor initialData={productData} />
        </Suspense>
    )
}
