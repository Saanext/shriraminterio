
'use client';

import { Handshake, PencilRuler, Truck, ShieldCheck, Star, ArrowRight, ThumbsUp, Wallet, Smile } from 'lucide-react';
import Image from 'next/image';
import { Card, CardContent } from '@/components/ui/card';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { motion, useScroll, useTransform } from 'framer-motion';
import { useRef } from 'react';

const processSteps = [
  {
    icon: <Handshake className="h-8 w-8 text-primary" />,
    title: 'Consultation & Requirement Gathering',
    description: "We start by understanding your vision, needs, and budget. Our experts will visit your site or connect with you virtually to discuss your requirements in detail.",
  },
  {
    icon: <PencilRuler className="h-8 w-8 text-primary" />,
    title: 'Design & 3D Visualization',
    description: "Our designers create personalized 2D and 3D designs, allowing you to visualize your space before it's built. We offer live 3D sessions for a truly contactless experience.",
  },
  {
    icon: <Truck className="h-8 w-8 text-primary" />,
    title: 'Manufacturing & Delivery',
    description: "Once the design is finalized, our state-of-the-art manufacturing unit gets to work. We ensure timely and safe delivery of all components to your doorstep.",
  },
  {
    icon: <ShieldCheck className="h-8 w-8 text-primary" />,
    title: 'Installation & Handover',
    description: "Our professional installation team assembles everything with precision. We conduct a final quality check before handing over your brand new, dream interior.",
  },
  {
    icon: <Star className="h-8 w-8 text-primary" />,
    title: 'Warranty & Support',
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

const Step = ({ step, index }: { step: typeof processSteps[0]; index: number }) => {
    const ref = useRef(null);
    const { scrollYProgress } = useScroll({
        target: ref,
        offset: ["start end", "end start"]
    });
    
    const x = useTransform(scrollYProgress, [0, 1], [index % 2 === 0 ? -100 : 100, 0]);
    const opacity = useTransform(scrollYProgress, [0, 0.5], [0, 1]);

    return (
         <motion.div
            ref={ref}
            style={{ x, opacity }}
            className="relative flex items-center"
        >
             <div className={`w-1/2 flex ${index % 2 === 0 ? 'justify-end pr-8' : 'justify-start pl-8'} `}>
                 <Card className="shadow-xl w-full max-w-sm">
                    <CardContent className="p-6">
                        <div className="flex items-center gap-4 mb-4">
                            <div className="flex-shrink-0 bg-primary/10 p-3 rounded-full">{step.icon}</div>
                            <h3 className="text-xl font-bold">{step.title}</h3>
                        </div>
                        <p className="text-muted-foreground">{step.description}</p>
                    </CardContent>
                </Card>
             </div>
             <div className="absolute left-1/2 -translate-x-1/2 flex items-center justify-center">
                 <div className="z-10 flex h-16 w-16 items-center justify-center rounded-full bg-secondary shadow-lg border-2 border-primary">
                    <span className="text-2xl font-bold text-primary">{index + 1}</span>
                 </div>
             </div>
             <div className="w-1/2"></div>
        </motion.div>
    )
}

export default function HowItWorksPage() {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({
      target: ref,
      offset: ["start center", "end center"]
  });

  return (
    <div className="bg-background">
      {/* Hero Section */}
      <section className="relative w-full h-[50vh] flex items-center justify-center text-center text-white">
        <Image
          src="https://images.unsplash.com/photo-1606744837616-56c9a5c6a6eb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw4fHxpbnRlcmlvcnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080"
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
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold">Our 5-Step Process</h2>
            <p className="text-lg text-muted-foreground mt-2">A seamless journey from concept to completion.</p>
          </div>

          <div ref={ref} className="relative flex flex-col gap-16">
            <motion.div
                style={{ scaleY: scrollYProgress }}
                className="absolute left-1/2 -translate-x-1/2 top-0 w-1 bg-primary/20 origin-top"
            />
             <motion.div
                style={{ scaleY: scrollYProgress }}
                className="absolute left-1/2 -translate-x-1/2 top-0 w-1 bg-primary origin-top"
            >
                <motion.div
                    className="absolute -top-1 -left-1.5 h-4 w-4 rounded-full bg-primary shadow-md"
                    style={{
                        boxShadow: '0 0 12px 6px hsl(var(--primary) / 0.5)',
                        opacity: useTransform(scrollYProgress, [0, 0.05, 0.95, 1], [0, 1, 1, 0])
                    }}
                 />
            </motion.div>

            {processSteps.map((step, index) => (
              <Step key={index} step={step} index={index} />
            ))}
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
                             <CardContent className="flex flex-col items-center">
                                {item.icon}
                                <h3 className="mt-4 text-xl font-bold">{item.title}</h3>
                                <p className="text-muted-foreground mt-2">{item.description}</p>
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
