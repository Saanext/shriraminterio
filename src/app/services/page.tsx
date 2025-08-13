import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { CookingPot, Sofa, Paintbrush, Bed, Tv, Home, ArrowRight, Lamp, Building, Draftsman } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';
import Image from 'next/image';
import Link from 'next/link';

type Service = {
  icon: React.ReactElement<LucideIcon>;
  title: string;
  description: string;
};

const services: Service[] = [
  {
    icon: <CookingPot className="w-10 h-10 text-primary" />,
    title: 'Modular Kitchen Design',
    description: 'We specialize in creating ergonomic and stylish modular kitchens tailored to your cooking habits and space.',
  },
  {
    icon: <Sofa className="w-10 h-10 text-primary" />,
    title: 'Wardrobe & Storage Solutions',
    description: 'Custom-designed wardrobes and storage units that maximize space and organize your life beautifully.',
  },
  {
    icon: <Bed className="w-10 h-10 text-primary" />,
    title: 'Bedroom Interiors',
    description: 'Transform your bedroom into a serene and personal sanctuary with our bespoke design solutions.',
  },
  {
    icon: <Tv className="w-10 h-10 text-primary" />,
    title: 'Living Area Design',
    description: 'From entertainment units to seating arrangements, we design living spaces that are both functional and inviting.',
  },
  {
    icon: <Paintbrush className="w-10 h-10 text-primary" />,
    title: 'Exterior Design Services',
    description: 'Enhance your home\'s curb appeal with our expert services in exterior aesthetics, including finishes and lighting.',
  },
  {
    icon: <Home className="w-10 h-10 text-primary" />,
    title: 'Full Home Interiors',
    description: 'A comprehensive, end-to-end design service for your entire home, ensuring a cohesive and harmonious look.',
  },
];

const detailedServices = [
    {
        imageSrc: 'https://placehold.co/800x600.png',
        dataAiHint: 'modern house exterior',
        title: 'Exterior Design Services',
        href: '#',
    },
    {
        imageSrc: 'https://placehold.co/800x600.png',
        dataAiHint: 'commercial office interior',
        title: 'Commercial and Residential Interior Design Services',
        href: '#',
    },
    {
        imageSrc: 'https://placehold.co/800x600.png',
        dataAiHint: 'living room fireplace',
        title: 'Design Concept Services',
        href: '#',
    },
    {
        imageSrc: 'https://placehold.co/800x600.png',
        dataAiHint: 'modern kitchen interior',
        title: 'Modular Kitchen Interior Design',
        href: '#',
    },
    {
        imageSrc: 'https://placehold.co/800x600.png',
        dataAiHint: 'spacious living room',
        title: 'Room Space Planning Services',
        href: '#',
    },
    {
        imageSrc: 'https://placehold.co/800x600.png',
        dataAiHint: 'modern apartment interior',
        title: 'Turnkey Services',
        href: '#',
    },
];

export default function ServicesPage() {
  return (
    <div className="bg-background">
      <section className="bg-secondary">
          <div className="container mx-auto px-4 py-16">
            <div className="text-center mb-12">
              <h1 className="text-4xl md:text-5xl font-bold">Our Services</h1>
              <p className="text-lg text-muted-foreground mt-2">Comprehensive design solutions for every corner of your home.</p>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {services.map((service) => (
                <Card key={service.title} className="flex flex-col text-center transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                  <CardHeader className="items-center">
                    {service.icon}
                    <CardTitle className="mt-4 text-2xl">{service.title}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p className="text-muted-foreground">{service.description}</p>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
      </section>

      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
             <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {detailedServices.map((service) => (
                    <Link href={service.href} key={service.title} className="group block">
                        <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                            <div className="relative h-60">
                            <Image
                                src={service.imageSrc}
                                alt={service.title}
                                layout="fill"
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
    </div>
  );
}