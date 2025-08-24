import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import Image from 'next/image';

export default function SpaceSavingFurniturePage() {
  return (
    <div className="container mx-auto px-4 py-16">
      <Card>
        <CardHeader>
          <CardTitle className="text-3xl text-center">Space Saving Furniture</CardTitle>
        </CardHeader>
        <CardContent className="text-center">
          <Image
            src="https://placehold.co/600x400.png"
            alt="Space Saving Furniture"
            data-ai-hint="space saving"
            width={600}
            height={400}
            className="rounded-lg shadow-lg mx-auto mb-8"
          />
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
            Maximize your living area with our innovative and smart furniture solutions. Perfect for modern apartments and compact homes, our designs are both stylish and functional.
          </p>
          <Button asChild size="lg">
            <Link href="/get-a-quote">Get a Free Quote</Link>
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}