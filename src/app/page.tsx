
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
    icon: <Video className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
    title: 'Live 3D Designs',
    description: 'Experience the future of design with our 3D Interior Design Services tailored to your floor plan.',
  },
  {
    icon: <Smartphone className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
    title: 'Contactless Experience',
    description: 'No stepping out. Design your home interiors at the comfort of your home.',
  },
  {
    icon: <CircleDollarSign className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
    title: 'Instant Pricing',
    description: 'Complete price transparency and budget-friendly solutions.',
  },
  {
    icon: <Tv className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
    title: 'Expertise & Passion',
    description: 'We bring a wealth of expertise and passion for creating interiors at your comfort.',
  }
];

const whyShriramInterio = [
    {
        icon: <Users className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
        title: 'Expert Design Team',
        description: 'Our team of designers brings a wealth of expertise, creativity, and a keen eye for detail to every project.',
    },
    {
        icon: <Layers className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
        title: 'Variety of Design Choices',
        description: 'Enjoy multiple interior design alternatives until they match your expectations & requirement.',
    },
    {
        icon: <CircleDollarSign className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
        title: 'Affordable Design Fees',
        description: 'We offer competitive and transparent design fees, making high-quality design accessible to everyone.',
    },
    {
        icon: <CalendarCheck className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
        title: 'On-Time Project Delivery',
        description: 'Our commitment to excellence ensures your project is delivered on time, allowing you to enjoy your new space sooner.',
    },
];

