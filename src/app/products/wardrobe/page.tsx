
import Image from 'next/image';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { CheckCircle } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';

const wardrobeImages = [
  { src: 'https://images.unsplash.com/photo-1677864944822-e3ca06e317c1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxzbGlkaW5nJTIwZG9vciUyMHdhcmRyb2JlfGVufDB8fHx8MTc1NTcxNTY2MHww&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Sliding door wardrobe', dataAiHint: 'sliding wardrobe' },
  { src: '/wardrobe-2.png', alt: 'Walk-in closet', dataAiHint: 'walk-in closet' },
  { src: '/wardrobe-3.png', alt: 'Hinged door wardrobe with mirror', dataAiHint: 'hinged wardrobe' },
  { src: '/wardrobe-4.png', alt: 'Free standing wardrobe unit', dataAiHint: 'freestanding wardrobe' },
];

const features = [
  'Free-Standing & Built-In Options',
  'Smooth Sliding & Hinged Doors',
  'Variety of Finishes and Materials',
  'Smart Internal Configurations',
  'Durable and Termite-Resistant Plywood',
  'Integrated Lighting and Mirrors',
];

export default function WardrobePage() {
  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
          <div className="flex flex-col justify-center order-2 lg:order-1">
            <h1 className="text-4xl md:text-5xl font-bold">Custom Wardrobes</h1>
            <p className="mt-4 text-lg text-muted-foreground">
              Our wardrobes are thoughtfully designed to offer maximum storage while enhancing the aesthetics of your bedroom. From sleek sliding doors to classic hinged designs, we create personalized storage solutions that cater to your specific needs.
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
                <Link href="/portfolio">Design Your Wardrobe</Link>
              </Button>
            </div>
          </div>
          <div className="order-1 lg:order-2">
            <Carousel className="w-full">
              <CarouselContent>
                {wardrobeImages.map((image, index) => (
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
        </div>
      </div>
    </div>
  );
}
