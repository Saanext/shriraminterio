
import Image from 'next/image';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { ArrowLeft } from 'lucide-react';

async function getSchemeImage() {
    const supabase = createClient();
    const { data: page } = await supabase
        .from('pages')
        .select(`
            sections ( content )
        `)
        .eq('slug', 'home')
        .single();

    if (!page || !page.sections) {
        return null;
    }

    const heroSection = (page.sections as any[]).find((s: any) => s.content && s.content.videoUrl);
    return heroSection?.content?.scheme_image || null;
}


export default async function SchemePage() {
    const imageUrl = await getSchemeImage();

    if (!imageUrl) {
        return (
            <div className="w-screen h-screen bg-black flex flex-col items-center justify-center text-white p-4">
                <h1 className="text-2xl font-bold mb-4">Scheme Image Not Found</h1>
                <p className="text-muted-foreground mb-8">Please upload a scheme image in the admin panel for the homepage hero section.</p>
                <Button asChild>
                    <Link href="/">
                        <ArrowLeft className="mr-2 h-4 w-4" />
                        Back to Home
                    </Link>
                </Button>
            </div>
        );
    }
    
    return (
        <div className="w-screen h-screen bg-black flex items-center justify-center p-4">
             <Button asChild className="absolute top-4 left-4 z-10">
                <Link href="/">
                    <ArrowLeft className="mr-2 h-4 w-4" />
                    Back
                </Link>
            </Button>
            <div className="relative w-full h-full">
                <Image 
                    src={imageUrl} 
                    alt="Design Scheme"
                    layout="fill"
                    objectFit="contain"
                    data-ai-hint="floor plan scheme"
                />
            </div>
        </div>
    )
}
