
import Image from 'next/image';
import { notFound } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { CalendarDays, Tag, User } from 'lucide-react';
import { Badge } from '@/components/ui/badge';

// This data would typically come from a CMS or database
const storiesData = [
  {
    slug: 'pune-home-transformation',
    title: 'A Complete Home Transformation in Pune',
    category: 'Full Home Interior',
    image: 'https://images.unsplash.com/photo-1507089947368-19c1da9775ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxraXRjaGVuJTIwfGVufDB8fHx8MTc1NjAxNTAxNXww&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'home interior',
    author: 'Anjali P.',
    authorAvatar: '/avatar-1.png',
    date: 'June 15, 2024',
    excerpt: 'See how we took a standard 3BHK and turned it into a personalized haven for the Sharma family, focusing on multi-functional spaces and a modern aesthetic that reflects their lifestyle...',
    content: `
      <p>The Sharma family came to us with a common challenge: a beautiful 3BHK apartment in Pune that didn't quite match their dynamic lifestyle. They needed spaces that could serve multiple purposes – a home office that could transform into a guest room, a living area perfect for both quiet family nights and entertaining guests, and a kitchen that was both highly functional and aesthetically pleasing.</p>
      <p>Our design journey began with understanding their daily routines, their passions, and their vision for their home. We proposed a modern, clean aesthetic with warm wooden tones and pops of color to create a welcoming environment. The key was flexibility. We designed a custom Murphy bed with an integrated desk, solving the home office/guest room dilemma instantly. In the living room, modular seating and smart storage solutions ensured the space remained uncluttered and adaptable.</p>
      <p>The kitchen was a complete overhaul. We installed a state-of-the-art modular kitchen with ergonomic placements, maximizing efficiency. The quartz countertop and acrylic-finish cabinets not only looked stunning but were also chosen for their durability and ease of maintenance. The final result was a home that was truly a reflection of the Sharma family – stylish, functional, and ready for every aspect of their lives.</p>
    `,
    gallery: [
      { src: 'https://images.unsplash.com/photo-1622372738946-62e02505feb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw2fHxraXRjaGVufGVufDB8fHx8MTc1NjAxNTA4MHww&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Living Room - Before', dataAiHint: 'living room before' },
      { src: 'https://images.unsplash.com/photo-1564078516393-cf04bd966897?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxsaXZpbmclMjBhcmVhJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU2MDE1MjExfDA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Living Room - After', dataAiHint: 'living room after' },
      { src: 'https://images.unsplash.com/photo-1573311392049-4186e3a47e9c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxOXx8d2FyZHJvYmV8ZW58MHx8fHwxNzU2MDE1MTMxfDA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Custom Wardrobe', dataAiHint: 'custom wardrobe' },
    ]
  },
  {
    slug: 'dream-kitchen-realized',
    title: 'The Dream Kitchen Realized: A Culinary Masterpiece',
    category: 'Modular Kitchen',
    image: 'https://images.unsplash.com/photo-1622372738946-62e02505feb3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw2fHxraXRjaGVufGVufDB8fHx8MTc1NjAxNTA4MHww&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'modern kitchen',
    author: 'Rohan & Priya S.',
    authorAvatar: '/avatar-2.png',
    date: 'May 28, 2024',
    excerpt: 'The Singh couple wanted a kitchen that was both a high-functioning workspace and a beautiful gathering spot. We delivered a state-of-the-art modular kitchen with smart storage...',
    content: `
        <p>Rohan and Priya are passionate home cooks who love to entertain. Their existing kitchen was cramped, outdated, and didn't serve their culinary ambitions. They dreamed of a space that was not just a place to cook, but the true heart of their home, where friends and family could gather.</p>
        <p>Our solution was an open-concept modular kitchen that flowed seamlessly into the dining area. We used a light color palette with high-gloss laminates to make the space feel larger and brighter. A central island was key to the design, providing extra prep space, a breakfast counter, and a social hub. We incorporated clever storage like magic corners, pull-out pantries, and deep drawers to keep everything organized and accessible.</p>
        <p>The result is a culinary masterpiece. The Singhs now have a kitchen that is as beautiful as it is functional, a perfect backdrop for their cooking adventures and social gatherings. It has completely transformed the way they use their home.</p>
    `,
    gallery: [
      { src: 'https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Kitchen Island Detail', dataAiHint: 'kitchen island' },
      { src: 'https://images.unsplash.com/photo-1539922980492-38f6673af8dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Smart Storage Solution', dataAiHint: 'kitchen storage' },
      { src: 'https://images.unsplash.com/photo-1585261450736-67d578ff00b4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHx1JTIwc2hhcGVkJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTU1NDN8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Overall Kitchen View', dataAiHint: 'u-shaped kitchen' },
    ]
  },
  {
    slug: 'wardrobe-wonder-in-baner',
    title: 'Wardrobe Wonder: Maximizing Space in a Baner Apartment',
    category: 'Wardrobe',
    image: 'https://images.unsplash.com/photo-1573311392049-4186e3a47e9c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxOXx8d2FyZHJvYmV8ZW58MHx8fHwxNzU2MDE1MTMxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'modern wardrobe',
    author: 'Meera K.',
    authorAvatar: '/avatar-3.png',
    date: 'May 10, 2024',
    excerpt: 'For Meera, a walk-in wardrobe felt like an impossible dream in her compact apartment. Our design team created a clever, space-saving solution that exceeded all her expectations...',
     content: `
        <p>Meera, a fashion enthusiast living in a chic but compact Baner apartment, faced a common urban problem: a lack of storage. Her dream of a walk-in wardrobe seemed impossible given the space constraints. She needed a solution that was stylish, organized, and didn't make her bedroom feel cramped.</p>
        <p>Our design team thrives on such challenges. We designed a floor-to-ceiling sliding wardrobe with a mirrored finish. The mirrors created an illusion of spaciousness, making the room feel larger, while the sliding doors saved precious floor space compared to hinged alternatives. Inside, we created a customized layout with a mix of long-hang sections, drawers, and adjustable shelves to accommodate her diverse collection of clothing and accessories.</p>
        <p>We also integrated soft-close mechanisms and LED strip lighting that activates when the doors open, adding a touch of luxury and convenience. Meera's "wardrobe wonder" is a testament to how smart design can overcome space limitations, creating a functional and beautiful storage solution that feels like a personal boutique.</p>
    `,
    gallery: [
      { src: 'https://images.unsplash.com/photo-1614631446501-abcf76949eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Wardrobe Interior', dataAiHint: 'wardrobe interior' },
      { src: 'https://images.unsplash.com/photo-1611048268330-53de574cae3b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Accessory Drawer', dataAiHint: 'accessory drawer' },
      { src: 'https://images.unsplash.com/photo-1677864944822-e3ca06e317c1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxzbGlkaW5nJTIwZG9vciUyMHdhcmRyb2JlfGVufDB8fHx8MTc1NTcxNTY2MHww&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Sliding Mirror Doors', dataAiHint: 'sliding door wardrobe' },
    ]
  },
   {
    slug: 'living-room-luxury',
    title: 'Crafting a Luxurious Living Area for Entertaining',
    category: 'Living Area',
    image: 'https://images.unsplash.com/photo-1564078516393-cf04bd966897?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxsaXZpbmclMjBhcmVhJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU2MDE1MjExfDA&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'living room',
    author: 'Sameer Joshi',
    authorAvatar: '/avatar-4.png',
    date: 'April 22, 2024',
    excerpt: 'The Joshis love to host. We designed a living room that is perfect for entertaining, with custom seating, ambient lighting, and a stunning entertainment unit as the centerpiece...',
    content: `
        <p>For the Joshi family, the living room is the hub of their social life. They love hosting gatherings, from intimate dinners to lively parties. They needed a space that felt luxurious and impressive, yet comfortable and inviting for their guests.</p>
        <p>We created a design that exudes sophistication. A plush, custom-made sectional sofa provides ample seating, upholstered in a durable yet soft velvet fabric. The centerpiece of the room is a full-wall entertainment unit with fluted paneling, concealed storage, and open shelves for displaying art pieces. We implemented a layered lighting scheme with a statement chandelier, recessed spotlights, and accent lamps, allowing the Joshis to set the perfect mood for any occasion.</p>
        <p>A rich color palette of deep blues, grays, and gold accents ties the room together, creating an atmosphere of modern luxury. The result is a living area that not only wows guests but also serves as a cozy retreat for the family.</p>
    `,
    gallery: [
      { src: 'https://images.unsplash.com/photo-1606744837616-56c9a5c6a6eb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw4fHxpbnRlcmlvcnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Entertainment Unit Detail', dataAiHint: 'entertainment unit' },
      { src: 'https://images.unsplash.com/photo-1724582586529-62622e50c0b3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxsaXZpbmclMjByb29tJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU1NzE2MTA0fDA&ixlib=rb-4.1.0&q=80&w=1080', alt: 'Custom Seating', dataAiHint: 'custom sofa' },
      { src: '/b2.jpg', alt: 'Ambient Lighting', dataAiHint: 'ambient lighting' },
    ]
  },
];


