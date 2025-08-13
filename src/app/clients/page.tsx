import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Star } from 'lucide-react';

const testimonials = [
  {
    name: 'Anjali P. (Kothrud)',
    review: 'Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish. The 3D designs helped us visualize everything perfectly. Highly recommended!',
    avatar: 'AP',
    image: '/avatar-1.png',
  },
  {
    name: 'Rohan & Priya S. (Hinjewadi)',
    review: 'The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations. Our living room is now our favorite spot for family time. Thank you for the wonderful work.',
    avatar: 'RS',
    image: '/avatar-2.png',
  },
  {
    name: 'Meera K. (Baner)',
    review: 'Excellent service and stunning wardrobe design. The quality of materials is top-notch, and the installation was seamless and clean. The team was very respectful of our home during the process.',
    avatar: 'MK',
    image: '/avatar-3.png',
  },
  {
    name: 'Sameer Joshi (Wakad)',
    review: 'We opted for the full home interior service and it was the best decision. The team managed everything, and the final result is a cohesive, beautiful home. Their attention to detail is commendable.',
    avatar: 'SJ',
    image: '/avatar-4.png',
  },
  {
    name: 'Divya Sharma (Kharadi)',
    review: 'I was impressed with their professionalism and the contactless design process. The live 3D sessions were amazing. The final exterior design has completely uplifted the look of our house.',
    avatar: 'DS',
    image: '/avatar-5.png',
  },
  {
    name: 'Amit Patel (Viman Nagar)',
    review: 'The one-year warranty gave us great peace of mind. The team delivered on time and within budget, which is rare. We are extremely happy with our new modular kitchen.',
    avatar: 'AP',
    image: '/avatar-6.png',
  },
];

const StarRating = ({ rating = 5 }: { rating?: number }) => (
  <div className="flex text-primary">
    {[...Array(rating)].map((_, i) => (
      <Star key={i} className="h-5 w-5 fill-current" />
    ))}
  </div>
);

export default function ClientsPage() {
  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Client Testimonials</h1>
          <p className="text-lg text-muted-foreground mt-2">Hear from our happy clients across Pune.</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {testimonials.map((testimonial) => (
            <Card key={testimonial.name} className="flex flex-col p-6">
              <CardContent className="flex-grow p-0">
                <StarRating />
                <p className="mt-4 text-muted-foreground italic">"{testimonial.review}"</p>
              </CardContent>
              <div className="mt-6 pt-6 border-t flex items-center">
                <Avatar>
                  <AvatarImage src={testimonial.image} alt={testimonial.name} data-ai-hint="person portrait" />
                  <AvatarFallback>{testimonial.avatar}</AvatarFallback>
                </Avatar>
                <p className="ml-4 font-bold font-headline">{testimonial.name}</p>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
}
