
import Image from 'next/image';
import { notFound } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { CalendarDays, Tag, User, MapPin, Building, Bed } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { createClient as createServerClient } from '@/lib/supabase/server';
import { createClient as createBrowserClient } from '@/lib/supabase/client';

async function getStory(slug: string) {
    const supabase = createServerClient();
    const { data: story } = await supabase
        .from('stories')
        .select('*')
        .eq('slug', slug)
        .single();
    
    if (!story) {
        notFound();
    }
    
    return story;
}


export default async function StoryPage({ params }: { params: { slug: string } }) {
  const story = await getStory(params.slug);

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
                <span>{new Date(story.date).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</span>
            </div>
          </div>
        </div>
      </section>
      
      {/* Story Content Section */}
      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-12">
            <div className="lg:col-span-2">
                <h2 className="relative text-2xl md:text-3xl font-bold font-headline mb-6 pl-8">
                    <span className="absolute left-0 top-0 text-6xl text-primary/20 font-serif -mt-2">“</span>
                    {story.quote}
                </h2>
                <div
                    className="prose max-w-none text-muted-foreground space-y-6"
                    dangerouslySetInnerHTML={{ __html: story.content }}
                />
            </div>
            <aside className="lg:col-span-1 space-y-6">
                <Card>
                    <CardHeader>
                        <CardTitle>Project Details</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-4 text-sm text-muted-foreground">
                        <div className="flex items-center gap-3">
                            <MapPin className="w-5 h-5 text-primary flex-shrink-0" />
                            <span><strong>Location:</strong> {story.location}</span>
                        </div>
                        <div className="flex items-center gap-3">
                            <Building className="w-5 h-5 text-primary flex-shrink-0" />
                            <span><strong>Project:</strong> {story.project}</span>
                        </div>
                        <div className="flex items-center gap-3">
                            <Bed className="w-5 h-5 text-primary flex-shrink-0" />
                            <span><strong>Size:</strong> {story.size}</span>
                        </div>
                    </CardContent>
                </Card>
                <Card>
                    <CardHeader>
                        <CardTitle>Client</CardTitle>
                    </CardHeader>
                    <CardContent className="flex items-center gap-4">
                         <Avatar className="h-16 w-16">
                            <AvatarImage src={story.clientImage} alt={story.author} />
                            <AvatarFallback>{story.author.substring(0, 2)}</AvatarFallback>
                        </Avatar>
                        <div>
                            <p className="font-bold text-lg">{story.author}</p>
                        </div>
                    </CardContent>
                </Card>
            </aside>
          </div>
        </div>
      </section>

      {/* Gallery Section */}
      {story.gallery && story.gallery.length > 0 && (
          <section className="py-16 md:py-24 bg-secondary">
            <div className="container mx-auto px-4">
              <div className="text-center mb-12">
                <h2 className="text-3xl md:text-4xl font-bold">Project Gallery</h2>
                <p className="text-lg text-muted-foreground mt-2">A closer look at the transformation.</p>
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                {(story.gallery as any[]).map((photo: any, index: number) => (
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
      )}
    </div>
  );
}

// Generate static paths for stories that exist at build time
export async function generateStaticParams() {
    const supabase = createBrowserClient();
    const { data: stories } = await supabase.from('stories').select('slug');

    return stories?.map(({ slug }) => ({
        slug,
    })) || [];
}
