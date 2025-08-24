
import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { ArrowRight, CalendarDays } from 'lucide-react';
import { Badge } from '@/components/ui/badge';

const stories = [
  {
    slug: 'pune-home-transformation',
    title: 'A Complete Home Transformation in Pune',
    category: 'Full Home Interior',
    image: '/portfolio-3.png',
    dataAiHint: 'home interior',
    author: 'Anjali P.',
    authorAvatar: '/avatar-1.png',
    date: 'June 15, 2024',
    excerpt: 'See how we took a standard 3BHK and turned it into a personalized haven for the Sharma family, focusing on multi-functional spaces and a modern aesthetic that reflects their lifestyle...',
  },
  {
    slug: 'dream-kitchen-realized',
    title: 'The Dream Kitchen Realized: A Culinary Masterpiece',
    category: 'Modular Kitchen',
    image: '/portfolio-2.png',
    dataAiHint: 'modern kitchen',
    author: 'Rohan & Priya S.',
    authorAvatar: '/avatar-2.png',
    date: 'May 28, 2024',
    excerpt: 'The Singh couple wanted a kitchen that was both a high-functioning workspace and a beautiful gathering spot. We delivered a state-of-the-art modular kitchen with smart storage...',
  },
  {
    slug: 'wardrobe-wonder-in-baner',
    title: 'Wardrobe Wonder: Maximizing Space in a Baner Apartment',
    category: 'Wardrobe',
    image: '/portfolio-4.png',
    dataAiHint: 'modern wardrobe',
    author: 'Meera K.',
    authorAvatar: '/avatar-3.png',
    date: 'May 10, 2024',
    excerpt: 'For Meera, a walk-in wardrobe felt like an impossible dream in her compact apartment. Our design team created a clever, space-saving solution that exceeded all her expectations...',
  },
   {
    slug: 'living-room-luxury',
    title: 'Crafting a Luxurious Living Area for Entertaining',
    category: 'Living Area',
    image: '/portfolio-1.png',
    dataAiHint: 'living room',
    author: 'Sameer Joshi',
    authorAvatar: '/avatar-4.png',
    date: 'April 22, 2024',
    excerpt: 'The Joshis love to host. We designed a living room that is perfect for entertaining, with custom seating, ambient lighting, and a stunning entertainment unit as the centerpiece...',
  },
];

export default function CustomerStoriesPage() {
  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16 md:py-24">
        <div className="text-center mb-16">
          <h1 className="text-4xl md:text-5xl font-bold">Customer Stories</h1>
          <p className="text-lg text-muted-foreground mt-2">
            Read about the journeys we've shared with our clients to create their dream homes.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {stories.map((story) => (
            <Link href={`/customer-stories/${story.slug}`} key={story.slug} className="group block">
              <Card className="h-full flex flex-col overflow-hidden transition-shadow duration-300 hover:shadow-xl">
                <div className="relative h-60">
                  <Image
                    src={story.image}
                    alt={story.title}
                    layout="fill"
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint={story.dataAiHint}
                  />
                </div>
                <CardContent className="p-6 flex flex-col flex-grow">
                  <Badge variant="secondary" className="w-fit mb-2">{story.category}</Badge>
                  <h2 className="text-xl font-bold font-headline mb-3 flex-grow">{story.title}</h2>
                  <p className="text-muted-foreground text-sm mb-4">{story.excerpt}</p>
                  
                  <div className="flex items-center text-sm text-muted-foreground mt-auto pt-4 border-t">
                     <Avatar className="h-8 w-8 mr-3">
                        <AvatarImage src={story.authorAvatar} alt={story.author} />
                        <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                    </Avatar>
                    <div className="flex-grow">
                        <span className="font-semibold">{story.author}</span>
                        <div className="flex items-center gap-2">
                             <CalendarDays className="h-4 w-4" />
                             <span>{story.date}</span>
                        </div>
                    </div>
                     <ArrowRight className="h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" />
                  </div>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}
