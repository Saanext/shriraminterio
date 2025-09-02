

import Image from 'next/image';
import { Card, CardContent } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'portfolio')
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
            title: section.content?.title || section.title, // Use content.title if available
        };
    }
    
    return { ...content, meta: { title: page.meta_title, description: page.meta_description } };
}

export default async function PortfolioPage() {
  const pageContent = await getContent();

  if (!pageContent) {
    notFound();
  }

  const { projectsGallery, partners } = pageContent;
  const projects = projectsGallery?.projects || [];
  const partnerItems = partners?.items || [];
  const categories = ['All', ...Array.from(new Set(projects.map((p: any) => p.category))) as string[]];

  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Our Portfolio</h1>
          <p className="text-lg text-muted-foreground mt-2">A glimpse into the spaces we have transformed.</p>
        </div>

        <Tabs defaultValue="All" className="w-full">
          <TabsList className="mb-10 flex-wrap h-auto justify-center">
            {categories.map((category) => (
              <TabsTrigger key={category} value={category} className="m-1">
                {category}
              </TabsTrigger>
            ))}
          </TabsList>
          
          {categories.map(category => (
            <TabsContent key={category} value={category}>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                {(category === 'All' ? projects : projects.filter((p: any) => p.category === category)).map((project: any) => (
                    <Card key={project.id} className="overflow-hidden group transition-shadow duration-300 hover:shadow-xl">
                    <div className="relative aspect-video">
                        <Image
                        src={project.imageSrc}
                        alt={project.title}
                        fill
                        objectFit="cover"
                        className="transition-transform duration-500 group-hover:scale-105"
                        data-ai-hint={project.dataAiHint}
                        />
                        <div className="absolute inset-0 bg-black/20 group-hover:bg-black/40 transition-colors duration-300" />
                        <div className="absolute bottom-0 left-0 p-4">
                        <h3 className="text-white text-xl font-bold font-headline transition-transform duration-300 group-hover:-translate-y-1">{project.title}</h3>
                        </div>
                    </div>
                    </Card>
                ))}
                </div>
            </TabsContent>
          ))}
        </Tabs>
      </div>
      
      {partners.visible && (
      <section className="py-16 md:py-24 bg-secondary">
          <div className="container mx-auto px-4">
              <div className="text-center mb-12">
                  <div className="flex justify-center items-center mb-2">
                      <div className="border-t border-primary w-12"></div>
                      <p className="text-sm text-primary font-bold tracking-widest mx-4">{partners.subtitle}</p>
                      <div className="border-t border-primary w-12"></div>
                  </div>
                  <h2 className="text-3xl md:text-4xl font-bold">{partners.title}</h2>
              </div>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-8 items-center">
                  {partnerItems.map((partner: any) => (
                      <div key={partner.name} className="flex justify-center">
                          <Image
                              src={partner.logoSrc}
                              alt={`${partner.name} Logo`}
                              width={150}
                              height={75}
                              className="object-contain"
                              data-ai-hint="partner logo"
                          />
                      </div>
                  ))}
              </div>
          </div>
      </section>
      )}
    </div>
  );
}
