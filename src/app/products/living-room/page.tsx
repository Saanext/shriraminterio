import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import Link from 'next/link';
import Image from 'next/image';

export default function LivingRoomPage() {
  return (
    <div className="container mx-auto px-4 py-16">
      <Card>
        <CardHeader>
          <CardTitle className="text-3xl text-center">Living Room Design</CardTitle>
        </CardHeader>
        <CardContent className="text-center">
          <Image
            src="https://placehold.co/600x400.png"
            alt="Modern Living Room"
            data-ai-hint="living room"
            width={600}
            height={400}
            className="rounded-lg shadow-lg mx-auto mb-8"
          />
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto mb-8">
            Design inviting and functional living spaces for family and friends. Our expert designers help you choose the right furniture, lighting, and color schemes to create a warm and welcoming atmosphere.
          </p>
          <Button asChild size="lg">
            <Link href="/get-a-quote">Get a Free Quote</Link>
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}