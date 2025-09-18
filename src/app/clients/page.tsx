
import { Card, CardContent } from '@/components/ui/card';
import { PlayCircle, MapPin, Building, Bed } from 'lucide-react';
import Image from 'next/image';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import type { Metadata } from 'next';

export const metadata: Metadata = {
    title: 'Our Clients',
    description: 'See what our happy clients in Pune have to say about their experience with Shriram Interio Digital. Read testimonials and watch video reviews.',
};

export const dynamic = 'force-dynamic';

// Helper function to extract YouTube video ID and create thumbnail URL
const getYouTubeThumbnail = (url: string) => {
    if (!url || (!url.includes('youtube.com') && !url.includes('youtu.be'))) return null;
    let videoId;
    const urlParams = new URLSearchParams(new URL(url).search);
    videoId = urlParams.get('v');
    if (!videoId) {
        videoId = url.split('/').pop();
        if (videoId && videoId.includes('?')) {
            videoId = videoId.split('?')[0];
        }
    }
    return `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`;
}

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'clients')
        .single();

    const { data: testimonialsData } = await supabase
        .from('testimonials')
        .select('*')
        .order('created_at', { ascending: false });

    if (!page) {
        notFound();
    }

    const featuredTestimonial = testimonialsData?.find(t => t.is_featured) || testimonialsData?.[0];

    const content: { [key: string]: any } = {};
    for (const section of page.sections) {
        const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
        content[sectionKey] = {
            ...section.content,
            visible: section.visible,
            title: section.content?.title || section.title,
        };
    }
    
    // Process video thumbnails
    if (content.videoTestimonials && content.videoTestimonials.videos) {
        content.videoTestimonials.videos.forEach((video: any) => {
            if (video.videoUrl && !video.imageSrc) {
                video.imageSrc = getYouTubeThumbnail(video.videoUrl);
            }
        });
    }

    return { ...content, meta: { title: page.meta_title, description: page.meta_description }, featuredTestimonial };
}

export default async function ClientsPage() {
    const pageContent = await getContent();

    if (!pageContent || !pageContent.featuredTestimonial) {
        notFound();
    }

    const { featuredTestimonial, videoTestimonials } = pageContent;

  return (
    <div className="bg-background">
      {/* Featured Testimonial Section */}
      {featuredTestimonial && (
      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            <div className="relative aspect-[4/5] rounded-lg overflow-hidden shadow-2xl">
              <Image 
                src={featuredTestimonial.client_image_url} 
                alt={featuredTestimonial.client_name} 
                fill
                objectFit="cover"
                data-ai-hint="smiling person"
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
                      <span>{featuredTestimonial.project_type}</span>
                  </div>
                   <span className="text-primary">&bull;</span>
                   <div className="flex items-center gap-2">
                      <Bed className="w-4 h-4 text-primary" />
                      <span>{featuredTestimonial.project_size}</span>
                  </div>
              </div>
              <h2 className="relative text-2xl md:text-3xl font-bold font-headline mb-6 pl-8">
                 <span className="absolute left-0 top-0 text-6xl text-primary/20 font-serif -mt-2">“</span>
                 {featuredTestimonial.quote}
              </h2>
               <div className="w-16 h-1 bg-primary mb-6"></div>
              <p className="font-bold text-lg mb-2">{featuredTestimonial.client_name}</p>
              <p className="text-muted-foreground">
                {featuredTestimonial.full_review}
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
                          src={video.imageSrc || `https://img.youtube.com/vi/placeholder/hqdefault.jpg`}
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
    </div>
  );
}
