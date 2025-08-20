
'use client'
import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Video, Smartphone, CircleDollarSign, Tv, Users, Layers, CalendarCheck, ShieldCheck } from 'lucide-react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { PageTransition } from '@/components/page-transition';


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

const whyShriramInterio = [
    {
        icon: <Users className="w-10 h-10 text-primary" />,
        title: 'Expert Design Team',
        description: 'Our team of designers brings a wealth of expertise, creativity, and a keen eye for detail to every project.',
    },
    {
        icon: <Layers className="w-10 h-10 text-primary" />,
        title: 'Variety of Design Choices',
        description: 'Enjoy multiple interior design alternatives until they match your expectations & requirement.',
    },
    {
        icon: <CircleDollarSign className="w-10 h-10 text-primary" />,
        title: 'Affordable Design Fees',
        description: 'We offer competitive and transparent design fees, making high-quality design accessible to everyone.',
    },
    {
        icon: <CalendarCheck className="w-10 h-10 text-primary" />,
        title: 'On-Time Project Delivery',
        description: 'Our commitment to excellence ensures your project is delivered on time, allowing you to enjoy your new space sooner.',
    },
];

const testimonials = [
    {
        name: 'Mr. Prashant Lukade & Mrs. Manisha Lukade',
        review: '“Choosing Shriram Interio was the best decision. Professionalism, design expertise, and commitment to delivering exceptional results were evident from day one.”',
        avatar: 'PL',
        image: '/avatar-1.png',
    },
    {
        name: 'Amit Purohit',
        review: '“I am very impressed with their service and quality. They customized my modular kitchen beautifully.”',
        avatar: 'AP',
        image: '/avatar-2.png',
    },
    {
        name: 'Anushka Sen',
        review: '“Innovative approach and flawless execution. Communication and transparency made the process enjoyable.”',
        avatar: 'AS',
        image: '/avatar-3.png',
    },
    {
        name: 'Anubhav Mittal',
        review: '“They designed the front of my house with great aesthetics and creativity.”',
        avatar: 'AM',
        image: '/avatar-4.png',
    },
    {
        name: 'Mr. Akshay Singh',
        review: '“They crafted a design perfectly suited to my needs. Attention to detail was outstanding.”',
        avatar: 'AS',
        image: '/avatar-5.png',
    },
    {
        name: 'Mr. Ashok Malge & Mrs. Shrisha Malge',
        review: '“They transformed my space into a breathtaking environment. Exceptional craftsmanship and design.”',
        avatar: 'AM',
        image: '/avatar-6.png',
    },
];

const trendingItems = [
  { name: 'Wardrobe', image: '/trending1.jpg', hint: 'modern wardrobe' },
  { name: 'Kitchen', image: '/kitchen.jpg', hint: 'modern kitchen' },
  { name: 'King Size Bed', image: '/r1.jpg', hint: 'king size bed' },
  { name: 'Living Room', image: 'https://images.unsplash.com/photo-1724582586529-62622e50c0b3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxsaXZpbmclMjByb29tJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU1NzE2MTA0fDA&ixlib=rb-4.1.0&q=80&w=1080', hint: 'modern living room' },
];

const bestSellingKitchens = [
    { name: 'L-Shaped Kitchen', image: '/kitchn1.jpg', hint: 'l-shaped kitchen' },
    { name: 'U-Shaped Kitchen', image: '/kitchen2.jpg', hint: 'u-shaped kitchen' },
    { name: 'Island Kitchen', image: '/kitchn1.jpg', hint: 'island kitchen' },
    { name: 'Small Kitchen Spaces', image: '/kitchen2.jpg', hint: 'small kitchen' },
];

const bestSellingWardrobes = [
    { name: 'Sliding Wardrobe', image: '/SlidingWardrobe.jpg', hint: 'sliding wardrobe' },
    { name: 'Free Standing Wardrobe', image: '/SlidingWardrobe.jpg', hint: 'freestanding wardrobe' },
    { name: 'Modular Wardrobe', image: '/SlidingWardrobe.jpg', hint: 'modular wardrobe' },
    { name: 'Walk-in Wardrobe', image: '/b1.jpg', hint: 'walk-in wardrobe' },
];

