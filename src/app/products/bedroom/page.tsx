
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
            src="https://images.unsplash.com/photo-1617098900591-3f90928e8c54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxMnx8YmVkcm9vbSUyMGludGVyaW9yfGVufDB8fHx8MTc1NjAxMzgxMnww&ixlib=rb-4.1.0&q=80&w=1080"
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


