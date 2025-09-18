
import Image from 'next/image';
import { notFound } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { createClient } from '@/lib/supabase/server';
import { PlayCircle } from 'lucide-react';

export const dynamic = 'force-dynamic';

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
            title: section.content?.title || section.title,
        };
    }
    
    return { ...content, meta: { title: page.meta_title, description: page.meta_description } };
}

const getYouTubeVideoId = (url: string) => {
    if (!url) return null;
    const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    const match = url.match(regExp);
    return (match && match[2].length === 11) ? match[2] : null;
};

export default async function ClientsPage() {
    const { header, testimonials, videoTestimonials } = await getContent();

    return (
        <div className="bg-background">
            {/* Header Section */}
            {header.visible && (
                <section className="py-16 md:py-24 bg-secondary">
                    <div className="container mx-auto px-4 text-center">
                        <h1 className="text-4xl md:text-5xl font-bold">{header.title}</h1>
                        <p className="text-lg text-muted-foreground mt-2 max-w-3xl mx-auto">
                            {header.subtitle}
                        </p>
                    </div>
                </section>
            )}

            {/* Testimonials Section */}
            {testimonials.visible && (
                <section className="py-16 md:py-24">
                    <div className="container mx-auto px-4">
                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                            {(testimonials.items || []).map((testimonial: any, index: number) => (
                                <Card key={index} className="flex flex-col">
                                    <CardHeader className="flex flex-row items-center gap-4">
                                        <Avatar className="h-12 w-12">
                                            <AvatarFallback>{testimonial.initials}</AvatarFallback>
                                        </Avatar>
                                        <div>
                                            <CardTitle>{testimonial.name}</CardTitle>
                                        </div>
                                    </CardHeader>
                                    <CardContent className="flex-grow">
                                        <p className="text-muted-foreground italic">"{testimonial.review}"</p>
                                    </CardContent>
                                </Card>
                            ))}
                        </div>
                    </div>
                </section>
            )}

            {/* Video Testimonials Section */}
            {videoTestimonials.visible && (
                <section className="py-16 md:py-24 bg-secondary">
                    <div className="container mx-auto px-4">
                        <div className="text-center mb-12">
                            <h2 className="text-3xl md:text-4xl font-bold">{videoTestimonials.title}</h2>
                            <p className="text-lg text-muted-foreground mt-2">{videoTestimonials.subtitle}</p>
                        </div>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                            {(videoTestimonials.videos || []).map((video: any, index: number) => {
                                const videoId = getYouTubeVideoId(video.videoUrl);
                                return videoId ? (
                                    <Card key={index}>
                                        <CardContent className="p-0">
                                            <div className="aspect-video relative group">
                                                <iframe
                                                    src={`https://www.youtube.com/embed/${videoId}`}
                                                    title={video.clientName}
                                                    frameBorder="0"
                                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                    allowFullScreen
                                                    className="w-full h-full rounded-t-lg"
                                                ></iframe>
                                            </div>
                                            <div className="p-6">
                                                <h3 className="text-xl font-bold">{video.clientName}</h3>
                                                <p className="text-muted-foreground">{video.projectType}</p>
                                            </div>
                                        </CardContent>
                                    </Card>
                                ) : null;
                            })}
                        </div>
                    </div>
                </section>
            )}
        </div>
    );
}
