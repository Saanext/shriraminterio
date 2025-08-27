
import Image from 'next/image';
import { notFound } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { CalendarDays, Tag, User, MapPin, Building, Bed } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { createClient } from '@/lib/supabase/server';

async function getStory(slug: string) {
    const supabase = createClient();
    const { data: story } = await supabase
        .from('stories')
        .select('*')
        .eq('slug', slug)
        .single();
    
    if (!story) {
        return null;
    }
    
    return story;
}


export default async function StoryPage({ params }: { params: { slug: string } }) {
  const story = await getStory(params.slug);

  if (!story) {
    notFound();
  }

  return (
    <div className="bg-background">
      {/* Hero Section */}
      <section className="relative w-full h-[60vh] text-white">
        <Image
          src={story.image}
          alt={story.title}
          fill
          objectFit="cover"
          className="absolute inset-0 z-0 brightness-50"
          data-ai-hint={story.dataAiHint}
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent z-10" />
        <div className="relative container mx-auto px-4 h-full flex flex-col justify-end pb-16 z-20">
          <Badge variant="secondary" className="w-fit mb-4">{story.category}</Badge>
          <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">{story.title}</h1>
          <div className="flex items-center gap-6 mt-4 text-lg">
            <div className="flex items-center gap-2">
                <Avatar className="h-10 w-10 border-2 border-white">
                    <AvatarImage src={story.authorAvatar} alt={story.author} />
                    <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                </Avatar>
                <span>{story.author}</span>
            </div>
            <div className="flex items-center gap-2">
                <CalendarDays className="h-5 w-5" />
                <span>{story.date}</span>
            </div>
          </div>
        </div>
      </section>
      
      {/* Featured Testimonial Section */}
      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="relative aspect-[4/5] rounded-lg overflow-hidden shadow-2xl">
              <Image 
                src={story.clientImage} 
                alt={story.author} 
                fill
                objectFit="cover"
                data-ai-hint="smiling person"
              />
            </div>
            <div>
              <div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-sm text-muted-foreground mb-4">
                  <div className="flex items-center gap-2">
                      <MapPin className="w-4 h-4 text-primary" />
                      <span>{story.location}</span>
                  </div>
                  <span className="text-primary">&bull;</span>
                   <div className="flex items-center gap-2">
                      <Building className="w-4 h-4 text-primary" />
                      <span>{story.project}</span>
                  </div>
                   <span className="text-primary">&bull;</span>
                   <div className="flex items-center gap-2">
                      <Bed className="w-4 h-4 text-primary" />
                      <span>{story.size}</span>
                  </div>
              </div>
              <h2 className="relative text-2xl md:text-3xl font-bold font-headline mb-6 pl-8">
                 <span className="absolute left-0 top-0 text-6xl text-primary/20 font-serif -mt-2">“</span>
                 {story.quote}
              </h2>
               <div className="w-16 h-1 bg-primary mb-6"></div>
              <p className="font-bold text-lg mb-2">{story.author}</p>
                <div
                className="prose max-w-none text-muted-foreground space-y-6"
                dangerouslySetInnerHTML={{ __html: story.content }}
              />
            </div>
          </div>
        </div>
      </section>

      {/* Gallery Section */}
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">Project Gallery</h2>
            <p className="text-lg text-muted-foreground mt-2">A closer look at the transformation.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            {story.gallery.map((photo: any, index: number) => (
              <Card key={index} className="overflow-hidden group">
                <div className="relative aspect-video">
                  <Image
                    src={photo.src}
                    alt={photo.alt}
                    fill
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint={photo.dataAiHint}
                  />
                  <div className="absolute inset-0 bg-black/20" />
                </div>
              </Card>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}

// Generate static paths for stories that exist at build time
export async function generateStaticParams() {
    const supabase = createClient();
    const { data: stories } = await supabase.from('stories').select('slug');

    return stories?.map(({ slug }) => ({
        slug,
    })) || [];
}
