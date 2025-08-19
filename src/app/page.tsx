
'use client';
import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Video, Smartphone, CircleDollarSign, Tv, Users, Layers, CalendarCheck } from 'lucide-react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import Autoplay from "embla-carousel-autoplay"
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
        icon: (
            <svg
                className="w-16 h-16"
                viewBox="0 0 64 64"
                xmlns="http://www.w3.org/2000/svg"
            >
                <g fill="none" fillRule="evenodd">
                    <circle className="stroke-current text-primary" strokeWidth="2" cx="32" cy="32" r="31" />
                    <g className="fill-current text-primary" transform="translate(18 18)">
                        <path d="M15.3 8.3a3 3 0 01-2.6 1.6h-5a3 3 0 01-2.6-1.6L2.6 3.8a1 1 0 011-1.6l1.7.9a1 1 0 001.2 0l3-1.8a1 1 0 011.2 0l3 1.8a1 1 0 001.2 0l1.7-.9a1 1 0 011 1.6l-2.5 4.5z">
                            <animate attributeName="opacity" from="0" to="1" dur="0.5s" begin="0.1s" fill="freeze" />
                        </path>
                        <circle cx="9" cy="20" r="4">
                            <animate attributeName="r" from="0" to="4" dur="0.5s" begin="0.3s" fill="freeze" />
                        </circle>
                        <circle cx="21" cy="20" r="4">
                            <animate attributeName="r" from="0" to="4" dur="0.5s" begin="0.5s" fill="freeze" />
                        </circle>
                        <circle cx="3" cy="12" r="3">
                            <animate attributeName="r" from="0" to="3" dur="0.5s" begin="0.2s" fill="freeze" />
                        </circle>
                    </g>
                </g>
            </svg>
        ),
        title: 'Expert Design Team',
        description: 'Our team of designers brings a wealth of expertise, creativity, and a keen eye for detail to every project. Our designers combine their diverse backgrounds and unique perspectives to curate interiors that captivate and inspire.',
    },
    {
        icon: (
            <svg
                className="w-16 h-16"
                viewBox="0 0 64 64"
                xmlns="http://www.w3.org/2000/svg"
            >
                <g fill="none" fillRule="evenodd">
                    <circle className="stroke-current text-primary" strokeWidth="2" cx="32" cy="32" r="31" />
                    <g className="stroke-current text-primary" strokeWidth="2">
                        <path d="M20 28l12-8 12 8" strokeLinecap="round" strokeLinejoin="round">
                            <animate attributeName="stroke-dasharray" from="0 60" to="60 0" dur="0.7s" begin="0.1s" fill="freeze" />
                        </path>
                        <path d="M20 38l12-8 12 8" strokeLinecap="round" strokeLinejoin="round" opacity="0">
                            <animate attributeName="opacity" from="0" to="1" dur="0.3s" begin="0.8s" fill="freeze" />
                            <animate attributeName="stroke-dasharray" from="0 60" to="60 0" dur="0.7s" begin="0.8s" fill="freeze" />
                        </path>
                        <path d="M20 48l12-8 12 8" strokeLinecap="round" strokeLinejoin="round" opacity="0">
                            <animate attributeName="opacity" from="0" to="1" dur="0.3s" begin="1.5s" fill="freeze" />
                            <animate attributeName="stroke-dasharray" from="0 60" to="60 0" dur="0.7s" begin="1.5s" fill="freeze" />
                        </path>
                    </g>
                </g>
            </svg>
        ),
        title: 'Variety of Design Choices',
        description: 'Enjoy multiple Interior design alternatives until they match your expectations & requirement. We pride ourselves on our ability to offer an array of design,let us guide you on a journey to discover the perfect style that speaks to your soul',
    },
    {
        icon: (
             <svg
                className="w-16 h-16"
                viewBox="0 0 64 64"
                xmlns="http://www.w3.org/2000/svg"
            >
                <g fill="none" fillRule="evenodd">
                    <circle className="stroke-current text-primary" strokeWidth="2" cx="32" cy="32" r="31" />
                    <g className="fill-current text-primary" transform="translate(22 22)">
                        <path d="M10 18h10v2H10z">
                            <animate attributeName="opacity" from="0" to="1" dur="0.5s" begin="0.1s" fill="freeze" />
                        </path>
                        <path d="M12 4c-4.4 0-8 3.6-8 8s3.6 8 8 8h6v-2h-6c-3.3 0-6-2.7-6-6s2.7-6 6-6h8v12h-2V6h-4z">
                            <animate attributeName="d" from="M12 4c-4.4 0-8 3.6-8 8s3.6 8 8 8h6v-2h-6c-3.3 0-6-2.7-6-6s2.7-6 6-6h8v12h-2V6h-4z" to="M12 4c-4.4 0-8 3.6-8 8s3.6 8 8 8h6v-2h-6c-3.3 0-6-2.7-6-6s2.7-6 6-6h8v12h2V6h-6z" dur="1s" begin="0.5s" fill="freeze" repeatCount="1"/>
                        </path>
                    </g>
                </g>
            </svg>
        ),
        title: 'Affordable Design Fees',
        description: 'We believe in making high-quality design services accessible to everyone. We offer competitive and transparent design fees tailored to suit various budgets.Affordable design solutions can transform your space as per your vision.',
    },
    {
        icon: (
            <svg
                className="w-16 h-16"
                viewBox="0 0 64 64"
                xmlns="http://www.w3.org/2000/svg"
            >
                <g fill="none" fillRule="evenodd">
                    <circle className="stroke-current text-primary" strokeWidth="2" cx="32" cy="32" r="31" />
                    <g className="stroke-current text-primary" strokeWidth="2" strokeLinecap="round">
                        <path d="M24 24h16v18H24z">
                             <animate attributeName="stroke-dasharray" from="0 100" to="100 0" dur="0.8s" fill="freeze" />
                        </path>
                        <path d="M29 24v-4" >
                             <animate attributeName="stroke-dasharray" from="0 10" to="10 0" dur="0.3s" begin="0.8s" fill="freeze" />
                        </path>
                        <path d="M35 24v-4" >
                             <animate attributeName="stroke-dasharray" from="0 10" to="10 0" dur="0.3s" begin="1s" fill="freeze" />
                        </path>
                        <path d="M24 32h16" >
                            <animate attributeName="stroke-dasharray" from="0 20" to="20 0" dur="0.4s" begin="1.2s" fill="freeze" />
                        </path>
                        <path d="M29 35l2 2 4-4" strokeLinejoin="round" opacity="0">
                             <animate attributeName="opacity" from="0" to="1" dur="0.3s" begin="1.6s" fill="freeze" />
                             <animate attributeName="stroke-dasharray" from="0 20" to="20 0" dur="0.5s" begin="1.6s" fill="freeze" />
                        </path>
                    </g>
                </g>
            </svg>
        ),
        title: 'On-Time Project Delivery',
        description: 'We understand the importance of time and deadlines. Our commitment to excellence extends to ensuring on-time project delivery allowing you to experience the joy of your newly transformed space exactly when expected',
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
];

