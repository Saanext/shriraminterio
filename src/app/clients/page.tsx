
import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Star, PlayCircle, MapPin, Building, Bed } from 'lucide-react';
import Image from 'next/image';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'clients')
        .single();

    if (!page) {
        notFound();
    }

    const content: { [key: string]: any } = {};
    for (const section of page.sections) {
        const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
        content[sectionKey] = {
            ...section.content,
            visible: section.visible,
            title: section.title,
        };
    }

    return { ...content, meta: { title: page.meta_title, description: page.meta_description } };
}

const StarRating = ({ rating = 5 }: { rating?: number }) => (
  <div className="flex text-primary">
    {[...Array(rating)].map((_, i) => (
      <Star key={i} className="h-5 w-5 fill-current" />
    ))}
  </div>
);

export default async function ClientsPage() {
    const pageContent = await getContent();

    if (!pageContent) {
        notFound();
    }

    const { featuredTestimonial, videoTestimonials, textTestimonials } = pageContent;

  return (
    <div className="bg-background">
      {/* Featured Testimonial Section */}
      {featuredTestimonial.visible && (
      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="relative aspect-[4/5] rounded-lg overflow-hidden shadow-2xl">
              <Image 
                src={featuredTestimonial.image} 
                alt={featuredTestimonial.name} 
                fill
                objectFit="cover"
                data-ai-hint="smiling man"
              />
            </div>
            <div>
              <div className="flex items-center gap-4 text-sm text-muted-foreground mb-4">
                  <div className="flex items-center gap-2">
                      <MapPin className="w-4 h-4 text-primary" />
                      <span>{featuredTestimonial.location}</span>
                  </div>
                  <span className="text-primary">&bull;</span>
                   <div className="flex items-center gap-2">
                      <Building className="w-4 h-4 text-primary" />
                      <span>{featuredTestimonial.project}</span>
                  </div>
                   <span className="text-primary">&bull;</span>
                   <div className="flex items-center gap-2">
                      <Bed className="w-4 h-4 text-primary" />
                      <span>{featuredTestimonial.size}</span>
                  </div>
              </div>
              <h2 className="relative text-2xl md:text-3xl font-bold font-headline mb-6 pl-8">
                 <span className="absolute left-0 top-0 text-6xl text-primary/20 font-serif -mt-2">“</span>
                 {featuredTestimonial.quote}
              </h2>
               <div className="w-16 h-1 bg-primary mb-6"></div>
              <p className="font-bold text-lg mb-2">{featuredTestimonial.name}</p>
              <p className="text-muted-foreground">
                {featuredTestimonial.review}
              </p>
            </div>
          </div>
        </div>
      </section>
      )}

      {/* Client Videos Section */}
      {videoTestimonials.visible && (
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">{videoTestimonials.title}</h2>
            <p className="text-lg text-muted-foreground mt-2">{videoTestimonials.subtitle}</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {videoTestimonials.videos.map((video: any, index: number) => (
                <a href={video.videoUrl} target="_blank" rel="noopener noreferrer" className="group block" key={index}>
                    <Card className="overflow-hidden h-full flex flex-col">
                       <div className="relative aspect-video">
                        <Image
                          src={video.imageSrc}
                          alt={video.name}
                          fill
                          objectFit="cover"
                          className="transition-transform duration-500 group-hover:scale-105"
                          data-ai-hint={video.dataAiHint}
                        />
                        <div className="absolute inset-0 bg-black/40 flex items-center justify-center transition-colors duration-300 group-hover:bg-black/60">
                          <PlayCircle className="h-16 w-16 text-white/80 transition-transform duration-300 group-hover:scale-110" />
                        </div>
                      </div>
                      <CardContent className="p-6 bg-card flex-grow flex flex-col">
                        <h3 className="text-xl font-bold">{video.name}</h3>
                        <p className="text-sm text-muted-foreground mb-4">{video.location}</p>
                        <p className="text-muted-foreground text-sm flex-grow">{video.review}</p>
                      </CardContent>
                    </Card>
                  </a>
              ))}
            </div>
        </div>
      </section>
      )}

      {textTestimonials.visible && (
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">{textTestimonials.title}</h1>
          <p className="text-lg text-muted-foreground mt-2">{textTestimonials.subtitle}</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {textTestimonials.testimonials.map((testimonial: any) => (
            <Card key={testimonial.name} className="flex flex-col p-6">
              <CardContent className="flex-grow p-0">
                <StarRating />
                <p className="mt-4 text-muted-foreground italic">"{testimonial.review}"</p>
              </CardContent>
              <div className="mt-6 pt-6 border-t flex items-center">
                <Avatar>
                  <AvatarImage src={testimonial.image} alt={testimonial.name} data-ai-hint="person portrait" />
                  <AvatarFallback>{testimonial.avatar}</AvatarFallback>
                </Avatar>
                <p className="ml-4 font-bold font-headline">{testimonial.name}</p>
              </div>
            </Card>
          ))}
        </div>
      </div>
      )}
    </div>
  );
}
