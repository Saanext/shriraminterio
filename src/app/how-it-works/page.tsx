
import { Handshake, PencilRuler, Truck, ShieldCheck, Star, ThumbsUp, Wallet, Smile, ArrowRight } from 'lucide-react';
import Image from 'next/image';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import Link from 'next/link';
import { Button } from '@/components/ui/button';

const processSteps = [
  {
    icon: <Handshake className="h-10 w-10 text-primary" />,
    title: '1. Consultation & Requirement Gathering',
    description: "We start by understanding your vision, needs, and budget. Our experts will visit your site or connect with you virtually to discuss your requirements in detail.",
  },
  {
    icon: <PencilRuler className="h-10 w-10 text-primary" />,
    title: '2. Design & 3D Visualization',
    description: "Our designers create personalized 2D and 3D designs, allowing you to visualize your space before it's built. We offer live 3D sessions for a truly contactless experience.",
  },
  {
    icon: <Truck className="h-10 w-10 text-primary" />,
    title: '3. Manufacturing & Delivery',
    description: "Once the design is finalized, our state-of-the-art manufacturing unit gets to work. We ensure timely and safe delivery of all components to your doorstep.",
  },
  {
    icon: <ShieldCheck className="h-10 w-10 text-primary" />,
    title: '4. Installation & Handover',
    description: "Our professional installation team assembles everything with precision. We conduct a final quality check before handing over your brand new, dream interior.",
  },
  {
    icon: <Star className="h-10 w-10 text-primary" />,
    title: '5. Warranty & Support',
    description: "Your satisfaction is our priority. We provide a one-year warranty on our work and are always available for any post-installation support you may need.",
  },
];

const benefits = [
    {
        icon: <ThumbsUp className="w-10 h-10 text-primary" />,
        title: 'Unmatched Quality',
        description: 'We use only the finest materials and partner with trusted brands to ensure your interiors are not just beautiful but also durable and long-lasting.',
    },
    {
        icon: <Wallet className="w-10 h-10 text-primary" />,
        title: 'Transparent Pricing',
        description: 'No hidden costs. We provide detailed quotes and work within your budget, ensuring complete transparency from start to finish.',
    },
    {
        icon: <Smile className="w-10 h-10 text-primary" />,
        title: 'Customer-Centric Approach',
        description: 'Your satisfaction is our ultimate goal. We work collaboratively, keeping you informed and involved at every stage of the design process.',
    },
];

export default function HowItWorksPage() {
  return (
    <div className="bg-background">
      {/* Hero Section */}
      <section className="relative w-full h-[50vh] flex items-center justify-center text-center text-white">
        <Image
          src="/how-it-works-hero.jpg"
          alt="A team of interior designers collaborating on a project"
          data-ai-hint="design team collaboration"
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0 brightness-50"
        />
        <div className="relative z-10 p-4">
          <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">How It Works</h1>
          <p className="mt-2 text-lg md:text-xl text-primary-foreground/90">Your seamless journey from concept to reality.</p>
        </div>
      </section>

      {/* Our Process Section */}
      <section className="bg-secondary">
        <div className="container mx-auto px-4 py-16 md:py-24">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold">Our 5-Step Process</h2>
            <p className="text-lg text-muted-foreground mt-2">A seamless journey from concept to completion.</p>
          </div>

          <div className="relative">
            {/* Timeline line */}
            <div className="absolute left-1/2 -translate-x-1/2 h-full w-0.5 bg-border hidden md:block" aria-hidden="true"></div>

            <div className="space-y-16">
              {processSteps.map((step, index) => (
                <div key={index} className="flex flex-col md:flex-row items-center w-full">
                  {/* Content */}
                  <div className={`md:w-5/12 ${index % 2 === 0 ? 'md:order-1 pr-8' : 'md:order-3 md:pl-8'}`}>
                    <div className="p-6 border rounded-lg shadow-md bg-card">
                      <div className="flex items-center mb-2 md:hidden">
                        <div className="bg-primary/10 p-2 rounded-full mr-4">
                          {step.icon}
                        </div>
                        <h3 className="text-xl font-bold">{step.title}</h3>
                      </div>
                      <h3 className="text-2xl font-bold hidden md:block">{step.title}</h3>
                      <p className="mt-2 text-muted-foreground">{step.description}</p>
                    </div>
                  </div>

                  {/* Icon Middle */}
                  <div className="w-full md:w-2/12 order-2 flex justify-center">
                    <div className="md:absolute z-10 bg-background p-3 rounded-full border-2 border-primary my-4 md:my-0">
                      {step.icon}
                    </div>
                  </div>

                  {/* Spacer */}
                  <div className={`md:w-5/12 ${index % 2 === 0 ? 'md:order-3' : 'md:order-1'}`}></div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Why Our Process Works Section */}
      <section className="py-16 md:py-24 bg-background">
            <div className="container mx-auto px-4">
                <div className="text-center mb-12">
                    <h2 className="text-3xl md:text-4xl font-bold">Why Our Process Works</h2>
                    <p className="text-lg text-muted-foreground mt-2">We've refined our approach to guarantee a smooth and successful project.</p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    {benefits.map((item, index) => (
                        <Card key={index} className="text-center p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                            <CardHeader className="items-center">
                                {item.icon}
                                <CardTitle className="mt-4 text-xl">{item.title}</CardTitle>
                            </CardHeader>
                            <CardContent>
                                <p className="text-muted-foreground">{item.description}</p>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            </div>
        </section>

      {/* Get Started Section */}
      <section className="py-16 md:py-24 bg-secondary">
          <div className="container mx-auto px-4 text-center">
              <h2 className="text-3xl md:text-4xl font-bold mb-4">Ready to Start Your Project?</h2>
              <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
                  Let's bring your vision to life. Schedule a free, no-obligation consultation with our design experts today.
              </p>
              <Button asChild size="lg">
                  <Link href="/appointment">
                      Book a Free Consultation <ArrowRight className="ml-2 h-5 w-5" />
                  </Link>
              </Button>
          </div>
      </section>
    </div>
  );
}
