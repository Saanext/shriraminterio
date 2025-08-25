
import { Card, CardContent } from '@/components/ui/card';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Star, PlayCircle } from 'lucide-react';
import Image from 'next/image';

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

const clientVideos = [
  {
    name: 'P. Manikandan & Kruthhikka',
    location: 'Subramaniya Nagar, Chennai',
    review: "Manikandan & Kruthhikka were impressed by the experienced HomeLane designers and how they were able to understand their vision for their home. HomeLane made sure everything was personalised to match the requirements and comfort of the family. Book your free consultation today.",
    imageSrc: 'https://images.unsplash.com/photo-1588854337236-6889d631f379?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwY291cGxlfGVufDB8fHx8MTc1NjA0NjQyNnww&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'smiling couple',
    videoUrl: 'https://www.youtube.com/watch?v=your_video_id_1'
  },
  {
    name: 'Anitha & Mahendiran',
    location: 'Parappalayam, Coimbatore',
    review: "HomeLane brought Anitha's dream home to life for her, just the way she envisioned It. After doing some research she chose HomeLane where she got the best price and the quality she was looking for. The HomeLane designer delivered all the requirements before time and with the highest quality possible.",
    imageSrc: 'https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'smiling woman',
    videoUrl: 'https://www.youtube.com/watch?v=your_video_id_2'
  },
  {
    name: 'Mr Kanagasabai',
    location: 'Jains Pebble Brook, Chennai',
    review: "Mr Kanagasabai and family gave Homelane the responsibility to deliver a home that takes Into account the needs of each and every family member, and HomeLane delivered. Their vision of a calm, not too flashy home was shown to them by experienced HomeLane designers in 3D using Spacecraft Pro, which helped them visualize how their home would look like.",
    imageSrc: 'https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFuJTIwaW5kaWFufGVufDB8fHx8MTc1NjA0NjY0OHww&ixlib=rb-4.1.0&q=80&w=1080',
    dataAiHint: 'smiling man',
    videoUrl: 'https://www.youtube.com/watch?v=your_video_id_3'
  }
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
      {/* Client Videos Section */}
      <section className="py-16 md:py-24 bg-secondary">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold">Client Video Testimonials</h2>
            <p className="text-lg text-muted-foreground mt-2">See our happy clients in action.</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {clientVideos.map((video, index) => (
                <a href={video.videoUrl} target="_blank" rel="noopener noreferrer" className="group block" key={index}>
                    <Card className="overflow-hidden h-full flex flex-col">
                       <div className="relative aspect-video">
                        <Image
                          src={video.imageSrc}
                          alt={video.name}
                          layout="fill"
                          objectFit="cover"
                          className="transition-transform duration-500 group-hover:scale-105"
                          data-ai-hint={video.dataAiHint}
                        />
                        <div className="absolute inset-0 bg-black/40 flex items-center justify-center transition-colors duration-300 group-hover:bg-black/60">
                          <PlayCircle className="h-16 w-16 text-white/80 transition-transform duration-300 group-hover:scale-110" />
                        </div>
                      </div>
                      <CardContent className="p-6 bg-card flex-grow flex flex-col">
                        <h3 className="text-xl font-bold">{video.name}</h3>
                        <p className="text-sm text-muted-foreground mb-4">{video.location}</p>
                        <p className="text-muted-foreground text-sm flex-grow">{video.review}</p>
                      </CardContent>
                    </Card>
                  </a>
              ))}
            </div>
        </div>
      </section>

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