export default function StoryPage({ params }: { params: { slug: string } }) {
  const story = storiesData.find((s) => s.slug === params.slug);

  if (!story) {
    notFound();
  }

  return (
    <div className="bg-background">
      {/* Hero Section */}
      <section className="relative w-full h-[60vh] text-white">
        <Image
          src={story.image}
          alt={story.title}
          layout="fill"
          objectFit="cover"
          className="absolute inset-0 z-0 brightness-50"
          data-ai-hint={story.dataAiHint}
        />
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent z-10" />
        <div className="relative container mx-auto px-4 h-full flex flex-col justify-end pb-16 z-20">
          <Badge variant="secondary" className="w-fit mb-4">{story.category}</Badge>
          <h1 className="text-4xl md:text-6xl font-bold text-shadow-lg">{story.title}</h1>
          <div className="flex items-center gap-6 mt-4 text-lg">
            <div className="flex items-center gap-2">
                <Avatar className="h-10 w-10 border-2 border-white">
                    <AvatarImage src={story.authorAvatar} alt={story.author} />
                    <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                </Avatar>
                <span>{story.author}</span>
            </div>
            <div className="flex items-center gap-2">
                <CalendarDays className="h-5 w-5" />
                <span>{story.date}</span>
            </div>
          </div>
        </div>
      </section>

      {/* Story Content Section */}
      <section className="py-16 md:py-24">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-12">
            <div className="lg:col-span-2">
              <div
                className="prose prose-lg max-w-none text-muted-foreground space-y-6"
                dangerouslySetInnerHTML={{ __html: story.content }}
              />
            </div>
            <aside className="lg:col-span-1">
                <Card className="sticky top-24">
                    <CardHeader>
                        <CardTitle>Project Details</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-4">
                       <div className="flex items-center gap-3">
                            <Avatar className="h-10 w-10">
                                <AvatarImage src={story.authorAvatar} alt={story.author} />
                                <AvatarFallback>{story.author.charAt(0)}</AvatarFallback>
                            </Avatar>
                           <div>
                               <p className="text-sm text-muted-foreground">Client</p>
                               <p className="font-semibold">{story.author}</p>
                           </div>
                       </div>
                       <div className="flex items-center gap-3">
                           <Tag className="h-5 w-5 text-primary" />
                           <div>
                               <p className="text-sm text-muted-foreground">Category</p>
                               <p className="font-semibold">{story.category}</p>
                           </div>
                       </div>
                       <div className="flex items-center gap-3">
                           <CalendarDays className="h-5 w-5 text-primary" />
                           <div>
                               <p className="text-sm text-muted-foreground">Date</p>
                               <p className="font-semibold">{story.date}</p>
                           </div>
                       </div>
                    </CardContent>
                </Card>
            </aside>
          </div>
        </div>
      </section>

      {/* Gallery Section */}
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">Project Gallery</h2>
            <p className="text-lg text-muted-foreground mt-2">A closer look at the transformation.</p>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            {story.gallery.map((photo, index) => (
              <Card key={index} className="overflow-hidden group">
                <div className="relative aspect-video">
                  <Image
                    src={photo.src}
                    alt={photo.alt}
                    layout="fill"
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint={photo.dataAiHint}
                  />
                  <div className="absolute inset-0 bg-black/20" />
                </div>
              </Card>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}
