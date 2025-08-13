'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState } from 'react';
import { Menu, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Sheet, SheetContent, SheetTrigger, SheetHeader, SheetTitle, SheetDescription, SheetClose } from '@/components/ui/sheet';
import { cn } from '@/lib/utils';
import { NAV_ITEMS } from '@/lib/constants';
import { GetAQuoteForm } from '../get-a-quote-form';
import Image from 'next/image';

export function Header() {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  if (pathname.startsWith('/shriramadmin')) {
    return null;
  }

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-background">
      <div className="container flex h-16 items-center">
        <Link href="/" className="mr-4 flex items-center space-x-2 lg:mr-6">
          <Image src="/company.png" alt="Shriram Interio Logo" width={150} height={40} className="object-contain" data-ai-hint="company logo" />
        </Link>

        <nav className="hidden xl:flex items-center space-x-4 text-sm font-medium">
          {NAV_ITEMS.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                'transition-colors hover:text-primary',
                pathname === item.href ? 'text-primary' : 'text-foreground/60'
              )}
            >
              {item.label}
            </Link>
          ))}
        </nav>

        <div className="flex flex-1 items-center justify-end gap-4">
          <Sheet>
            <SheetTrigger asChild>
              <Button>Get a Quote</Button>
            </SheetTrigger>
            <SheetContent className="w-full sm:max-w-lg overflow-y-auto">
              <SheetHeader>
                <SheetTitle className="text-2xl">Get a Free Quote</SheetTitle>
              </SheetHeader>
              <GetAQuoteForm />
            </SheetContent>
          </Sheet>
          <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
            <SheetTrigger asChild>
              <Button variant="ghost" className="xl:hidden">
                <Menu className="h-6 w-6" />
                <span className="sr-only">Open Menu</span>
              </Button>
            </SheetTrigger>
            <SheetContent side="left" className="p-0">
               <div className="flex flex-col h-full">
                <SheetHeader className="p-4 border-b">
                   <Link href="/" className="flex items-center" onClick={() => setIsMobileMenuOpen(false)}>
                    <Image src="/company.png" alt="Shriram Interio Logo" width={150} height={40} className="object-contain" data-ai-hint="company logo" />
                  </Link>
                  <SheetTitle className="sr-only">Mobile Menu</SheetTitle>
                  <SheetDescription className="sr-only">Main navigation links for the site.</SheetDescription>
                </SheetHeader>
                <nav className="flex flex-col space-y-1 p-4">
                  {NAV_ITEMS.map((item) => (
                    <Link
                      key={item.href}
                      href={item.href}
                      onClick={() => setIsMobileMenuOpen(false)}
                      className={cn(
                        'text-lg rounded-md p-3 transition-colors hover:bg-muted',
                        pathname === item.href ? 'text-primary bg-primary/10 font-semibold' : 'text-foreground/80'
                      )}
                    >
                      <div className="flex items-center gap-4">
                        <item.icon className="h-5 w-5" />
                        {item.label}
                      </div>
                    </Link>
                  ))}
                </nav>
                 <div className="p-4 mt-auto">
                   <SheetClose asChild>
                      <Button asChild className="w-full">
                        <Link href="/get-a-quote">Get a Quote</Link>
                      </Button>
                   </SheetClose>
                 </div>
              </div>
            </SheetContent>
          </Sheet>
        </div>
      </div>
    </header>
  );
}
