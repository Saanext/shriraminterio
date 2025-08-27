
import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { ArrowRight, CalendarDays } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from '@/components/ui/accordion';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'customer-stories')
        .single();
    
    if (!page) {
        return { content: null, stories: [] };
    }
    
    const { data: stories } = await supabase.from('stories').select('*').order('date', { ascending: false });

    const content: { [key: string]: any } = {};
    for (const section of page.sections) {
        const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
        content[sectionKey] = {
            ...section.content,
            visible: section.visible,
            title: section.title,
        };
    }
    
    return { content: { ...content, meta: { title: page.meta_title, description: page.meta_description } }, stories: stories || [] };
}

const FeaturedStory = ({ story, buttonText }: { story: any, buttonText: string }) => (
    <section className="bg-secondary mb-16 md:mb-24">
        <div className="container mx-auto px-4 py-16">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-12 items-center">
                <div className="relative aspect-[4/3] rounded-lg overflow-hidden shadow-2xl">
                    <Image 
                        src={story.image}
                        alt={story.title}
                        fill
                        objectFit="cover"
                        data-ai-hint={story.dataAiHint}
                    />
                </div>
                <div className="flex flex-col justify-center">
                    <Badge variant="default" className="w-fit mb-4">{story.category}</Badge>
                    <h1 className="text-3xl md:text-4xl font-bold font-headline mb-4">{story.title}</h1>
                    <p className="text-muted-foreground text-lg mb-6">{story.excerpt}</p>
                    <div className="flex items-center gap-4 text-sm text-muted-foreground mb-8">
                        <Avatar className="h-10 w-10">
                            <AvatarImage src={story.authorAvatar} alt={story.author} />
                            <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                        </Avatar>
                        <div>
                            <span className="font-semibold text-foreground">{story.author}</span>
                            <div className="flex items-center gap-2">
                                <CalendarDays className="h-4 w-4" />
                                <span>{story.date}</span>
                            </div>
                        </div>
                    </div>
                     <Button asChild size="lg">
                        <Link href={`/customer-stories/${story.slug}`}>
                            {buttonText} <ArrowRight className="ml-2 h-5 w-5" />
                        </Link>
                    </Button>
                </div>
            </div>
        </div>
    </section>
);


export default async function CustomerStoriesPage() {
  const { content: pageContent, stories } = await getContent();

  if (!pageContent) {
    notFound();
  }

  const { header, featuredStory, moreStories, workGallery, partners, faq } = pageContent;
  
  const [featured, ...otherStories] = stories;
  const galleryItems = workGallery?.items || [];
  const partnerItems = partners?.items || [];
  const faqItems = faq?.items || [];

  return (
    <div className="bg-background">
        {header.visible && (
        <div className="py-16 md:py-24 text-center">
             <div className="container mx-auto px-4">
                 <h1 className="text-4xl md:text-5xl font-bold">{header.title}</h1>
                 <p className="text-lg text-muted-foreground mt-2 max-w-3xl mx-auto">
                    {header.subtitle}
                 </p>
             </div>
        </div>
        )}

        {featuredStory.visible && featured && <FeaturedStory story={featured} buttonText={featuredStory.buttonText} />}

        {moreStories.visible && (
        <div className="container mx-auto px-4 pb-16 md:pb-24">
             <h2 className="text-3xl font-bold text-center mb-12">{moreStories.title}</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                {otherStories.map((story: any) => (
                    <Link href={`/customer-stories/${story.slug}`} key={story.slug} className="group block">
                    <Card className="h-full flex flex-col overflow-hidden transition-shadow duration-300 hover:shadow-xl bg-card">
                        <div className="relative h-60">
                        <Image
                            src={story.image}
                            alt={story.title}
                            fill
                            objectFit="cover"
                            className="transition-transform duration-500 group-hover:scale-105"
                            data-ai-hint={story.dataAiHint}
                        />
                        </div>
                        <CardContent className="p-6 flex flex-col flex-grow">
                        <Badge variant="secondary" className="w-fit mb-2">{story.category}</Badge>
                        <h2 className="text-xl font-bold font-headline mb-3 flex-grow">{story.title}</h2>
                        <p className="text-muted-foreground text-sm mb-4">{story.excerpt}</p>
                        
                        <div className="flex items-center text-sm text-muted-foreground mt-auto pt-4 border-t">
                            <Avatar className="h-8 w-8 mr-3">
                                <AvatarImage src={story.authorAvatar} alt={story.author} />
                                <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                            </Avatar>
                            <div className="flex-grow">
                                <span className="font-semibold text-foreground">{story.author}</span>
                                <div className="flex items-center gap-2">
                                    <CalendarDays className="h-4 w-4" />
                                    <span>{story.date}</span>
                                </div>
                            </div>
                            <ArrowRight className="h-5 w-5 transition-transform duration-300 group-hover:translate-x-1 text-primary" />
                        </div>
                        </CardContent>
                    </Card>
                    </Link>
                ))}
            </div>
        </div>
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
              {galleryItems.map((item: any, index: number) => (
                <CarouselItem key={index} className="pl-2 sm:pl-4 basis-4/5 xs:basis-3/5 sm:basis-1/2 lg:basis-1/3">
                  <Card className="overflow-hidden group">
                    <div className="relative aspect-video">
                      <Image src={item.image} alt={item.title} fill objectFit="cover" data-ai-hint={item.hint} className="transition-transform duration-500 group-hover:scale-105" />
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
                  {partnerItems.map((partner: any) => (
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
    </div>
  );
}
