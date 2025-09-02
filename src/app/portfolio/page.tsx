
import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import { ArrowRight } from 'lucide-react';

async function getPortfolioItems() {
    const supabase = createClient();
    const { data, error } = await supabase.from('portfolio').select('*').order('created_at', { ascending: false });
    if (error) {
        console.error("Error fetching portfolio items:", error);
        return [];
    }
    return data;
}

export default async function PortfolioPage() {
  const items = await getPortfolioItems();

  if (!items) {
    notFound();
  }

  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Our Portfolio</h1>
          <p className="text-lg text-muted-foreground mt-2">A glimpse into the spaces we have transformed.</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {items.map((item) => (
            <Link href={`/portfolio/${item.slug}`} key={item.id} className="group block">
              <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                <div className="relative h-64">
                  <Image
                    src={item.main_image}
                    alt={item.title}
                    fill
                    className="object-cover transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint="portfolio project"
                  />
                </div>
                <CardContent className="p-6 flex flex-col flex-grow">
                  <h2 className="text-2xl font-bold font-headline">{item.title}</h2>
                   <div 
                      className="mt-2 text-muted-foreground flex-grow prose-sm line-clamp-3" 
                      dangerouslySetInnerHTML={{ __html: item.content || ''}} 
                    />
                  <div className="mt-4 flex items-center font-semibold text-primary">
                    View Project <ArrowRight className="ml-2 h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" />
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
