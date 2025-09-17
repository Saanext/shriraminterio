
import Image from 'next/image';
import { notFound } from 'next/navigation';
import { createClient as createServerClient } from '@/lib/supabase/server';
import { createClient as createBrowserClient } from '@/lib/supabase/client';
import { ProductDetailClient } from '@/components/product-detail-client';
import type { Metadata, ResolvingMetadata } from 'next';

type Props = {
  params: { slug: string }
}

async function getProduct(slug: string) {
  const supabase = createServerClient();
  const { data: product, error } = await supabase
    .from('products')
    .select('*')
    .eq('slug', slug)
    .single();

  if (error || !product) {
    notFound();
  }
  return product;
}

export async function generateMetadata(
  { params }: Props,
  parent: ResolvingMetadata
): Promise<Metadata> {
  const product = await getProduct(params.slug);
 
  return {
    title: product.name,
    description: product.short_description,
  }
}


export default async function ProductDetailPage({ params }: { params: { slug: string }}) {
  const product = await getProduct(params.slug);

  if(!product) {
    notFound();
  }

  return <ProductDetailClient product={product} />
}

export async function generateStaticParams() {
    const supabase = createBrowserClient();
    const { data: products } = await supabase.from('products').select('slug');

    return products?.map(({ slug }) => ({
        slug,
    })) || [];
}
