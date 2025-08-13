import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { CookingPot, Sofa, Paintbrush, Bed, Tv, Home } from 'lucide-react';
import type { LucideIcon } from 'lucide-react';

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

export default function ServicesPage() {
  return (
    <div className="bg-secondary">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Our Services</h1>
          <p className="text-lg text-muted-foreground mt-2">Comprehensive design solutions for every corner of your home.</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {services.map((service) => (
            <Card key={service.title} className="flex flex-col text-center transition-all duration-300 hover:shadow-xl hover:-translate-y-2">
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
    </div>
  );
}
