

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
    
    return { ...content, meta: { title: page.meta_title, description: page.meta_description } };
}

export default async function ServicesPage() {
    const pageContent = await getContent();

    if (!pageContent) {
        notFound();
    }
    
    const { header, ourServices, detailedServices } = pageContent;

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

      {detailedServices.visible && (
      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
             <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {detailedServices.services.map((service: any) => (
                    <Link href={service.href} key={service.title} className="group block">
                        <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                            <div className="relative h-60">
                            <Image
                                src={service.imageSrc}
                                alt={service.title}
                                fill
                                objectFit="cover"
                                className="transition-transform duration-500 group-hover:scale-105"
                                data-ai-hint={service.dataAiHint}
                            />
                            </div>
                            <CardContent className="p-6 text-center flex-grow flex flex-col justify-between">
                               <div>
                                 <h2 className="text-xl font-bold font-headline mb-4">{service.title}</h2>
                               </div>
                                <div className="mt-4 flex items-center justify-center font-semibold text-primary">
                                    Read More <ArrowRight className="ml-2 h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" />
                                </div>
                            </CardContent>
                        </Card>
                    </Link>
                ))}
            </div>
        </div>
      </section>
      )}
    </div>
  );
}
