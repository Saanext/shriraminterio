

'use client';

import { Handshake, PencilRuler, Truck, ShieldCheck, Star, ArrowRight, ThumbsUp, Wallet, Smile, MessageSquareQuote } from 'lucide-react';
import Image from 'next/image';
import { Card, CardContent } from '@/components/ui/card';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { motion, useScroll, useTransform } from 'framer-motion';
import { useRef, useEffect, useState } from 'react';
import { cn } from '@/lib/utils';
import { useIsMobile } from '@/hooks/use-mobile';
import { createClient } from '@/lib/supabase/client';
import { Skeleton } from '@/components/ui/skeleton';

const Step = ({ step, index }: { step: any; index: number }) => {
    const isMobile = useIsMobile();
    const isEven = index % 2 === 0;
    const ref = useRef(null);
    const { scrollYProgress } = useScroll({
        target: ref,
        offset: ["start end", "end start"]
    });

    const x = useTransform(scrollYProgress, [0, 0.5], isMobile ? [0,0] : [isEven ? -100 : 100, 0]);
    const opacity = useTransform(scrollYProgress, [0, 0.5], [0, 1]);
    
    const Icon = {
        Handshake: <Handshake className="h-8 w-8 text-primary" />,
        PencilRuler: <PencilRuler className="h-8 w-8 text-primary" />,
        Truck: <Truck className="h-8 w-8 text-primary" />,
        ShieldCheck: <ShieldCheck className="h-8 w-8 text-primary" />,
        Star: <Star className="h-8 w-8 text-primary" />,
        MessageSquareQuote: <MessageSquareQuote className="h-8 w-8 text-primary" />
    }[step.icon as string] || <Handshake className="h-8 w-8 text-primary" />;

    if (isMobile) {
      return (
        <motion.div
            ref={ref}
            style={{ opacity }}
            className="relative grid grid-cols-[auto_1fr] items-start gap-6"
        >
            <div className="flex flex-col items-center h-full">
                <div className="z-10 flex h-16 w-16 items-center justify-center rounded-full bg-secondary shadow-lg border-2 border-primary flex-shrink-0">
                    <span className="text-2xl font-bold text-primary">{index + 1}</span>
                </div>
            </div>

            <motion.div
                style={{ x }}
                className="pt-1"
            >
                <Card className="shadow-xl">
                    <CardContent className="p-6">
                        <div className="flex items-center gap-4 mb-4">
                            <div className="flex-shrink-0 bg-primary/10 p-3 rounded-full">{Icon}</div>
                            <h3 className="text-xl font-bold">{step.title}</h3>
                        </div>
                        <p className="text-muted-foreground">{step.description}</p>
                    </CardContent>
                </Card>
            </motion.div>
        </motion.div>
      )
    }

    return (
        <motion.div
            ref={ref}
            style={{ opacity }}
            className="relative grid grid-cols-5 items-center gap-8"
        >
            {isEven ? (
                <motion.div style={{ x }} className="col-span-2">
                    <Card className="shadow-xl">
                        <CardContent className="p-6">
                            <div className="flex items-center gap-4 mb-4">
                                <div className="flex-shrink-0 bg-primary/10 p-3 rounded-full">{Icon}</div>
                                <h3 className="text-xl font-bold">{step.title}</h3>
                            </div>
                            <p className="text-muted-foreground">{step.description}</p>
                        </CardContent>
                    </Card>
                </motion.div>
            ) : <div className="col-span-2"></div>}

            <div className="col-span-1 flex justify-center items-center">
                 <div className="z-10 flex h-16 w-16 items-center justify-center rounded-full bg-secondary shadow-lg border-2 border-primary">
                    <span className="text-2xl font-bold text-primary">{index + 1}</span>
                 </div>
            </div>
            
            {!isEven ? (
                <motion.div style={{ x }} className="col-span-2">
                    <Card className="shadow-xl">
                        <CardContent className="p-6">
                            <div className="flex items-center gap-4 mb-4">
                                <div className="flex-shrink-0 bg-primary/10 p-3 rounded-full">{Icon}</div>
                                <h3 className="text-xl font-bold">{step.title}</h3>
                            </div>
                            <p className="text-muted-foreground">{step.description}</p>
                        </CardContent>
                    </Card>
                </motion.div>
            ) : <div className="col-span-2"></div>}
        </motion.div>
    );
}

