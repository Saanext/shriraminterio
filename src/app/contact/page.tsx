
import { Phone, Mail, MapPin } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import type { Metadata } from 'next';

export const metadata: Metadata = {
    title: 'Contact Us',
    description: 'Get in touch with Shriram Interio Digital. Find our address, phone number, and email for a free interior design consultation in Pune.',
};

export default function ContactPage() {
  const address = "Shop No 2, Shri Hsg Society, Sankalp Nagari, Dehuroad, Pune-412101";
  const mapSrc = `https://maps.google.com/maps?q=${encodeURIComponent(address)}&t=&z=15&ie=UTF8&iwloc=&output=embed`;

  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16 md:py-24">
        <div className="text-center mb-16">
          <h1 className="text-4xl md:text-5xl font-bold">Contact Us</h1>
          <p className="text-lg text-muted-foreground mt-2">Get in touch with us for a free consultation.</p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
          {/* Contact Information */}
          <div className="flex flex-col space-y-8">
             <Card>
              <CardHeader className="flex flex-row items-center gap-4">
                <Phone className="w-8 h-8 text-primary" />
                <CardTitle className="text-2xl">Phone Number</CardTitle>
              </CardHeader>
              <CardContent>
                <a href="tel:+918767951981" className="text-lg text-muted-foreground hover:text-primary transition-colors">+91 8767951981</a>
              </CardContent>
            </Card>
             <Card>
               <CardHeader className="flex flex-row items-center gap-4">
                <Mail className="w-8 h-8 text-primary" />
                 <CardTitle className="text-2xl">Email Address</CardTitle>
              </CardHeader>
              <CardContent>
                <a href="mailto:sales@shriraminterio.com" className="text-lg text-muted-foreground hover:text-primary transition-colors">sales@shriraminterio.com</a>
              </CardContent>
            </Card>
            <Card>
               <CardHeader className="flex flex-row items-center gap-4">
                <MapPin className="w-8 h-8 text-primary" />
                 <CardTitle className="text-2xl">Address</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-lg text-muted-foreground">{address}</p>
              </CardContent>
            </Card>
          </div>

          {/* Map */}
          <div className="rounded-lg overflow-hidden shadow-2xl">
            <iframe
              src={mapSrc}
              width="100%"
              height="100%"
              style={{ border: 0, minHeight: '450px' }}
              allowFullScreen={true}
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
            ></iframe>
          </div>
        </div>
      </div>
    </div>
  );
}
