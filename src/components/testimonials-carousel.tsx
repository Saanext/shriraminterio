
'use client';

import Image from 'next/image';
import { Card } from '@/components/ui/card';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import Autoplay from "embla-carousel-autoplay";

export function TestimonialsCarousel({ testimonials }: { testimonials: any[] }) {
    return (
        <Carousel 
            className="w-full max-w-4xl mx-auto"
            plugins={[
                Autoplay({
                  delay: 5000,
                }),
            ]}
        >
            <CarouselContent>
                {testimonials.map((testimonial: any, index: number) => (
                    <CarouselItem key={index}>
                        <Card className="overflow-hidden">
                            <div className="grid grid-cols-1 md:grid-cols-2">
                                <div className="relative aspect-video md:aspect-[4/3]">
                                    <Image 
                                        src={testimonial.image} 
                                        alt={testimonial.name} 
                                        fill 
                                        className="object-cover"
                                        data-ai-hint="happy client family"
                                    />
                                </div>
                                <div className="flex flex-col justify-center p-8">
                                    <blockquote className="text-lg text-muted-foreground border-l-4 border-primary pl-4 italic">
                                        {testimonial.quote}
                                    </blockquote>
                                    <p className="mt-4 font-bold text-right">{testimonial.name}</p>
                                </div>
                            </div>
                        </Card>
                    </CarouselItem>
                ))}
            </CarouselContent>
            <CarouselPrevious className="left-[-50px] hidden sm:flex" />
            <CarouselNext className="right-[-50px] hidden sm:flex" />
        </Carousel>
    );
}
