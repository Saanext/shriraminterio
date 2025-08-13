import Image from 'next/image';
import { Users, Target, Eye } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarImage, AvatarFallback } from '@/components/ui/avatar';

const teamMembers = [
    {
        name: 'Shriram P.',
        role: 'Founder & Principal Designer',
        avatar: 'SP',
        image: 'https://placehold.co/100x100.png',
        bio: 'With a passion for creating beautiful and functional spaces, Shriram leads the creative vision of the company.'
    },
    {
        name: 'Sunita K.',
        role: 'Head of Operations',
        avatar: 'SK',
        image: 'https://placehold.co/100x100.png',
        bio: 'Sunita ensures that every project is executed flawlessly from concept to completion, managing all operational aspects.'
    },
    {
        name: 'Rahul Desai',
        role: 'Lead Interior Designer',
        avatar: 'RD',
        image: 'https://placehold.co/100x100.png',
        bio: 'Rahul specializes in residential design, bringing a wealth of creativity and technical skill to every home he transforms.'
    },
];

export default function AboutUsPage() {
    return (
        <div className="bg-background">
            {/* Hero Section */}
            <section className="relative w-full h-60 flex items-center justify-center text-center text-white bg-primary">
                <div className="relative z-10 p-4">
                    <h1 className="text-4xl md:text-5xl font-bold">About Shriram Interio</h1>
                    <p className="mt-2 text-lg text-primary-foreground/90">Your vision, our passion.</p>
                </div>
            </section>

            {/* Our Story Section */}
            <section className="py-16 md:py-24">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                        <div>
                            <h2 className="text-3xl md:text-4xl font-bold mb-4">Our Story</h2>
                            <p className="text-muted-foreground mb-4">
                                Since our establishment in 2016, Shriram Interio has been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our journey began with a simple mission: to transform houses into homes that reflect the unique personalities and lifestyles of their owners.
                            </p>
                            <p className="text-muted-foreground">
                                Our team of passionate and skilled interior designers specializes in designing and decorating residential spaces — focusing on space planning, color theory, furniture selection, and lighting design. We believe that well-designed interiors have the power to transform lives. By truly understanding our client’s aspirations, we create personalized plans that fit their style, and their budget.
                            </p>
                        </div>
                        <div>
                            <Image
                                src="https://placehold.co/600x450.png"
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

            {/* Mission and Vision Section */}
            <section className="py-16 md:py-24 bg-secondary">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-8 text-center">
                        <div className="p-6">
                            <Eye className="h-12 w-12 text-primary mx-auto mb-4" />
                            <h3 className="text-2xl font-bold mb-2">Our Vision</h3>
                            <p className="text-muted-foreground">To be the most trusted and creative interior design firm in Maharashtra, known for our innovative solutions and unwavering commitment to quality.</p>
                        </div>
                        <div className="p-6">
                            <Target className="h-12 w-12 text-primary mx-auto mb-4" />
                            <h3 className="text-2xl font-bold mb-2">Our Mission</h3>
                            <p className="text-muted-foreground">To create beautiful, functional, and personal living spaces by listening to our clients, embracing creativity, and delivering excellence in every detail.</p>
                        </div>
                    </div>
                </div>
            </section>

            {/* Meet the Team Section */}
            <section className="py-16 md:py-24">
                <div className="container mx-auto px-4">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl md:text-4xl font-bold">Meet Our Team</h2>
                        <p className="text-lg text-muted-foreground mt-2">The creative minds behind our success.</p>
                    </div>
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        {teamMembers.map((member) => (
                            <Card key={member.name} className="text-center">
                                <CardHeader className="items-center">
                                    <Avatar className="h-24 w-24 mb-4">
                                        <AvatarImage src={member.image} alt={member.name} data-ai-hint="person portrait" />
                                        <AvatarFallback>{member.avatar}</AvatarFallback>
                                    </Avatar>
                                    <CardTitle>{member.name}</CardTitle>
                                    <p className="text-primary font-semibold">{member.role}</p>
                                </CardHeader>
                                <CardContent>
                                    <p className="text-muted-foreground">{member.bio}</p>
                                </CardContent>
                            </Card>
                        ))}
                    </div>
                </div>
            </section>
        </div>
    );
}
