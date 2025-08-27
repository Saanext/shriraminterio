
import Image from 'next/image';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { CheckCircle, Zap, Gem, Palette } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

const kitchenImages = [
  { src: 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg', alt: 'Modern L-shaped kitchen', dataAiHint: 'l-shaped kitchen' },
  { src: 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg', alt: 'Minimalist island kitchen', dataAiHint: 'island kitchen' },
  { src: 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg', alt: 'U-shaped kitchen with wooden finish', dataAiHint: 'u-shaped kitchen' },
  { src: 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-4.png', alt: 'Parallel kitchen layout', dataAiHint: 'parallel kitchen' },
];

const features = [
  'High-quality Plywood & MDF',
  'Premium Laminate & Acrylic Finishes',
  'German-engineered Hardware',
  'Smart Storage Solutions',
  'Heat and Scratch Resistant Countertops',
  'Customizable Layouts and Colors',
];

const whyChooseUs = [
    {
        icon: <Zap className="w-10 h-10 text-primary" />,
        title: 'Space Optimization',
        description: 'Our modular designs make the most of every inch, providing smart storage solutions for a clutter-free and efficient kitchen.',
    },
    {
        icon: <Gem className="w-10 h-10 text-primary" />,
        title: 'Superior Quality & Durability',
        description: 'We use only premium, long-lasting materials and top-of-the-line hardware to ensure your kitchen stands the test of time.',
    },
    {
        icon: <Palette className="w-10 h-10 text-primary" />,
        title: 'Aesthetic Flexibility',
        description: 'With a vast range of finishes, colors, and styles, we create kitchens that are a true reflection of your personal taste.',
    },
]

export default function KitchenPage() {
  return (
    <div className="bg-background">
      <section className="container mx-auto px-4 py-16">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
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
              Discover the heart of your home with a Shriram Interio modular kitchen. We design beautiful, functional spaces that blend elegance and ergonomics, tailored to your unique lifestyle. Our kitchens are built to last, using premium materials and hardware for a seamless cooking experience every day.
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
                <Link href="/get-a-quote">Get a Free Quote</Link>
              </Button>
            </div>
          </div>
        </div>
      </section>

      <section className="py-16 md:py-24 bg-secondary">
            <div className="container mx-auto px-4">
                <div className="text-center mb-12">
                    <h2 className="text-3xl md:text-4xl font-bold">Why Choose Our Kitchens?</h2>
                    <p className="text-lg text-muted-foreground mt-2">Experience the perfect fusion of functionality and style.</p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    {whyChooseUs.map((item, index) => (
                        <Card key={index} className="text-center p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                             <CardContent className="flex flex-col items-center">
                                {item.icon}
                                <h3 className="mt-4 text-xl font-bold">{item.title}</h3>
                                <p className="text-muted-foreground mt-2">{item.description}</p>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            </div>
        </section>
    </div>
  );
}
