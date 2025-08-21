
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { Menu, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Sheet, SheetContent, SheetTrigger, SheetHeader, SheetTitle, SheetDescription } from '@/components/ui/sheet';
import { cn } from '@/lib/utils';
import { NAV_ITEMS } from '@/lib/constants';
import { GetAQuoteForm } from '../get-a-quote-form';
import Image from 'next/image';
import { motion, AnimatePresence } from 'framer-motion';
import { useIsMobile } from '@/hooks/use-mobile';

export function Header() {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  
  const isMobile = useIsMobile();
  
  if (pathname.startsWith('/shriramadmin')) {
    return null;
  }

  return (
    <header className="fixed top-0 z-50 w-full transition-all duration-300 bg-background shadow-md border-b">
      <div className="container mx-auto flex h-20 items-center justify-between px-4 sm:px-6 lg:px-8">
        <div className="flex items-center">
          <Link href="/" className="flex items-center space-x-2">
            <Image src="/company.png" alt="Shriram Interio Logo" width={150} height={40} className="object-contain" data-ai-hint="company logo" />
          </Link>
        </div>
        <div className="flex items-center gap-4">
           {!isMobile ? (
              <nav className="flex items-center space-x-6 text-sm font-medium">
                {NAV_ITEMS.map((item) => {
                  const isActive = item.href === pathname;
                  return (
                    <Link
                      key={item.href}
                      href={item.href}
                      className={cn(
                        'relative transition-colors duration-300 group',
                        isActive ? 'text-primary' : 'text-foreground/80 hover:text-foreground'
                      )}
                    >
                      <span>{item.label}</span>
                       <span className={cn(
                        "absolute left-0 -top-1 block h-[2px] w-full bg-primary transition-all duration-300 transform scale-x-0 group-hover:scale-x-100",
                        isActive && "scale-x-100"
                      )} />
                      <span className={cn(
                        "absolute left-0 -bottom-1 block h-[2px] w-full bg-primary transition-all duration-300 transform scale-x-0 group-hover:scale-x-100",
                        isActive && "scale-x-100"
                      )} />
                    </Link>
                  )
                })}
              </nav>
           ) : (
              <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
                <SheetTrigger asChild>
                  <Button variant="ghost" className={cn("lg:hidden p-2 text-foreground")}>
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
                    </SheetHeader>
                    <nav className="flex flex-col space-y-1 p-4">
                  {NAV_ITEMS.map((item) => (
                    <Link
                      key={item.href}
                      href={item.href}
                      onClick={() => setIsMobileMenuOpen(false)}
                      className={cn(
                        'text-lg rounded-md p-3 transition-colors hover:bg-accent hover:text-accent-foreground',
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
                      <Sheet>
                        <SheetTrigger asChild>
                          <Button className="w-full">Get a Quote</Button>
                        </SheetTrigger>
                        <SheetContent className="w-full sm:max-w-lg overflow-y-auto">
                          <SheetHeader>
                            <SheetTitle>Get a Free Quote</SheetTitle>
                            <SheetDescription>
                              Fill out the form below and we'll get back to you with a personalized quote.
                            </SheetDescription>
                          </SheetHeader>
                          <GetAQuoteForm />
                        </SheetContent>
                      </Sheet>
                    </div>
                  </div>
                </SheetContent>
              </Sheet>
           )}
           <Sheet>
             <SheetTrigger asChild>
               <Button className="hidden lg:inline-flex">Get a Quote</Button>
             </SheetTrigger>
             <SheetContent className="w-full sm:max-w-lg overflow-y-auto">
               <SheetHeader>
                 <SheetTitle>Get a Free Quote</SheetTitle>
                 <SheetDescription>
                   Fill out the form below and we'll get back to you with a personalized quote.
                 </SheetDescription>
               </SheetHeader>
               <GetAQuoteForm />
             </SheetContent>
           </Sheet>
        </div>
      </div>
    </header>
  );
}