const heroSlides = [
    { src: '/b1.jpg', alt: 'Luxurious and comfortable hotel room interior', hint: 'hotel room interior' },
    { src: '/b2.jpg', alt: 'Interior design sketch', hint: 'interior design sketch' },
    { src: '/kitchen.jpg', alt: 'Modern kitchen', hint: 'modern kitchen' },
    { src: '/r1.jpg', alt: 'King size bed', hint: 'king size bed' },
]

export default function Home() {
  return (
    <PageTransition>
      {/* Hero Section */}
      <section className="relative w-full h-[60vh] md:h-[80vh]">
        <Image
            src="/b1.jpg"
            alt="Luxurious and comfortable hotel room interior"
            data-ai-hint="hotel room interior"
            layout="fill"
            objectFit="cover"
            className="absolute inset-0 z-0 brightness-50"
            priority
        />
        <div className="absolute inset-0 z-10 flex items-center justify-center text-center text-white p-4">
             <div>
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
            SHRIRAM INTERIO — Where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we combine creativity, functionality, and personalization in every project.
          </p>
        </div>
      </section>

       {/* Why Shriram Interio Section */}
       <section className="py-16 md:py-24 bg-background">
            <div className="container mx-auto px-4">
                <div className="text-center mb-12">
                    <h2 className="text-3xl md:text-4xl font-bold">Why Shriram Interio</h2>
                    <p className="text-lg text-muted-foreground mt-2">Our commitment to quality and customer satisfaction.</p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                    {whyShriramInterio.map((value) => (
                        <Card key={value.title} className="p-6 text-center transition-all duration-300 hover:shadow-xl hover:-translate-y-2 flex flex-col items-center">
                           <div className="mb-4">
                                {value.icon}
                            </div>
                            <CardHeader className="p-0">
                                <CardTitle>{value.title}</CardTitle>
                            </CardHeader>
                            <CardContent className="p-0 mt-4">
                                <p className="text-muted-foreground text-sm">{value.description}</p>
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
            <TabsList className="grid w-full grid-cols-3 md:w-1/2 mx-auto">
              <TabsTrigger value="trending">Trending</TabsTrigger>
              <TabsTrigger value="kitchens">Best Selling Kitchens</TabsTrigger>
              <TabsTrigger value="wardrobes">Best Selling Wardrobes</TabsTrigger>
            </TabsList>
            <TabsContent value="trending">
              <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto mt-8">
                <CarouselContent>
                  {trendingItems.map((item, index) => (
                    <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/3">
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
              <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto mt-8">
                <CarouselContent>
                  {bestSellingKitchens.map((item, index) => (
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
            <TabsContent value="wardrobes">
               <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto mt-8">
                <CarouselContent>
                  {bestSellingWardrobes.map((item, index) => (
                    <CarouselItem key={index} className="md:basis-1/2 lg:basis-1/3">
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

    
