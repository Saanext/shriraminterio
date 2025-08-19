import type { Metadata } from 'next';
import './globals.css';
import { Toaster } from "@/components/ui/toaster";
import WebLayout from './(web)/layout';
import { Playfair_Display, Comfortaa } from 'next/font/google';

const playfairDisplay = Playfair_Display({
  subsets: ['latin'],
  variable: '--font-playfair-display',
});

const comfortaa = Comfortaa({
  subsets: ['latin'],
  variable: '--font-comfortaa',
});


export const metadata: Metadata = {
  title: 'Shriram Interio Digital',
  description: 'Pune\'s leading interior design company for modular kitchens, wardrobes, and full home interiors.',
  keywords: ['interior design', 'modular kitchen', 'wardrobe', 'Pune', 'Shriram Interio'],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning className={`${playfairDisplay.variable} ${comfortaa.variable}`}>
      <head>
      </head>
      <body className="font-body antialiased">
        <WebLayout>
          {children}
        </WebLayout>
        <Toaster />
      </body>
    </html>
  );
}
