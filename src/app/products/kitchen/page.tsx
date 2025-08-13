import Image from 'next/image';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { CheckCircle } from 'lucide-react';

const kitchenImages = [
  { src: 'https://placehold.co/1200x800.png', alt: 'Modern L-shaped kitchen', dataAiHint: 'l-shaped kitchen' },
  { src: 'https://placehold.co/1200x800.png', alt: 'Minimalist island kitchen', dataAiHint: 'island kitchen' },
  { src: 'https://placehold.co/1200x800.png', alt: 'U-shaped kitchen with wooden finish', dataAiHint: 'u-shaped kitchen' },
  { src: 'https://placehold.co/1200x800.png', alt: 'Parallel kitchen layout', dataAiHint: 'parallel kitchen' },
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
                <Link href="/design-inspiration">Get a Free Design Quote</Link>
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
import { Card, CardContent } from '@/components/ui/card';
