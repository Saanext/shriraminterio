import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import Image from 'next/image';

export default function BathroomPage() {
  return (
    <div className="container mx-auto px-4 py-16">
      <Card>
        <CardHeader>
          <CardTitle className="text-3xl text-center">Bathroom Design</CardTitle>
        </CardHeader>
        <CardContent className="text-center">
          <Image
            src="https://placehold.co/600x400.png"
            alt="Modern Bathroom"
            data-ai-hint="modern bathroom"
            width={600}
            height={400}
            className="rounded-lg shadow-lg mx-auto mb-8"
          />
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
            Transform your bathroom into a stylish and practical oasis. We offer a range of solutions from contemporary to classic designs, ensuring a refreshing and luxurious experience.
          </p>
          <Button asChild size="lg">
            <Link href="/get-a-quote">Get a Free Quote</Link>
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}