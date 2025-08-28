
'use client';

import { createClient as createServerClient } from '@/lib/supabase/server';
import { createClient as createBrowserClient } from '@/lib/supabase/client';
import { notFound } from 'next/navigation';
import Image from 'next/image';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useQuoteSidebar } from '@/components/quote-sidebar-provider';
import { useEffect, useState } from 'react';


// Generic Component to render a section based on its type
const SectionRenderer = ({ section }: { section: any }) => {
    switch (section.type) {
        case 'product_details':
            return <ProductDetailsSection content={section.content} />;
        case 'hero':
            return <HeroSection content={section.content} />;
        // Add other section types here
        default:
            return <p>Unsupported section type: {section.type}</p>;
    }
};

// Specific component for 'product_details' section
const ProductDetailsSection = ({ content }: { content: any }) => {
    const { setIsOpen } = useQuoteSidebar();
    return (
        <div className="container mx-auto px-4 py-16">
            <Card>
                <CardHeader>
                    <CardTitle className="text-3xl text-center">{content.title}</CardTitle>
                </CardHeader>
                <CardContent className="text-center">
                    <Image
                        src={content.image}
                        alt={content.title}
                        data-ai-hint="product image"
                        width={600}
                        height={400}
                        className="rounded-lg shadow-lg mx-auto mb-8"
                    />
                    <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
                        {content.description}
                    </p>
                    <Button onClick={() => setIsOpen(true)} size="lg">
                        Get a Free Quote
                    </Button>
                </CardContent>
            </Card>
        </div>
    );
}

const HeroSection = ({ content }: { content: any }) => (
    <section className="relative w-full h-[50vh] flex items-center justify-center text-center text-white">
        <Image
          src={content.backgroundImage}
          alt="Hero background"
          data-ai-hint="hero background"
          fill
          objectFit="cover"
          className="absolute inset-0 z-0 brightness-50"
        />
        <div className="relative z-10 p-4">
            <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">{content.title}</h1>
            <p className="mt-2 text-lg md:text-xl text-primary-foreground/90">{content.subtitle}</p>
        </div>
    </section>
);


async function getPageContent(slug: string) {
    const supabase = createServerClient();
    const { data: page } = await supabase
        .from('pages')
        .select('*, sections(*)')
        .eq('slug', slug)
        .single();
    
    if (!page) {
        return null;
    }
    
    page.sections.sort((a, b) => a.order - b.order);

    return page;
}

function DynamicPageClient({ pageContent }: { pageContent: any }) {
    return (
        <div>
            {pageContent.sections.map((section: any) => (
                section.visible ? <SectionRenderer key={section.id} section={section} /> : null
            ))}
        </div>
    );
}

export default function DynamicPage({ params }: { params: { slug: string } }) {
    const [pageContent, setPageContent] = useState<any>(null);

    useEffect(() => {
        // Exclude special routes from this dynamic page handler
        const excludedSlugs = ['shriramadmin', 'login', 'auth'];
        if (excludedSlugs.some(excluded => params.slug.startsWith(excluded))) {
            notFound();
        }
        
        async function loadPageContent() {
            const content = await getPageContent(params.slug);
            if (!content) {
                notFound();
            }
            setPageContent(content);
        }
        loadPageContent();

    }, [params.slug])

    if (!pageContent) {
        return <div>Loading...</div>
    }

    return <DynamicPageClient pageContent={pageContent} />;
}

export async function generateStaticParams() {
    const supabase = createBrowserClient();
    const { data: pages } = await supabase.from('pages').select('slug, parent_slug');

    return pages?.map(({ slug, parent_slug }) => ({
        slug: parent_slug ? `${parent_slug}/${slug}` : slug,
    })).filter(page => page.slug !== 'home') || [];
}
