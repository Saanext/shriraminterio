
'use client';

import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Video, Smartphone, IndianRupee, Tv, Users, Layers, CalendarCheck, ShieldCheck } from 'lucide-react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion';

type HomePageClientProps = {
    pageContent: any;
};

export function HomePageClient({ pageContent }: HomePageClientProps) {
  const { 
    hero, 
    welcome, 
    aboutCompany, 
    whyUs, 
    workGallery,
    comfortDesign,
    whatWeDo,
    testimonials,
    faq,
    partners 
  } = pageContent;

  const expertise = comfortDesign.items;
  const whyShriramInterio = whyUs.items;
  const testimonialsItems = testimonials.items;
  const trendingItems = whatWeDo.trendingItems;
  const bestSellingKitchens = whatWeDo.bestSellingKitchens;
  const bestSellingWardrobes = whatWeDo.bestSellingWardrobes;
  const workGalleryItems = workGallery.items;
  const partnersItems = partners.items;
  const faqItems = faq.items;
  const heroSlides = hero.slides;

  return (
    <div>
      {/* Hero Section */}
      {hero.visible && (
      <section className="relative w-full h-screen min-h-[500px] overflow-hidden">
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
                poster="https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-poster.jpg"
              >
                <source src={hero.videoUrl} type="video/mp4" />
                <source src={hero.videoUrl} type="video/webm" />
                <img
                  src="https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-poster.jpg"
                  alt="Hero background"
                  className="w-full h-full object-cover"
                />
              </video>
               <div className="absolute inset-0 bg-black/30 z-5"></div>
            </CarouselItem>

            {/* Image Slides */}
            {heroSlides.map((slide: any, index: number) => (
              <CarouselItem key={index} className="relative w-full h-screen min-h-[500px]">
                <Image src={slide.image} alt="Interior Design Showcase" layout="fill" objectFit="cover" className="brightness-50 z-0" data-ai-hint="modern interior design"/>
                <div className="absolute inset-0 bg-black/30 z-5"></div>
              </CarouselItem>
            ))}
          </CarouselContent>
          <CarouselPrevious className="left-4 z-20" />
          <CarouselNext className="right-4 z-20" />
        </Carousel>
        <div className="absolute inset-0 z-10 flex items-center justify-center text-center text-white px-4 sm:px-6 lg:px-8">
          <div className="max-w-4xl mx-auto">
            <h1 className="text-2xl xs:text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight text-shadow-lg font-headline leading-tight">
              {hero.title}
            </h1>
            <p className="mt-4 max-w-2xl mx-auto text-sm sm:text-base md:text-lg lg:text-xl font-body px-2">
              {hero.subtitle}
            </p>
            <Button asChild size="lg" className="mt-6 sm:mt-8 transition-transform transform hover:scale-105 text-sm sm:text-base">
              <Link href="/services">{hero.buttonText}</Link>
            </Button>
          </div>
        </div>
      </section>
      )}

       {/* Welcome Section */}
       {welcome.visible && (
       <section id="about" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 sm:gap-12 items-center">
            <div className="order-2 lg:order-1">
              <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-4 leading-tight">
                Welcome to <span className="font-headline text-shadow-sm">Shriram Interio</span>
              </h2>
              <p className="text-sm sm:text-base text-muted-foreground mb-4 leading-relaxed">
                {welcome.paragraph1}
              </p>
              <p className="text-sm sm:text-base text-muted-foreground leading-relaxed">
                {welcome.paragraph2}
              </p>
            </div>
             <div className="order-1 lg:order-2">
              <Image
                src={welcome.image}
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
       )}

      {/* About Company Section */}
      {aboutCompany.visible && (
      <section id="about-company" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-secondary">
        <div className="container mx-auto px-4 sm:px-6 text-center">
          <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-4">{aboutCompany.title}</h2>
          <p className="text-sm sm:text-base md:text-lg text-muted-foreground max-w-3xl mx-auto leading-relaxed px-2">
            <span className="font-headline text-shadow-sm">SHRIRAM INTERIO</span> — {aboutCompany.text}
          </p>
        </div>
      </section>
      )}

       {/* Why Shriram Interio Section */}
       {whyUs.visible && (
        <section className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
            <div className="container mx-auto px-4 sm:px-6">
                <div className="text-center mb-8 sm:mb-12">
                    <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">
                      {whyUs.title}
                    </h2>
                    <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">{whyUs.subtitle}</p>
                </div>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 sm:gap-8">
                    {whyShriramInterio.map((item: any, index: number) => (
                        <Card key={index} className="text-center p-4 sm:p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                            <CardHeader className="items-center pb-2 sm:pb-4">
                                {
                                  {
                                    'Expert Design Team': <Users className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
                                    'Variety of Design Choices': <Layers className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
                                    'Affordable Design Fees': <IndianRupee className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
                                    'On-Time Project Delivery': <CalendarCheck className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />,
                                  }[item.title]
                                }
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
       )}
        
      {/* Work Gallery Section */}
      {workGallery.visible && (
      <section className="py-12 sm:py-16 md:py-20 lg:py-24 bg-secondary">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="text-center mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">{workGallery.title}</h2>
            <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">{workGallery.subtitle}</p>
          </div>
          <Carousel opts={{ align: 'start', loop: true }} className="w-full max-w-6xl mx-auto">
            <CarouselContent className="-ml-2 sm:-ml-4">
              {workGalleryItems.map((item: any, index: number) => (
                <CarouselItem key={index} className="pl-2 sm:pl-4 basis-4/5 xs:basis-3/5 sm:basis-1/2 lg:basis-1/3">
                  <Card className="overflow-hidden group">
                    <div className="relative aspect-video">
                      <Image src={item.image} alt={item.title} layout="fill" objectFit="cover" data-ai-hint={item.hint} className="transition-transform duration-500 group-hover:scale-105" />
                       <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/20 to-transparent" />
                       <CardContent className="p-4 absolute bottom-0 left-0">
                        <h3 className="text-lg font-bold text-white text-shadow-md">{item.title}</h3>
                      </CardContent>
                    </div>
                  </Card>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious className="left-2 sm:-left-8" />
            <CarouselNext className="right-2 sm:-right-8" />
          </Carousel>
        </div>
      </section>
      )}

      {/* Design at Your Comfort Section */}
      {comfortDesign.visible && (
      <section id="comfort-design" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
        <div className="container mx-auto px-4 sm:px-6">
           <div className="text-center mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold leading-tight mb-2">{comfortDesign.title}</h2>
            <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 max-w-3xl mx-auto leading-relaxed px-2">{comfortDesign.subtitle}</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 sm:gap-8">
            {expertise.map((item: any) => (
              <Card key={item.title} className="text-center p-4 sm:p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-secondary">
                 <CardHeader className="flex items-center justify-center pb-2 sm:pb-4">
                  {
                    {
                      'Live 3D Designs': <Video className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
                      'Contactless Experience': <Smartphone className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
                      'Instant Pricing': <IndianRupee className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
                      'Expertise & Passion': <Tv className="w-6 h-6 sm:w-8 sm:h-8 text-primary" />,
                    }[item.title]
                  }
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
      )}

      {/* Trending Section */}
      {whatWeDo.visible && (
      <section className="py-12 sm:py-16 md:py-20 lg:py-24 bg-secondary">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="text-center mb-8 sm:mb-12">
              <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">{whatWeDo.title}</h2>
              <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">{whatWeDo.subtitle}</p>
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
                  {trendingItems.map((item: any, index: number) => (
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
                  {bestSellingKitchens.map((item: any, index: number) => (
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
                  {bestSellingWardrobes.map((item: any, index: number) => (
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
      )}

      {/* Testimonials Section */}
      {testimonials.visible && (
      <section id="testimonials" className="py-12 sm:py-16 md:py-20 lg:py-24 bg-background">
        <div className="container mx-auto px-4 sm:px-6">
          <div className="text-center mb-8 sm:mb-12">
            <h2 className="text-2xl sm:text-3xl md:text-4xl font-bold mb-2">{testimonials.title}</h2>
            <p className="text-sm sm:text-base md:text-lg text-muted-foreground mt-2 px-2">{testimonials.subtitle}</p>
          </div>
          <Carousel
            opts={{ align: 'start', loop: true }}
            className="w-full max-w-6xl mx-auto"
          >
            <CarouselContent className="-ml-2 sm:-ml-4">
              {testimonialsItems.map((testimonial: any, index: number) => (
                <CarouselItem key={index} className="pl-2 sm:pl-4 basis-full sm:basis-1/2 lg:basis-1/3">
                   <Card className="overflow-hidden group h-full flex flex-col">
                        <div className="relative aspect-square">
                           <Image src={testimonial.image} alt={testimonial.name} layout="fill" objectFit="cover" data-ai-hint="person portrait" className="transition-transform duration-500 group-hover:scale-105"/>
                        </div>
                        <CardContent className="p-4 sm:p-6 bg-secondary flex-grow flex flex-col text-center">
                            <p className="text-xs sm:text-sm text-muted-foreground italic leading-relaxed flex-grow">"{testimonial.review}"</p>
                            <div className="mt-4 sm:mt-6 pt-4 border-t">
                                <p className="font-bold font-headline text-xs sm:text-sm leading-tight">{testimonial.name}</p>
                            </div>
                        </CardContent>
                    </Card>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious className="left-2 sm:-left-4" />
            <CarouselNext className="right-2 sm:-right-4" />
          </Carousel>
          <div className="text-center mt-8 sm:mt-12">
            <Button asChild size="default" className="text-sm sm:text-base">
              <Link href="/clients">{testimonials.buttonText}</Link>
            </Button>
          </div>
        </div>
      </section>
      )}

      {/* FAQ Section */}
      {faq.visible && (
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">{faq.title}</h2>
            <p className="text-lg text-muted-foreground mt-2">{faq.subtitle}</p>
          </div>
          <div className="max-w-3xl mx-auto">
            <Accordion type="single" collapsible className="w-full">
              {faqItems.map((item: any, index: number) => (
                <AccordionItem key={index} value={`item-${index + 1}`}>
                  <AccordionTrigger className="text-lg font-semibold text-left">{item.question}</AccordionTrigger>
                  <AccordionContent className="text-muted-foreground">
                    {item.answer}
                  </AccordionContent>
                </AccordionItem>
              ))}
            </Accordion>
          </div>
        </div>
      </section>
      )}

      {/* Partners Section */}
      {partners.visible && (
      <section className="py-16 md:py-24 bg-background">
          <div className="container mx-auto px-4">
              <div className="text-center mb-12">
                  <div className="flex justify-center items-center mb-2">
                      <div className="border-t border-primary w-12"></div>
                      <p className="text-sm text-primary font-bold tracking-widest mx-4">{partners.subtitle}</p>
                      <div className="border-t border-primary w-12"></div>
                  </div>
                  <h2 className="text-3xl md:text-4xl font-bold">{partners.title}</h2>
              </div>
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-8 items-center">
                  {partnersItems.map((partner: any) => (
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
      )}
    </div>
  );
}
