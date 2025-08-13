import type { Metadata } from 'next';
import './globals.css';
import { Toaster } from "@/components/ui/toaster";
import WebLayout from './(web)/layout';

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
    <html lang="en" suppressHydrationWarning>
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@300;400;700&family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet" />
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
