
'use client';

import Image from 'next/image';
import { notFound } from 'next/navigation';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { CheckCircle, ShoppingCart } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';
import { useQuoteSidebar } from '@/components/quote-sidebar-provider';

export function ProductDetailClient({ product }: { product: any }) {
  const { setIsOpen } = useQuoteSidebar();

  if (!product) {
    notFound();
  }

  const galleryImages = [product.main_image, ...(product.gallery || [])];

  return (
    <div className="bg-background">
      <section className="container mx-auto px-4 py-16">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-start">
          <div>
            <Carousel className="w-full">
              <CarouselContent>
                {galleryImages.map((image: any, index: number) => (
                  <CarouselItem key={index}>
                    <Card className="overflow-hidden">
                      <CardContent className="flex aspect-video items-center justify-center p-0">
                        <Image
                          src={image}
                          alt={`${product.name} - image ${index + 1}`}
                          width={1200}
                          height={800}
                          className="object-cover w-full h-full"
                          data-ai-hint={product.name.toLowerCase()}
                        />
                      </CardContent>
                    </Card>
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious className="left-4" />
              <CarouselNext className="right-4" />
            </Carousel>
          </div>
          <div className="flex flex-col justify-center">
            <h1 className="text-4xl md:text-5xl font-bold">{product.name}</h1>
            <p className="mt-4 text-lg text-muted-foreground">
              {product.long_description}
            </p>
            <div className="mt-8">
              <h3 className="text-2xl font-bold font-headline mb-4">Key Features</h3>
              <ul className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                {(product.features || []).map((feature: string, index: number) => (
                  <li key={index} className="flex items-center">
                    <CheckCircle className="h-5 w-5 text-primary mr-2 flex-shrink-0" />
                    <span>{feature}</span>
                  </li>
                ))}
              </ul>
            </div>
            <div className="mt-10 flex flex-col sm:flex-row gap-4">
              <Button onClick={() => setIsOpen(true)} size="lg">
                Get a Free Quote
              </Button>
              {product.amazon_link && (
                <Button asChild size="lg" variant="outline">
                  <Link href={product.amazon_link} target="_blank" rel="noopener noreferrer">
                    <ShoppingCart className="mr-2 h-5 w-5" /> Buy on Amazon
                  </Link>
                </Button>
              )}
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