export default function Home() {
  return (
    <PageTransition>
      {/* Hero Section */}
      <section className="relative w-full h-screen overflow-hidden">
        <Image
            src="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80"
            alt="Hero background image"
            layout="fill"
            objectFit="cover"
            className="absolute inset-0 w-full h-full object-cover brightness-50"
            data-ai-hint="hero background"
        />
        <div className="absolute inset-0 z-10 flex items-center justify-center text-center text-white px-4 sm:px-6 lg:px-8">
          <div className="max-w-4xl mx-auto">
            <h1 className="text-4xl sm:text-5xl md:text-6xl font-bold tracking-tight text-shadow-lg font-headline">
              Crafting Dreams, Designing Reality
            </h1>
            <p className="mt-4 max-w-2xl mx-auto text-lg md:text-xl font-body">
              Your trusted partner in Pune for bespoke modular kitchens, wardrobes, and complete home interiors.
            </p>
            <Button asChild size="lg" className="mt-8 transition-transform transform hover:scale-105">
              <Link href="/services">Explore Our Services</Link>
            </Button>
          </div>
        </div>
      </section>

       {/* Welcome Section */}
       <section id="about" className="py-16 md:py-24 bg-background">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="order-2 lg:order-1">
              <h2 className="text-3xl md:text-4xl font-bold mb-4">Welcome to <span className="font-headline text-shadow-sm">Shriram Interio</span></h2>
              <p className="text-muted-foreground mb-4">
                Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team of passionate and skilled interior designers specializes in designing and decorating residential spaces — focusing on space planning, color theory, furniture selection, and lighting design.
              </p>
              <p className="text-muted-foreground">
                We believe well-designed interiors transform lives. By understanding our client’s aspirations, we create personalized plans that fit their style, lifestyle, and budget. Whether it’s a living room makeover, a kitchen update, or a full home transformation, we bring your dream space to life.
              </p>
            </div>
             <div className="order-1 lg:order-2">
              <Image
                src="/b2.jpg"
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

      {/* About Company Section */}
      <section id="about-company" className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-4">About Company</h2>
          <p className="text-lg text-muted-foreground max-w-3xl mx-auto">
            <span className="font-headline text-shadow-sm">SHRIRAM INTERIO</span> — Where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we combine creativity, functionality, and personalization in every project.
          </p>
        </div>
      </section>

       {/* Why Shriram Interio Section */}
        <section className="py-16 md:py-24 bg-background">
            <div className="container mx-auto px-4">
                <div className="text-center mb-12">
                    <h2 className="text-3xl md:text-4xl font-bold">Why <span className="font-headline text-shadow-sm">Shriram Interio</span></h2>
                    <p className="text-lg text-muted-foreground mt-2">Our commitment to quality and customer satisfaction.</p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                    {whyShriramInterio.map((item, index) => (
                        <Card key={index} className="text-center p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                            <CardHeader className="items-center">
                                {item.icon}
                                <CardTitle className="mt-4 text-xl">{item.title}</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-muted-foreground">{item.description}</p>
                            </CardContent>
                        </Card>
                    ))}
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

      {/* Trending Section */}
      <section className="py-16 md:py-24 bg-background">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-bold">What We Do</h2>
              <p className="text-lg text-muted-foreground mt-2">End-to-end interior solutions.</p>
          </div>
          <Tabs defaultValue="trending" className="w-full">
            <TabsList className="flex flex-wrap h-auto justify-center">
              <TabsTrigger value="trending">Trending</TabsTrigger>
              <TabsTrigger value="kitchens">Best Selling Kitchens</TabsTrigger>
              <TabsTrigger value="wardrobes">Best Selling Wardrobes</TabsTrigger>
            </TabsList>
            <TabsContent value="trending">
              <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto mt-8">
                <CarouselContent>
                  {trendingItems.map((item, index) => (
                    <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/4">
                      <Card className="overflow-hidden">
                        <div className="relative aspect-[3/4]">
                           <Image src={item.image} alt={item.name} layout="fill" objectFit="cover" data-ai-hint={item.hint}/>
                        </div>
                        <CardContent className="p-4">
                           <h3 className="text-lg font-bold">{item.name}</h3>
                        </CardContent>
                      </Card>
                    </CarouselItem>
                  ))}
                </CarouselContent>
                <CarouselPrevious />
                <CarouselNext />
              </Carousel>
            </TabsContent>
            <TabsContent value="kitchens">
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 mt-8">
                  {bestSellingKitchens.map((item, index) => (
                       <Card key={index} className="overflow-hidden">
                        <div className="relative aspect-[3/4]">
                           <Image src={item.image} alt={item.name} layout="fill" objectFit="cover" data-ai-hint={item.hint} />
                        </div>
                        <CardContent className="p-4">
                           <h3 className="text-lg font-bold">{item.name}</h3>
                        </CardContent>
                      </Card>
                  ))}
              </div>
            </TabsContent>
            <TabsContent value="wardrobes">
               <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto mt-8">
                <CarouselContent>
                  {bestSellingWardrobes.map((item, index) => (
                    <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/4">
                       <Card className="overflow-hidden">
                        <div className="relative aspect-[3/4]">
                           <Image src={item.image} alt={item.name} layout="fill" objectFit="cover" data-ai-hint={item.hint} />
                        </div>
                        <CardContent className="p-4">
                           <h3 className="text-lg font-bold">{item.name}</h3>
                        </CardContent>
                      </Card>
                    </CarouselItem>
                  ))}
                </CarouselContent>
                <CarouselPrevious />
                <CarouselNext />
              </Carousel>
            </TabsContent>
          </Tabs>
        </div>
      </section>


      {/* Testimonials Section */}
      <section id="testimonials" className="py-16 md:py-24 bg-background">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">Client Reviews</h2>
            <p className="text-lg text-muted-foreground mt-2">We are proud of the homes we have transformed and the relationships we have built.</p>
          </div>
          <Carousel
            opts={{ align: 'start', loop: true }}
            className="w-full max-w-6xl mx-auto"
          >
            <CarouselContent>
              {testimonials.map((testimonial, index) => (
                <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/3">
                  <div className="p-1 h-full">
                    <Card className="flex flex-col justify-between h-full p-6 text-center bg-secondary">
                      <CardContent className="p-0 flex-grow">
                        <p className="text-muted-foreground italic">{testimonial.review}</p>
                      </CardContent>
                      <div className="mt-6 pt-4 border-t">
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
    </PageTransition>
  );
}
