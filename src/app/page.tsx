import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Video, Smartphone, CircleDollarSign, Tv } from 'lucide-react';

const expertise = [
  {
    icon: <Video className="w-8 h-8 text-primary" />,
    title: 'Live 3D Designs',
    description: 'Experience the future of design with our 3D Interior Design Services tailored to your floor plan.',
  },
  {
    icon: <Smartphone className="w-8 h-8 text-primary" />,
    title: 'Contactless Experience',
    description: 'No stepping out. Design your home interiors at the comfort of your home.',
  },
  {
    icon: <CircleDollarSign className="w-8 h-8 text-primary" />,
    title: 'Instant Pricing',
    description: 'Complete price transparency and budget-friendly solutions.',
  },
  {
    icon: <Tv className="w-8 h-8 text-primary" />,
    title: 'Expertise & Passion',
    description: 'We bring a wealth of expertise and passion for creating interiors at your comfort.',
  }
];

const testimonials = [
  {
    name: 'Anjali P.',
    review: 'Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish. Highly recommended!',
    avatar: 'AP',
    image: 'https://placehold.co/100x100.png',
  },
  {
    name: 'Rohan S.',
    review: 'The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations. Our living room is now our favorite spot.',
    avatar: 'RS',
    image: 'https://placehold.co/100x100.png',
  },
  {
    name: 'Meera K.',
    review: 'Excellent service and stunning wardrobe design. The quality is top-notch, and the installation was seamless. Thank you, Shriram Interio!',
    avatar: 'MK',
    image: 'https://placehold.co/100x100.png',
  },
];

export default function Home() {
  return (
    <div className="flex flex-col">
      {/* Hero Section */}
      <section className="relative w-full h-[60vh] md:h-[80vh] flex items-center justify-center text-center text-white">
        <Image
          src="https://placehold.co/1920x1080.png"
          alt="Modern living room"
          data-ai-hint="modern living room"
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0 brightness-50"
          priority
        />
        <div className="relative z-10 p-4">
          <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold tracking-tight text-shadow-lg">
            Crafting Dreams, Designing Reality
          </h1>
          <p className="mt-4 max-w-2xl mx-auto text-lg md:text-xl font-body">
            Your trusted partner in Pune for bespoke modular kitchens, wardrobes, and complete home interiors.
          </p>
          <Button asChild size="lg" className="mt-8 transition-transform transform hover:scale-105">
            <Link href="/services">Explore Our Services</Link>
          </Button>
        </div>
      </section>

       {/* Welcome Section */}
       <section id="about" className="py-16 md:py-24 bg-background">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="order-2 lg:order-1">
              <h2 className="text-3xl md:text-4xl font-bold mb-4">Welcome to Shriram Interio</h2>
              <p className="text-muted-foreground mb-4">
                Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team of passionate and skilled interior designers specializes in designing and decorating residential spaces — focusing on space planning, color theory, furniture selection, and lighting design.
              </p>
              <p className="text-muted-foreground">
                We believe well-designed interiors transform lives. By understanding our client’s aspirations, we create personalized plans that fit their style, lifestyle, and budget. Whether it’s a living room makeover, a kitchen update, or a full home transformation, we bring your dream space to life.
              </p>
            </div>
             <div className="order-1 lg:order-2">
              <Image
                src="https://placehold.co/600x450.png"
                alt="Interior design sketch"
                data-ai-hint="interior design sketch"
                width={600}
                height={450}
                className="rounded-lg shadow-2xl object-cover w-full h-full"
              />
            </div>
          </div>
        </div>
      </section>

      {/* Design at Your Comfort Section */}
      <section id="comfort-design" className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
           <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">Design at Your Comfort – Our Expertise</h2>
            <p className="text-lg text-muted-foreground mt-2 max-w-3xl mx-auto">We bring a wealth of expertise and passion for creating interiors at your comfort. Our process is designed to be seamless, transparent, and centered around you.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
            {expertise.map((item) => (
              <Card key={item.title} className="text-center p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-background">
                 <CardHeader className="flex items-center justify-center">
                  {item.icon}
                  <CardTitle className="mt-4 text-xl">{item.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-muted-foreground text-sm">{item.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Testimonials Section */}
      <section id="testimonials" className="py-16 md:py-24 bg-background">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">What Our Clients Say</h2>
            <p className="text-lg text-muted-foreground mt-2">We are proud of the homes we have transformed and the relationships we have built.</p>
          </div>
          <Carousel
            opts={{ align: 'start', loop: true }}
            className="w-full max-w-4xl mx-auto"
          >
            <CarouselContent>
              {testimonials.map((testimonial, index) => (
                <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/3">
                  <div className="p-1 h-full">
                    <Card className="flex flex-col justify-between h-full p-6 text-center">
                      <CardContent className="p-0">
                        <p className="text-muted-foreground italic">"{testimonial.review}"</p>
                      </CardContent>
                      <div className="mt-6">
                        <Avatar className="mx-auto mb-2">
                          <AvatarImage src={testimonial.image} alt={testimonial.name} data-ai-hint="person portrait" />
                          <AvatarFallback>{testimonial.avatar}</AvatarFallback>
                        </Avatar>
                        <p className="font-bold font-headline">{testimonial.name}</p>
                      </div>
                    </Card>
                  </div>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious />
            <CarouselNext />
          </Carousel>
          <div className="text-center mt-12">
            <Button asChild>
              <Link href="/clients">More Testimonials</Link>
            </Button>
          </div>
        </div>
      </section>
    </div>
  );
}
