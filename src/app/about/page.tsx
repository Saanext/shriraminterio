

import Image from 'next/image';
import { Users, Target, Eye, Layers, IndianRupee, CalendarCheck } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

async function getContent() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'about')
        .single();
    
    if (!page) {
        return null;
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


export default async function AboutUsPage() {
    const aboutContent = await getContent();

    if (!aboutContent) {
        notFound();
    }
    
    return (
        <div className="bg-background">
            {/* Hero Section */}
            {aboutContent.hero.visible && (
            <section className="relative w-full h-[50vh] flex items-center justify-center text-center text-white">
                <Image
                  src={aboutContent.hero.backgroundImage}
                  alt="A modern, well-lit office interior"
                  data-ai-hint="modern office interior"
                  layout="fill"
                  objectFit="cover"
                  className="absolute inset-0 z-0 brightness-50"
                />
                <div className="relative z-10 p-4">
                    <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">{aboutContent.hero.title}</h1>
                    <p className="mt-2 text-lg md:text-xl text-primary-foreground/90">{aboutContent.hero.subtitle}</p>
                </div>
            </section>
            )}

            {/* Our Story Section */}
            {aboutContent.story.visible && (
            <section className="py-16 md:py-24">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                        <div>
                            <h2 className="text-3xl md:text-4xl font-bold mb-4">{aboutContent.story.heading}</h2>
                             <p className="text-sm text-muted-foreground mb-2">{aboutContent.story.subheading}</p>
                            <p className="text-muted-foreground mb-4">
                                {aboutContent.story.paragraph1}
                            </p>
                            <p className="text-muted-foreground mb-4">
                                {aboutContent.story.paragraph2}
                            </p>
                             <p className="text-muted-foreground mb-4">
                                {aboutContent.story.paragraph3}
                            </p>
                             <p className="text-muted-foreground">
                               {aboutContent.story.paragraph4}
                            </p>
                        </div>
                        <div>
                            <Image
                                src={aboutContent.story.image}
                                alt="Our design team collaborating"
                                data-ai-hint="team collaboration"
                                width={600}
                                height={450}
                                className="rounded-lg shadow-2xl object-cover w-full h-full"
                            />
                        </div>
                    </div>
                </div>
            </section>
            )}
            
            {/* Our Journey Section */}
            {aboutContent.journey.visible && (
            <section className="py-16 md:py-24 bg-secondary">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                         <div>
                            <Image
                                src={aboutContent.journey.image}
                                alt="A mood board with design samples"
                                data-ai-hint="design mood board"
                                width={600}
                                height={450}
                                className="rounded-lg shadow-2xl object-cover w-full h-full"
                            />
                        </div>
                        <div>
                            <h2 className="text-3xl md:text-4xl font-bold mb-4">{aboutContent.journey.heading}</h2>
                            <p className="text-muted-foreground mb-4">
                                {aboutContent.journey.paragraph1}
                            </p>
                            <p className="text-muted-foreground mb-4">
                                {aboutContent.journey.paragraph2}
                            </p>
                             <p className="text-muted-foreground mb-4">
                                {aboutContent.journey.paragraph3}
                            </p>
                             <p className="text-muted-foreground">
                                {aboutContent.journey.paragraph4}
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            )}

             {/* Our Values Section */}
             {aboutContent.values.visible && (
            <section className="py-16 md:py-24 bg-background">
                <div className="container mx-auto px-4">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl md:text-4xl font-bold">{aboutContent.values.title}</h2>
                        <p className="text-lg text-muted-foreground mt-2">{aboutContent.values.subtitle}</p>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                        {aboutContent.values.items.map((item: any, index: number) => (
                            <Card key={index} className="p-6 text-center">
                                {
                                    {
                                        'Expert Design Team': <Users className="h-12 w-12 text-primary mx-auto mb-4" />,
                                        'Variety of Design Choices': <Layers className="h-12 w-12 text-primary mx-auto mb-4" />,
                                        'Affordable Design Fees': <IndianRupee className="h-12 w-12 text-primary mx-auto mb-4" />,
                                        'On-Time Project Delivery': <CalendarCheck className="h-12 w-12 text-primary mx-auto mb-4" />,
                                    }[item.title]
                                }
                                <CardHeader>
                                    <CardTitle>{item.title}</CardTitle>
                                </CardHeader>
                                <CardContent>
                                    <p className="text-muted-foreground">{item.description}</p>
                                </CardContent>
                            </Card>
                        ))}
                    </div>
                </div>
            </section>
            )}

            {/* Mission and Vision Section */}
            {aboutContent.missionVision.visible && (
            <section className="py-16 md:py-24 bg-secondary">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-8 text-center">
                        <div className="p-6">
                            <Eye className="h-12 w-12 text-primary mx-auto mb-4" />
                            <h3 className="text-2xl font-bold mb-2">{aboutContent.missionVision.visionTitle}</h3>
                            <p className="text-muted-foreground">{aboutContent.missionVision.visionText}</p>
                        </div>
                        <div className="p-6">
                            <Target className="h-12 w-12 text-primary mx-auto mb-4" />
                            <h3 className="text-2xl font-bold mb-2">{aboutContent.missionVision.missionTitle}</h3>
                            <p className="text-muted-foreground">{aboutContent.missionVision.missionText}</p>
                        </div>
                    </div>
                </div>
            </section>
            )}

            {/* Meet the Team Section */}
            {aboutContent.team.visible && (
            <section className="py-16 md:py-24 bg-background">
                <div className="container mx-auto px-4">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl md:text-4xl font-bold">{aboutContent.team.title}</h2>
                        <p className="text-lg text-muted-foreground mt-2">{aboutContent.team.subtitle}</p>
                    </div>
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        {aboutContent.team.members.map((member: any) => (
                            <Card key={member.name} className="overflow-hidden group h-full flex flex-col">
                                <div className="relative aspect-[4/5]">
                                    <Image src={member.image} alt={member.name} layout="fill" objectFit="cover" data-ai-hint="person portrait" className="transition-transform duration-500 group-hover:scale-105" />
                                </div>
                                <CardContent className="p-6 bg-secondary flex-grow flex flex-col text-center">
                                    <CardTitle>{member.name}</CardTitle>
                                    <p className="text-primary font-semibold my-2">{member.role}</p>
                                    <p className="text-muted-foreground text-sm flex-grow">{member.bio}</p>
                                </CardContent>
                            </Card>
                        ))}
                    </div>
                </div>
            </section>
            )}
        </div>
    );
}

    