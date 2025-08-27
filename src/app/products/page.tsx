

import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { ArrowRight } from 'lucide-react';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'products')
        .single();
    
    if (!page) {
        notFound();
    }
    
    const content: { [key: string]: any } = {};
    for (const section of page.sections) {
        const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
        content[sectionKey] = {
            ...section.content,
            visible: section.visible,
            title: section.title,
        };
    }
    
    return { ...content, meta: { title: page.meta_title, description: page.meta_description } };
}

export default async function ProductsPage() {
  const pageContent = await getContent();

  if (!pageContent) {
    notFound();
  }

  const { header, productList } = pageContent;

  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">{header.title}</h1>
          <p className="text-lg text-muted-foreground mt-2">{header.subtitle}</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {productList.products.map((product: any) => (
            <Link href={product.href} key={product.name} className="group block">
              <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                <div className="relative h-64">
                  <Image
                    src={product.imageSrc}
                    alt={product.name}
                    fill
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint={product.dataAiHint}
                  />
                </div>
                <CardContent className="p-6 flex flex-col flex-grow">
                  <h2 className="text-2xl font-bold font-headline">{product.name}</h2>
                  <p className="mt-2 text-muted-foreground flex-grow">{product.description}</p>
                  <div className="mt-4 flex items-center font-semibold text-primary">
                    Explore More <ArrowRight className="ml-2 h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" />
                  </div>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}
