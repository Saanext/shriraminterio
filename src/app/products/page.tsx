import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { ArrowRight } from 'lucide-react';

const products = [
  {
    name: 'Modular Kitchens',
    href: '/products/kitchen',
    imageSrc: 'https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'modern kitchen',
    description: 'Explore our stunning range of modular kitchens, designed for style and efficiency.',
  },
  {
    name: 'Wardrobes',
    href: '/products/wardrobe',
    imageSrc: 'https://images.unsplash.com/photo-1614631446501-abcf76949eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'modern wardrobe',
    description: 'Discover custom wardrobe solutions that maximize space and complement your decor.',
  },
  {
    name: 'Bedroom',
    href: '/products/bedroom',
    imageSrc: '/b1.jpg',
    dataAiHint: 'modern bedroom',
    description: 'Create your dream sanctuary with our bespoke bedroom interior designs.',
  },
  {
    name: 'Living Room',
    href: '/products/living-room',
    imageSrc: '/b2.jpg',
    dataAiHint: 'living room',
    description: 'Design inviting and functional living spaces for family and friends.',
  },
  {
    name: 'Bathroom',
    href: '/products/bathroom',
    imageSrc: '/bath.jpg',
    dataAiHint: 'modern bathroom',
    description: 'Stylish and practical bathroom designs for a refreshing experience.',
  },
  {
    name: 'Space Saving Furniture',
    href: '/products/space-saving-furniture',
    imageSrc: '/SlidingWardrobe.jpg',
    dataAiHint: 'space saving',
    description: 'Maximize your living area with our innovative and smart furniture solutions.',
  },
  {
    name: 'Home Office',
    href: '/products/home-office',
    imageSrc: '/kitchen.jpg',
    dataAiHint: 'home office',
    description: 'Productive and comfortable home office setups tailored to your needs.',
  },
];

export default function ProductsPage() {
  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Our Products</h1>
          <p className="text-lg text-muted-foreground mt-2">Crafted with precision, designed for life.</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {products.map((product) => (
            <Link href={product.href} key={product.name} className="group block">
              <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                <div className="relative h-64">
                  <Image
                    src={product.imageSrc}
                    alt={product.name}
                    fill
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint={product.dataAiHint}
                  />
                </div>
                <CardContent className="p-6 flex flex-col flex-grow">
                  <h2 className="text-2xl font-bold font-headline">{product.name}</h2>
                  <p className="mt-2 text-muted-foreground flex-grow">{product.description}</p>
                  <div className="mt-4 flex items-center font-semibold text-primary">
                    Explore More <ArrowRight className="ml-2 h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" />
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