const testimonials = [
    {
        name: 'Mr. Prashant Lukade & Mrs. Manisha Lukade',
        review: '"Choosing Shriram Interio was the best decision. Professionalism, design expertise, and commitment to delivering exceptional results were evident from day one."',
        avatar: 'PL',
        image: '/avatar-1.png',
    },
    {
        name: 'Amit Purohit',
        review: '"I am very impressed with their service and quality. They customized my modular kitchen beautifully."',
        avatar: 'AP',
        image: '/avatar-2.png',
    },
    {
        name: 'Anushka Sen',
        review: '"Innovative approach and flawless execution. Communication and transparency made the process enjoyable."',
        avatar: 'AS',
        image: '/avatar-3.png',
    },
    {
        name: 'Anubhav Mittal',
        review: '"They designed the front of my house with great aesthetics and creativity."',
        avatar: 'AM',
        image: '/avatar-4.png',
    },
    {
        name: 'Mr. Akshay Singh',
        review: '"They crafted a design perfectly suited to my needs. Attention to detail was outstanding."',
        avatar: 'AS',
        image: '/avatar-5.png',
    },
    {
        name: 'Mr. Ashok Malge & Mrs. Shrisha Malge',
        review: '"They transformed my space into a breathtaking environment. Exceptional craftsmanship and design."',
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

const partners = [
    { name: 'Ebco', logoSrc: '/ebco.jpg' },
    { name: 'Hettich', logoSrc: '/hettich.png' },
    { name: 'Royale Touche', logoSrc: '/Royal-Touch.jpg' },
    { name: 'Hafele', logoSrc: '/hafele.png' },
    { name: 'Godrej', logoSrc: '/godrej.png' },
];

export default function Home() {
  return (
    <PageTransition>
      {/* Hero Section */}
      <section className="relative w-full h-screen min-h-[500px] overflow-hidden">
  {/* Video Background */}
  <Carousel className="w-full h-full">
          <CarouselContent>
            {/* Video Slide */}
            <CarouselItem className="relative w-full h-screen min-h-[500px]">
              <video
                autoPlay
                muted
                loop
                playsInline
                className="absolute inset-0 w-full h-full object-cover brightness-50 z-0"
                poster="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80"
              >
                <source src="https://videos.pexels.com/video-files/7578544/7578544-uhd_2560_1440_30fps.mp4" type="video/mp4" />
                <source src="https://videos.pexels.com/video-files/7578544/7578544-uhd_2560_1440_30fps.mp4" type="video/webm" />
                {/* Fallback image if video doesn't load */}
                <img
                  src="https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80"
                  alt="Hero background"
                  className="w-full h-full object-cover"
                />
              </video>
               <div className="absolute inset-0 bg-black/30 z-5"></div>
            </CarouselItem>

            {/* Image Slide 1 */}
            <CarouselItem className="relative w-full h-screen min-h-[500px]">
              <Image src="/kitchengallery.jpg" alt="Modular Kitchen" layout="fill" objectFit="cover" className="brightness-50 z-0" data-ai-hint="modern kitchen interior"/>
               <div className="absolute inset-0 bg-black/30 z-5"></div>
            </CarouselItem>

            {/* Image Slide 2 */}
            <CarouselItem className="relative w-full h-screen min-h-[500px]">
              <Image src="/industrial.jpg" alt="Industrial Interior" layout="fill" objectFit="cover" className="brightness-50 z-0" data-ai-hint="industrial style interior"/>
               <div className="absolute inset-0 bg-black/30 z-5"></div>
            </CarouselItem>

            {/* Image Slide 3 */}
            <CarouselItem className="relative w-full h-screen min-h-[500px]">
              <Image src="/Royal-Touch.jpg" alt="Royal Touch Interior" layout="fill" objectFit="cover" className="brightness-50 z-0" data-ai-hint="luxury interior design"/>
               <div className="absolute inset-0 bg-black/30 z-5"></div>
            </CarouselItem>

          </CarouselContent>
           <CarouselPrevious className="left-4 z-20" />
          <CarouselNext className="right-4 z-20" />
        </Carousel>
  <div className="absolute inset-0 z-10 flex items-center justify-center text-center text-white px-4 sm:px-6 lg:px-8">
    <div className="max-w-4xl mx-auto">
      <h1 className="text-2xl xs:text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight text-shadow-lg font-headline leading-tight">
        Crafting Dreams, Designing Reality
      </h1>
      <p className="mt-4 max-w-2xl mx-auto text-sm sm:text-base md:text-lg lg:text-xl font-body px-2">
        Your trusted partner in Pune for bespoke modular kitchens, wardrobes, and complete home interiors.
      </p>
      <Button asChild size="lg" className="mt-6 sm:mt-8 transition-transform transform hover:scale-105 text-sm sm:text-base">
        <Link href="/services">Explore Our Services</Link>
      </Button>
    </div>
  </div>
</section>

       {/* Welcome Section */}
       <section id="about" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 sm:gap-12 items-center">
            <div className="order-2 lg:order-1">
              <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-4 leading-tight">
                Welcome to <span className="font-headline text-shadow-sm">Shriram Interio</span>
              </h2>
              <p className="text-sm sm:text-base text-muted-foreground mb-4 leading-relaxed">
                Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team of passionate and skilled interior designers specializes in designing and decorating residential spaces — focusing on space planning, color theory, furniture selection, and lighting design.
              </p>
              <p className="text-sm sm:text-base text-muted-foreground leading-relaxed">
                We believe well-designed interiors transform lives. By understanding our client's aspirations, we create personalized plans that fit their style, lifestyle, and budget. Whether it's a living room makeover, a kitchen update, or a full home transformation, we bring your dream space to life.
              </p>
            </div>
             <div className="order-1 lg:order-2">
              <Image
                src="/b2.jpg"
                alt="Interior design sketch"
                data-ai-hint="interior design sketch"
                width={600}
                height={450}
                className="rounded-lg shadow-2xl object-cover w-full h-auto max-h-[300px] sm:max-h-[400px] lg:max-h-[450px]"
              />
            </div>
          </div>
        </div>
      </section>

      {/* About Company Section */}
      <section id="about-company" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-secondary">
        <div className="container mx-auto px-4 sm:px-6 text-center">
          <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-4">About Company</h2>
          <p className="text-sm sm:text-base md:text-lg text-muted-foreground max-w-3xl mx-auto leading-relaxed px-2">
            <span className="font-headline text-shadow-sm">SHRIRAM INTERIO</span> — Where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we combine creativity, functionality, and personalization in every project.
          </p>
        </div>
      </section>

       {/* Why Shriram Interio Section */}
        <section className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
            <div className="container mx-auto px-4 sm:px-6">
                <div className="text-center mb-8 sm:mb-12">
                    <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">
                      Why <span className="font-headline text-shadow-sm">Shriram Interio</span>
                    </h2>
                    <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">Our commitment to quality and customer satisfaction.</p>
                </div>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 sm:gap-8">
                    {whyShriramInterio.map((item, index) => (
                        <Card key={index} className="text-center p-4 sm:p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                            <CardHeader className="items-center pb-2 sm:pb-4">
                                {item.icon}
                                <CardTitle className="mt-3 sm:mt-4 text-lg sm:text-xl leading-tight">{item.title}</CardTitle>
                            </CardHeader>
                            <CardContent className="pt-0">
                                <p className="text-xs sm:text-sm text-muted-foreground leading-relaxed">{item.description}</p>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            </div>
        </section>

      {/* Design at Your Comfort Section */}
      <section id="comfort-design" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-secondary">
        <div className="container mx-auto px-4 sm:px-6">
           <div className="text-center mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold leading-tight mb-2">Design at Your Comfort – Our Expertise</h2>
            <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 max-w-3xl mx-auto leading-relaxed px-2">We bring a wealth of expertise and passion for creating interiors at your comfort. Our process is designed to be seamless, transparent, and centered around you.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 sm:gap-8">
            {expertise.map((item) => (
              <Card key={item.title} className="text-center p-4 sm:p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-background">
                 <CardHeader className="flex items-center justify-center pb-2 sm:pb-4">
                  {item.icon}
                  <CardTitle className="mt-3 sm:mt-4 text-lg sm:text-xl leading-tight">{item.title}</CardTitle>
                </CardHeader>
                <CardContent className="pt-0">
                  <p className="text-xs sm:text-sm text-muted-foreground leading-relaxed">{item.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Trending Section */}
      <section className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="text-center mb-8 sm:mb-12">
              <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">What We Do</h2>
              <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">End-to-end interior solutions.</p>
          </div>
          <Tabs defaultValue="trending" className="w-full">
            <TabsList className="flex flex-wrap h-auto justify-center mb-6 sm:mb-8 w-full">
              <TabsTrigger value="trending" className="text-xs sm:text-sm px-3 sm:px-4 py-2 m-1">Trending</TabsTrigger>
              <TabsTrigger value="kitchens" className="text-xs sm:text-sm px-3 sm:px-4 py-2 m-1">Best Selling Kitchens</TabsTrigger>
              <TabsTrigger value="wardrobes" className="text-xs sm:text-sm px-3 sm:px-4 py-2 m-1">Best Selling Wardrobes</TabsTrigger>
            </TabsList>
            <TabsContent value="trending">
              <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto">
                <CarouselContent className="-ml-2 sm:-ml-4">
                  {trendingItems.map((item, index) => (
                    <CarouselItem key={index} className="pl-2 sm:pl-4 basis-4/5 xs:basis-3/5 sm:basis-1/2 lg:basis-1/4">
                      <Card className="overflow-hidden">
                        <div className="relative aspect-[3/4]">
                           <Image src={item.image} alt={item.name} layout="fill" objectFit="cover" data-ai-hint={item.hint}/>
                        </div>
                        <CardContent className="p-3 sm:p-4">
                           <h3 className="text-sm sm:text-base lg:text-lg font-bold leading-tight">{item.name}</h3>
                        </CardContent>
                      </Card>
                    </CarouselItem>
                  ))}
                </CarouselContent>
                <CarouselPrevious className="left-2 sm:left-4" />
                <CarouselNext className="right-2 sm:right-4" />
              </Carousel>
            </TabsContent>
            <TabsContent value="kitchens">
              <div className="grid grid-cols-1 xs:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6 lg:gap-8">
                  {bestSellingKitchens.map((item, index) => (
                       <Card key={index} className="overflow-hidden">
                        <div className="relative aspect-[3/4]">
                           <Image src={item.image} alt={item.name} layout="fill" objectFit="cover" data-ai-hint={item.hint} />
                        </div>
                        <CardContent className="p-3 sm:p-4">
                           <h3 className="text-sm sm:text-base lg:text-lg font-bold leading-tight">{item.name}</h3>
                        </CardContent>
                      </Card>
                  ))}
              </div>
            </TabsContent>
            <TabsContent value="wardrobes">
               <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto">
                <CarouselContent className="-ml-2 sm:-ml-4">
                  {bestSellingWardrobes.map((item, index) => (
                    <CarouselItem key={index} className="pl-2 sm:pl-4 basis-4/5 xs:basis-3/5 sm:basis-1/2 lg:basis-1/4">
                       <Card className="overflow-hidden">
                        <div className="relative aspect-[3/4]">
                           <Image src={item.image} alt={item.name} layout="fill" objectFit="cover" data-ai-hint={item.hint} />
                        </div>
                        <CardContent className="p-3 sm:p-4">
                           <h3 className="text-sm sm:text-base lg:text-lg font-bold leading-tight">{item.name}</h3>
                        </CardContent>
                      </Card>
                    </CarouselItem>
                  ))}
                </CarouselContent>
                <CarouselPrevious className="left-2 sm:left-4" />
                <CarouselNext className="right-2 sm:right-4" />
              </Carousel>
            </TabsContent>
          </Tabs>
        </div>
      </section>

      {/* Testimonials Section */}
      <section id="testimonials" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-secondary">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="text-center mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">Client Reviews</h2>
            <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">We are proud of the homes we have transformed and the relationships we have built.</p>
          </div>
          <Carousel
            opts={{ align: 'start', loop: true }}
            className="w-full max-w-6xl mx-auto"
          >
            <CarouselContent className="-ml-2 sm:-ml-4">
              {testimonials.map((testimonial, index) => (
                <CarouselItem key={index} className="pl-2 sm:pl-4 basis-full sm:basis-1/2 lg:basis-1/3">
                  <div className="p-1 h-full">
                    <Card className="flex flex-col justify-between h-full p-4 sm:p-6 text-center bg-background">
                      <CardContent className="p-0 flex-grow">
                        <p className="text-xs sm:text-sm text-muted-foreground italic leading-relaxed">{testimonial.review}</p>
                      </CardContent>
                      <div className="mt-4 sm:mt-6 pt-4 border-t">
                        <Avatar className="mx-auto mb-2 w-10 h-10 sm:w-12 sm:h-12">
                          <AvatarImage src={testimonial.image} alt={testimonial.name} data-ai-hint="person portrait" />
                          <AvatarFallback className="text-xs sm:text-sm">{testimonial.avatar}</AvatarFallback>
                        </Avatar>
                        <p className="font-bold font-headline text-xs sm:text-sm leading-tight">{testimonial.name}</p>
                      </div>
                    </Card>
                  </div>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious className="left-2 sm:left-4" />
            <CarouselNext className="right-2 sm:right-4" />
          </Carousel>
          <div className="text-center mt-8 sm:mt-12">
            <Button asChild size="default" className="text-sm sm:text-base">
              <Link href="/clients">More Testimonials</Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Partners Section */}
      <section className="py-16 md:py-24 bg-background">
          <div className="container mx-auto px-4">
              <div className="text-center mb-12">
                  <div className="flex justify-center items-center mb-2">
                      <div className="border-t border-primary w-12"></div>
                      <p className="text-sm text-primary font-bold tracking-widest mx-4">MEET OUR PARTNERS</p>
                      <div className="border-t border-primary w-12"></div>
                  </div>
                  <h2 className="text-3xl md:text-4xl font-bold">Our Partners</h2>
              </div>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-8 items-center">
                  {partners.map((partner) => (
                      <div key={partner.name} className="flex justify-center">
                          <Image
                              src={partner.logoSrc}
                              alt={`${partner.name} Logo`}
                              width={150}
                              height={75}
                              className="object-contain"
                              data-ai-hint="partner logo"
                          />
                      </div>
                  ))}
              </div>
          </div>
      </section>
    </PageTransition>
  );
}

    