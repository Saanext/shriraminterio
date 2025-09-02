
import Image from 'next/image';
import { notFound } from 'next/navigation';
import { createClient as createServerClient } from '@/lib/supabase/server';
import { createClient as createBrowserClient } from '@/lib/supabase/client';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Card, CardContent } from '@/components/ui/card';

async function getPortfolioItem(slug: string) {
  const supabase = createServerClient();
  const { data, error } = await supabase
    .from('portfolio')
    .select('*')
    .eq('slug', slug)
    .single();

  if (error || !data) {
    notFound();
  }
  return data;
}

export default async function PortfolioItemPage({ params }: { params: { slug: string } }) {
  const item = await getPortfolioItem(params.slug);

  const galleryImages = [item.main_image, ...(item.gallery || [])].filter(Boolean);

  return (
    <div className="bg-background">
      {/* Hero Slider Section */}
      <section className="bg-secondary">
        <div className="container mx-auto px-4 py-16">
          <Carousel className="w-full">
            <CarouselContent>
              {galleryImages.map((image: string, index: number) => (
                <CarouselItem key={index}>
                  <Card className="overflow-hidden">
                    <CardContent className="flex aspect-video items-center justify-center p-0">
                      <Image
                        src={image}
                        alt={`${item.title} - image ${index + 1}`}
                        width={1200}
                        height={675}
                        className="object-cover w-full h-full"
                        data-ai-hint="portfolio project image"
                      />
                    </CardContent>
                  </Card>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious className="left-4" />
            <CarouselNext className="right-4" />
          </Carousel>
        </div>
      </section>

      {/* Content Section */}
      <section className="container mx-auto px-4 py-16">
        <h1 className="text-4xl md:text-5xl font-bold text-center mb-8">{item.title}</h1>
        <div
          className="prose max-w-4xl mx-auto text-muted-foreground"
          dangerouslySetInnerHTML={{ __html: item.content || '' }}
        />
      </section>
    </div>
  );
}

export async function generateStaticParams() {
    const supabase = createBrowserClient();
    const { data: items } = await supabase.from('portfolio').select('slug');

    return items?.map(({ slug }) => ({
        slug,
    })) || [];
}
