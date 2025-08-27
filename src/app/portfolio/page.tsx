
'use client';

import { useState, useEffect } from 'react';
import Image from 'next/image';
import { Card, CardContent } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { createClient } from '@/lib/supabase/client';

export default function PortfolioPage() {
  const [activeTab, setActiveTab] = useState('All');
  const [projects, setProjects] = useState<any[]>([]);
  const [partners, setPartners] = useState<any[]>([]);
  const [categories, setCategories] = useState<string[]>(['All']);

  useEffect(() => {
    const fetchContent = async () => {
        const supabase = createClient();
        const { data: pageData } = await supabase
            .from('pages')
            .select('*, sections(*)')
            .eq('slug', 'portfolio')
            .single();

        if (pageData) {
            const projectsSection = pageData.sections.find((s: any) => s.type === 'projects_gallery');
            const partnersSection = pageData.sections.find((s: any) => s.type === 'partners');

            if (projectsSection) {
                const fetchedProjects = projectsSection.content.projects || [];
                setProjects(fetchedProjects);
                const uniqueCategories = ['All', ...Array.from(new Set(fetchedProjects.map((p: any) => p.category))) as string[]];
                setCategories(uniqueCategories);
            }

            if (partnersSection) {
                setPartners(partnersSection.content.items || []);
            }
        }
    };

    fetchContent();
  }, []);

  const filteredProjects = activeTab === 'All'
    ? projects
    : projects.filter((p) => p.category === activeTab);

  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Our Portfolio</h1>
          <p className="text-lg text-muted-foreground mt-2">A glimpse into the spaces we have transformed.</p>
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full flex flex-col items-center">
          <TabsList className="mb-10 flex-wrap h-auto justify-center">
            {categories.map((category) => (
              <TabsTrigger key={category} value={category} className="m-1">
                {category}
              </TabsTrigger>
            ))}
          </TabsList>
          
          <div className="w-full">
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
              {filteredProjects.map((project) => (
                <Card key={project.id} className="overflow-hidden group transition-shadow duration-300 hover:shadow-xl">
                  <div className="relative aspect-video">
                    <Image
                      src={project.imageSrc}
                      alt={project.title}
                      layout="fill"
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
          </div>
        </Tabs>
      </div>
      <section className="py-16 md:py-24 bg-secondary">
          <div className="container mx-auto px-4">
              <div className="text-center mb-12">
                  <div className="flex justify-center items-center mb-2">
                      <div className="border-t border-primary w-12"></div>
                      <p className="text-sm text-primary font-bold tracking-widest mx-4">MEET OUR PARTNERS</p>
                      <div className="border-t border-primary w-12"></div>
                  </div>
                  <h2 className="text-3xl md:text-4xl font-bold">Our Partners</h2>
              </div>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-8 items-center">
                  {partners.map((partner) => (
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
    </div>
  );
}
