
import Image from 'next/image';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { CheckCircle } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';

const kitchenImages = [
  { src: 'https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Modern L-shaped kitchen', dataAiHint: 'l-shaped kitchen' },
  { src: 'https://images.unsplash.com/photo-1539922980492-38f6673af8dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Minimalist island kitchen', dataAiHint: 'island kitchen' },
  { src: 'https://images.unsplash.com/photo-1585261450736-67d578ff00b4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHx1JTIwc2hhcGVkJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTU1NDN8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'U-shaped kitchen with wooden finish', dataAiHint: 'u-shaped kitchen' },
  { src: '/kitchen-4.png', alt: 'Parallel kitchen layout', dataAiHint: 'parallel kitchen' },
];

const features = [
  'High-quality Plywood & MDF',
  'Premium Laminate & Acrylic Finishes',
  'German-engineered Hardware',
  'Smart Storage Solutions',
  'Heat and Scratch Resistant Countertops',
  'Customizable Layouts and Colors',
];

export default function KitchenPage() {
  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
          <div>
            <Carousel className="w-full">
              <CarouselContent>
                {kitchenImages.map((image, index) => (
                  <CarouselItem key={index}>
                    <div className="p-1">
                      <Card>
                        <CardContent className="flex aspect-[3/2] items-center justify-center p-0 overflow-hidden rounded-lg">
                          <Image
                            src={image.src}
                            alt={image.alt}
                            width={1200}
                            height={800}
                            className="object-cover w-full h-full"
                            data-ai-hint={image.dataAiHint}
                          />
                        </CardContent>
                      </Card>
                    </div>
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious className="left-4" />
              <CarouselNext className="right-4" />
            </Carousel>
          </div>
          <div className="flex flex-col justify-center">
            <h1 className="text-4xl md:text-5xl font-bold">Modular Kitchens</h1>
            <p className="mt-4 text-lg text-muted-foreground">
              At Shriram Interio, we design modular kitchens that are a perfect blend of elegance and ergonomics. Our kitchens are built to last, using premium materials and hardware, ensuring a seamless cooking experience every day.
            </p>
            <div className="mt-8">
              <h3 className="text-2xl font-bold font-headline mb-4">Key Features</h3>
              <ul className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {features.map((feature, index) => (
                  <li key={index} className="flex items-center">
                    <CheckCircle className="h-5 w-5 text-primary mr-2 flex-shrink-0" />
                    <span>{feature}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="mt-10">
              <Button asChild size="lg">
                <Link href="/portfolio">View Our Work</Link>
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
