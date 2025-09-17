
import type { Metadata } from 'next';
import './globals.css';
import { Toaster } from "@/components/ui/toaster";
import { Playfair_Display, Comfortaa } from 'next/font/google';
import { SiteLayout } from '@/components/site-layout';
import { QuoteSidebarProvider } from '@/components/quote-sidebar-provider';
import { Footer } from '@/components/layout/footer';
import { QuoteSidebar } from '@/components/quote-sidebar';

const playfairDisplay = Playfair_Display({
  subsets: ['latin'],
  variable: '--font-playfair-display',
});

const comfortaa = Comfortaa({
  subsets: ['latin'],
  variable: '--font-comfortaa',
});


export const metadata: Metadata = {
  title: {
    template: '%s | Shriram Interio Digital',
    default: 'Shriram Interio Digital | Pune\'s Premier Interior Designers',
  },
  description: 'Pune\'s leading interior design company for modular kitchens, wardrobes, and full home interiors.',
  keywords: ['interior design', 'modular kitchen', 'wardrobe', 'Pune', 'Shriram Interio'],
  verification: {
    google: 'ZAT8iIAlTrcoPPhujpwqRJFliyBPchPMyrWTWAFZxT4',
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning className={`${playfairDisplay.variable} ${comfortaa.variable}`}>
      <body className="font-body antialiased">
        <QuoteSidebarProvider>
          <SiteLayout>
            {children}
          </SiteLayout>
          <Footer />
          <QuoteSidebar />
        </QuoteSidebarProvider>
        <Toaster />
      </body>
    </html>
  );
}
