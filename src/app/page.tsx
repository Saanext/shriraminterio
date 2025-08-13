import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { CookingPot, Sofa, Paintbrush, Video, Smartphone, CircleDollarSign } from 'lucide-react';

const services = [
  {
    icon: <CookingPot className="w-12 h-12 text-primary" />,
    title: 'Modular Kitchens',
    description: 'Customized kitchen solutions that are both beautiful and functional, designed to fit your lifestyle.',
  },
  {
    icon: <Sofa className="w-12 h-12 text-primary" />,
    title: 'Living Spaces',
    description: 'Transform your living areas into comfortable and stylish spaces for relaxation and entertainment.',
  },
  {
    icon: <Paintbrush className="w-12 h-12 text-primary" />,
    title: 'Exterior Design',
    description: 'Enhance your home\'s curb appeal with our expert exterior design and decoration services.',
  },
];

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
        <div className="relative z-10 p-4 animate-fade-in-up">
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

      {/* Services Section */}
      <section id="services" className="py-16 md:py-24 bg-background">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">Our Services</h2>
            <p className="text-lg text-muted-foreground mt-2">We offer a complete range of interior design solutions.</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {services.map((service) => (
              <Card key={service.title} className="text-center p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2">
                <CardHeader className="flex items-center justify-center">
                  {service.icon}
                  <CardTitle className="mt-4 text-2xl">{service.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-muted-foreground">{service.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
          <div className="text-center mt-12">
            <Button asChild variant="outline">
              <Link href="/services">View All Services</Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Why Choose Us Section */}
      <section id="expertise" className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="order-2 lg:order-1">
              <h2 className="text-3xl md:text-4xl font-bold mb-4">Design at Your Comfort – Our Expertise</h2>
              <p className="text-lg text-muted-foreground mb-8">
                We bring a wealth of expertise and passion for creating interiors at your comfort.
              </p>
              <div className="space-y-6">
                {expertise.map((item) => (
                  <div key={item.title} className="flex items-start gap-4">
                    <div className="flex-shrink-0">{item.icon}</div>
                    <div>
                      <h3 className="text-xl font-bold font-headline">{item.title}</h3>
                      <p className="text-muted-foreground">{item.description}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
            <div className="order-1 lg:order-2">
              <Image
                src="https://placehold.co/600x600.png"
                alt="Interior designers collaborating"
                data-ai-hint="designers collaboration"
                width={600}
                height={600}
                className="rounded-lg shadow-2xl object-cover w-full h-full"
              />
            </div>
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
