
'use client';

import { useState } from 'react';
import Image from 'next/image';
import { Card, CardContent } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { cn } from '@/lib/utils';

const projects = [
  {
    id: 1,
    category: 'Living Areas',
    title: 'Modern Minimalist Living',
    imageSrc: '/kitchen.jpg',
    dataAiHint: 'minimalist living room',
  },
  {
    id: 2,
    category: 'Kitchens',
    title: 'Elegant U-Shaped Kitchen',
    imageSrc: '/kitchen2.jpg',
    dataAiHint: 'elegant kitchen',
  },
  {
    id: 3,
    category: 'Living Areas',
    title: 'Cozy Scandinavian Retreat',
    imageSrc: '/kitchn1.jpg',
    dataAiHint: 'scandinavian living room',
  },
  {
    id: 4,
    category: 'Wardrobes',
    title: 'Sleek Sliding Wardrobe',
    imageSrc: '/r1.jpg',
    dataAiHint: 'sliding wardrobe',
  },
  {
    id: 5,
    category: 'Kitchens',
    title: 'Rustic Farmhouse Kitchen',
    imageSrc: '/SlidingWardrobe.jpg',
    dataAiHint: 'farmhouse kitchen',
  },
  {
    id: 6,
    category: 'Wardrobes',
    title: 'Spacious Walk-in Closet',
    imageSrc: '/b1.jpg',
    dataAiHint: 'walk-in closet',
  },
   {
    id: 7,
    category: 'Living Areas',
    title: 'Industrial Loft Space',
    imageSrc: '/industrial.jpg',
    dataAiHint: 'industrial loft',
  },
  {
    id: 8,
    category: 'Kitchens',
    title: 'Contemporary Galley Kitchen',
    imageSrc: '/kitchengallery.jpg',
    dataAiHint: 'galley kitchen',
  },
];

const partners = [
    { name: 'Ebco', logoSrc: '/ebco.jpg' },
    { name: 'Hettich', logoSrc: '/hettich.png' },
    { name: 'Royale Touche', logoSrc: '/Royal-Touch.jpg' },
    { name: 'Hafele', logoSrc: '/hafele.png' },
    { name: 'Godrej', logoSrc: '/godrej.png' },
];

const categories = ['All', 'Living Areas', 'Kitchens', 'Wardrobes'];

export default function PortfolioPage() {
  const [activeTab, setActiveTab] = useState('All');

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
          <TabsList className="mb-10">
            {categories.map((category) => (
              <TabsTrigger key={category} value={category}>
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
