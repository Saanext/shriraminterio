
import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { ArrowRight, CalendarDays } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
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
            title: section.content?.title || section.title, // Use content.title if available
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
                                <span>{new Date(story.date).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</span>
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
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
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
                        <p className="text-muted-foreground text-sm mb-4 line-clamp-3">{story.excerpt}</p>
                        
                        <div className="flex items-center text-sm text-muted-foreground mt-auto pt-4 border-t">
                            <Avatar className="h-8 w-8 mr-3">
                                <AvatarImage src={story.authorAvatar} alt={story.author} />
                                <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                            </Avatar>
                            <div className="flex-grow">
                                <span className="font-semibold text-foreground">{story.author}</span>
                                <div className="flex items-center gap-2">
                                    <CalendarDays className="h-4 w-4" />
                                    <span>{new Date(story.date).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</span>
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
    </div>
  );
}
