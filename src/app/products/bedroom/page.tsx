
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import Image from 'next/image';

export default function BedroomPage() {
  return (
    <div className="container mx-auto px-4 py-16">
      <Card>
        <CardHeader>
          <CardTitle className="text-3xl text-center">Bedroom Interiors</CardTitle>
        </CardHeader>
        <CardContent className="text-center">
          <Image
            src="https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bedroom-hero.jpg"
            alt="Modern Bedroom"
            data-ai-hint="modern bedroom"
            width={600}
            height={400}
            className="rounded-lg shadow-lg mx-auto mb-8"
          />
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
            Create your dream sanctuary with our bespoke bedroom interior designs. We focus on creating a perfect balance of comfort, style, and functionality to give you a space where you can truly relax and rejuvenate.
          </p>
          <Button asChild size="lg">
            <Link href="/get-a-quote">Get a Free Quote</Link>
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
