
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

async function getContent() {
    const supabase = createClient();
    const { data } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'product-home-office')
        .single();
    
    if (!data) {
        notFound();
    }
    
    const content: { [key: string]: any } = {};
    for (const section of data.sections) {
        const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
        content[sectionKey] = {
            ...section.content,
            visible: section.visible,
            title: section.title,
        };
    }
    
    return { ...content, meta: { title: data.meta_title, description: data.meta_description } };
}

export default async function HomeOfficePage() {
  const pageContent = await getContent();

  if (!pageContent || !pageContent.productDetails?.visible) {
    notFound();
  }

  const { productDetails } = pageContent;

  return (
    <div className="container mx-auto px-4 py-16">
      <Card>
        <CardHeader>
          <CardTitle className="text-3xl text-center">{productDetails.title}</CardTitle>
        </CardHeader>
        <CardContent className="text-center">
          <Image
            src={productDetails.image}
            alt={productDetails.title}
            data-ai-hint="home office"
            width={600}
            height={400}
            className="rounded-lg shadow-lg mx-auto mb-8"
          />
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
            {productDetails.description}
          </p>
          <Button asChild size="lg">
            <Link href="/get-a-quote">Get a Free Quote</Link>
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
