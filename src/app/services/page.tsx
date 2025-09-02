

import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { CookingPot, Sofa, Paintbrush, Bed, Tv, Home, ArrowRight } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';
import Image from 'next/image';
import Link from 'next/link';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

export const dynamic = 'force-dynamic';

type Service = {
  icon: React.ReactElement<LucideIcon>;
  title: string;
  description: string;
};

const serviceIcons: { [key: string]: React.ReactElement<LucideIcon> } = {
    'Modular Kitchen Design': <CookingPot className="w-10 h-10 text-primary" />,
    'Wardrobe & Storage Solutions': <Sofa className="w-10 h-10 text-primary" />,
    'Bedroom Interiors': <Bed className="w-10 h-10 text-primary" />,
    'Living Area Design': <Tv className="w-10 h-10 text-primary" />,
    'Exterior Design Services': <Paintbrush className="w-10 h-10 text-primary" />,
    'Full Home Interiors': <Home className="w-10 h-10 text-primary" />,
};

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'services')
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
            title: section.content?.title || section.title,
        };
    }
    
    const { data: portfolioItems, error } = await supabase.from('portfolio').select('*').order('created_at', { ascending: false });
    if (error) {
        console.error("Error fetching portfolio items:", error);
    }
    
    return { ...content, portfolioItems: portfolioItems || [], meta: { title: page.meta_title, description: page.meta_description } };
}

export default async function ServicesPage() {
    const { header, ourServices, portfolioItems } = await getContent();

  return (
    <div className="bg-background">
      {header.visible && (
      <section className="bg-secondary">
          <div className="container mx-auto px-4 py-16">
            <div className="text-center mb-12">
              <h1 className="text-4xl md:text-5xl font-bold">{header.title}</h1>
              <p className="text-lg text-muted-foreground mt-2">{header.subtitle}</p>
            </div>
            {ourServices.visible && (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {ourServices.services.map((service: any) => (
                <Card key={service.title} className="flex flex-col text-center transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                  <CardHeader className="items-center">
                    {serviceIcons[service.title]}
                    <CardTitle className="mt-4 text-2xl">{service.title}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p className="text-muted-foreground">{service.description}</p>
                  </CardContent>
                </Card>
              ))}
            </div>
            )}
          </div>
      </section>
      )}

      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
            <div className="text-center mb-12">
                <h2 className="text-4xl md:text-5xl font-bold">Our Portfolio</h2>
                <p className="text-lg text-muted-foreground mt-2">A glimpse into the spaces we have transformed.</p>
            </div>
             <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {portfolioItems.map((item: any) => (
                    <Link href={`/portfolio/${item.slug}`} key={item.id} className="group block">
                        <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                            <div className="relative h-60">
                            <Image
                                src={item.main_image}
                                alt={item.title}
                                fill
                                objectFit="cover"
                                className="transition-transform duration-500 group-hover:scale-105"
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
      </section>
    </div>
  );
}