function PageSkeleton() {
    return (
        <div>
            <Skeleton className="h-[50vh] w-full" />
            <div className="py-16 md:py-24 bg-secondary">
                <div className="container mx-auto px-4">
                    <div className="text-center mb-16">
                        <Skeleton className="h-10 w-3/4 mx-auto" />
                        <Skeleton className="h-6 w-1/2 mx-auto mt-4" />
                    </div>
                     <div className="flex flex-col gap-16">
                        <Skeleton className="h-48 w-full" />
                        <Skeleton className="h-48 w-full" />
                        <Skeleton className="h-48 w-full" />
                    </div>
                </div>
            </div>
        </div>
    )
}

export default function HowItWorksPage() {
  const timelineRef = useRef(null);
  const { scrollYProgress } = useScroll({
    target: timelineRef,
    offset: ["start center", "end end"]
  });

  const scaleY = useTransform(scrollYProgress, [0, 1], [0, 1]);
  const [content, setContent] = useState<any>(null);

  useEffect(() => {
    async function fetchContent() {
      const supabase = createClient();
      const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', 'how-it-works')
        .single();
      
      if (page) {
          const pageContent: { [key: string]: any } = {};
          for (const section of page.sections) {
              const sectionKey = section.type.replace(/_([a-z])/g, (g: string) => g[1].toUpperCase());
              pageContent[sectionKey] = {
                  ...section.content,
                  visible: section.visible,
                  title: section.title,
                  content: section.content
              };
          }
          setContent(pageContent);
      }
    }
    fetchContent();
  }, []);

  if (!content) {
    return <PageSkeleton />;
  }

  const { hero, process, whyUs, getStarted } = content;

  const BenefitIcon = ({ iconName }: { iconName: string }) => {
    const icons: { [key: string]: React.ReactNode } = {
      ThumbsUp: <ThumbsUp className="w-10 h-10 text-primary" />,
      Wallet: <Wallet className="w-10 h-10 text-primary" />,
      Smile: <Smile className="w-10 h-10 text-primary" />,
    };
    return <>{icons[iconName] || <Smile className="w-10 h-10 text-primary" />}</>;
  }

  return (
    <div className="bg-background">
      {/* Hero Section */}
      {hero.visible && (
      <section className="relative w-full h-[50vh] flex items-center justify-center text-center text-white">
        <Image
          src={hero.content.backgroundImage}
          alt="A team of interior designers collaborating on a project"
          data-ai-hint="design team collaboration"
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0 brightness-50"
        />
        <div className="relative z-10 p-4">
          <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">{hero.content.title}</h1>
          <p className="mt-2 text-lg md:text-xl text-primary-foreground/90">{hero.content.subtitle}</p>
        </div>
      </section>
      )}

      {/* Our Process Section */}
      {process.visible && (
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold">{process.title}</h2>
            <p className="text-lg text-muted-foreground mt-2">{process.subtitle}</p>
          </div>
          
          <div ref={timelineRef} className="relative">
              <motion.div
                  style={{ scaleY }}
                  className={cn(
                    "absolute top-0 bottom-0 w-1 bg-primary/20 origin-top",
                    "left-8 md:left-1/2 md:-translate-x-1/2"
                  )}
              />
              <div className="flex flex-col gap-16">
                  {process.steps.map((step: any, index: number) => (
                    <Step key={index} step={step} index={index} />
                  ))}
              </div>
          </div>
        </div>
      </section>
      )}

      {/* Why Our Process Works Section */}
      {whyUs.visible && (
      <section className="py-16 md:py-24 bg-background">
            <div className="container mx-auto px-4">
                <div className="text-center mb-12">
                    <h2 className="text-3xl md:text-4xl font-bold">{whyUs.title}</h2>
                    <p className="text-lg text-muted-foreground mt-2">{whyUs.subtitle}</p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    {whyUs.benefits.map((item: any, index: number) => (
                        <Card key={index} className="text-center p-6 transition-all duration-300 hover:shadow-xl hover:-translate-y-2 bg-card">
                             <CardContent className="flex flex-col items-center">
                                <BenefitIcon iconName={item.icon} />
                                <h3 className="mt-4 text-xl font-bold">{item.title}</h3>
                                <p className="text-muted-foreground mt-2">{item.description}</p>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            </div>
        </section>
      )}

      {/* Get Started Section */}
      {getStarted.visible && (
      <section className="py-16 md:py-24 bg-secondary">
          <div className="container mx-auto px-4 text-center">
              <h2 className="text-3xl md:text-4xl font-bold mb-4">{getStarted.title}</h2>
              <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
                  {getStarted.subtitle}
              </p>
              <Button asChild size="lg">
                  <Link href="/appointment">
                      {getStarted.buttonText} <ArrowRight className="ml-2 h-5 w-5" />
                  </Link>
              </Button>
          </div>
      </section>
      )}
    </div>
  );
}
