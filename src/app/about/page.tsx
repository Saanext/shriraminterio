
import Image from 'next/image';
import { Users, Target, Eye, Layers, IndianRupee, CalendarCheck } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarImage, AvatarFallback } from '@/components/ui/avatar';

const teamMembers = [
    {
        name: 'Shriram P.',
        role: 'Founder & Principal Designer',
        avatar: 'SP',
        image: '/team-member-1.png',
        bio: 'With a passion for creating beautiful and functional spaces, Shriram leads the creative vision of the company.'
    },
    {
        name: 'Sunita K.',
        role: 'Head of Operations',
        avatar: 'SK',
        image: '/team-member-2.png',
        bio: 'Sunita ensures that every project is executed flawlessly from concept to completion, managing all operational aspects.'
    },
    {
        name: 'Rahul Desai',
        role: 'Lead Interior Designer',
        avatar: 'RD',
        image: '/team-member-3.png',
        bio: 'Rahul specializes in residential design, bringing a wealth of creativity and technical skill to every home he transforms.'
    },
];

export default function AboutUsPage() {
    return (
        <div className="bg-background">
            {/* Hero Section */}
            <section className="relative w-full h-[50vh] flex items-center justify-center text-center text-white">
                <Image
                  src="/b1.jpg"
                  alt="A modern, well-lit office interior"
                  data-ai-hint="modern office interior"
                  layout="fill"
                  objectFit="cover"
                  className="absolute inset-0 z-0 brightness-50"
                />
                <div className="relative z-10 p-4">
                    <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">About Shriram Interio</h1>
                    <p className="mt-2 text-lg md:text-xl text-primary-foreground/90">Your vision, our passion.</p>
                </div>
            </section>

            {/* Our Story Section */}
            <section className="py-16 md:py-24">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                        <div>
                            <h2 className="text-3xl md:text-4xl font-bold mb-4">Welcome to Shriram Interio</h2>
                             <p className="text-sm text-muted-foreground mb-2">Since we started work in 2016</p>
                            <p className="text-muted-foreground mb-4">
                                Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team consists of the most passionate and best interior designers in Pune who love what they do and are committed to creating beautiful and functional spaces that reflect our client's unique styles and needs.
                            </p>
                            <p className="text-muted-foreground mb-4">
                                We specialize in designing and decorating residential spaces. With years of experience in the industry, we have honed our skills in space planning, color theory, furniture selection, and lighting design.
                            </p>
                             <p className="text-muted-foreground mb-4">
                                We strongly believe that a well-designed interior can have a profound impact on people's lives. That's why we take the time to truly understand our client's aspirations and preferences for their space. By working closely with them, we develop a personalized design plan that perfectly fits their aesthetic preferences, lifestyle, and budget.
                            </p>
                             <p className="text-muted-foreground">
                                Whether you want to give your living room a makeover, update your kitchen, or transform your entire home, our team is here to turn your dreams into reality. Feel Free to Contact us for a consultation and take the first step toward creating your dream space !!
                            </p>
                        </div>
                        <div>
                            <Image
                                src="/r1.jpg"
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
            
            {/* Our Journey Section */}
            <section className="py-16 md:py-24 bg-secondary">
                <div className="container mx-auto px-4">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                         <div>
                            <Image
                                src="/SlidingWardrobe.jpg"
                                alt="A mood board with design samples"
                                data-ai-hint="design mood board"
                                width={600}
                                height={450}
                                className="rounded-lg shadow-2xl object-cover w-full h-full"
                            />
                        </div>
                        <div>
                            <h2 className="text-3xl md:text-4xl font-bold mb-4">Our Journey</h2>
                            <p className="text-muted-foreground mb-4">
                                We have a deep love for Interior Design and a strong vision of creating spaces that are both beautiful and functional for our clients. This passion led us to start our own interior design company in Pune, where we are dedicated to delivering exceptional designs and personalized services to every client.
                            </p>
                            <p className="text-muted-foreground mb-4">
                                As we embarked on this journey, we worked hard to establish a strong brand identity and build a portfolio of our best work. With the growth of our brand, our client base also expanded. We now work with clients from diverse backgrounds, including families who want to update their homes and create warm and functional spaces.
                            </p>
                             <p className="text-muted-foreground mb-4">
                               With every new project, Shriram Interiors' interior design team approaches the design process with a fresh perspective. Our goal is not only to create stunning designs but also to ensure that the spaces we design are practical and serve their intended purpose.
                            </p>
                             <p className="text-muted-foreground">
                                Over time, Shriram Interio has experienced tremendous growth and expansion. We have welcomed more talented designers and staff members to our team, further enhancing our capabilities to serve our clients. We are excited to continue our journey of creating beautiful and functional spaces, and we look forward to the opportunity to work with you.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

             {/* Our Values Section */}
            <section className="py-16 md:py-24 bg-background">
                <div className="container mx-auto px-4">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl md:text-4xl font-bold">What we do</h2>
                        <p className="text-lg text-muted-foreground mt-2">Our Values</p>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                        <Card className="p-6 text-center">
                            <Users className="h-12 w-12 text-primary mx-auto mb-4" />
                            <CardHeader>
                                <CardTitle>Expert Design Team</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-muted-foreground">Our team of designers brings a wealth of expertise, creativity, and a keen eye for detail to every project. Our designers combine their diverse backgrounds and unique perspectives to curate interiors that captivate and inspire.</p>
                            </CardContent>
                        </Card>
                        <Card className="p-6 text-center">
                            <Layers className="h-12 w-12 text-primary mx-auto mb-4" />
                            <CardHeader>
                                <CardTitle>Variety of Design Choices</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-muted-foreground">Enjoy multiple Interior design alternatives until they match your expectations & requirement. We pride ourselves on our ability to offer an array of design,let us guide you on a journey to discover the perfect style that speaks to your soul</p>
                            </CardContent>
                        </Card>
                        <Card className="p-6 text-center">
                            <IndianRupee className="h-12 w-12 text-primary mx-auto mb-4" />
                             <CardHeader>
                                <CardTitle>Affordable Design Fees</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-muted-foreground">We believe in making high-quality design services accessible to everyone. We offer competitive and transparent design fees tailored to suit various budgets.Affordable design solutions can transform your space as per your vision.</p>
                            </CardContent>
                        </Card>
                        <Card className="p-6 text-center">
                             <CalendarCheck className="h-12 w-12 text-primary mx-auto mb-4" />
                             <CardHeader>
                                <CardTitle>On-Time Project Delivery</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-muted-foreground">We understand the importance of time and deadlines. Our commitment to excellence extends to ensuring on-time project delivery allowing you to experience the joy of your newly transformed space exactly when expected</p>
                            </CardContent>
                        </Card>
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
            <section className="py-16 md:py-24 bg-background">
                <div className="container mx-auto px-4">
                    <div className="text-center mb-12">
                        <h2 className="text-3xl md:text-4xl font-bold">Meet Our Team</h2>
                        <p className="text-lg text-muted-foreground mt-2">The creative minds behind our success.</p>
                    </div>
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        {teamMembers.map((member) => (
                            <Card key={member.name} className="overflow-hidden group h-full flex flex-col">
                                <div className="relative aspect-square">
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
        </div>
    );
}
