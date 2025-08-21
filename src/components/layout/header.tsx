
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { Menu } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Sheet, SheetContent, SheetTrigger, SheetHeader, SheetTitle } from '@/components/ui/sheet';
import { cn } from '@/lib/utils';
import { NAV_ITEMS } from '@/lib/constants';
import { GetAQuoteForm } from '../get-a-quote-form';
import Image from 'next/image';
import { useIsMobile } from '@/hooks/use-mobile';
import { motion } from 'framer-motion';

export function Header() {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isMounted, setIsMounted] = useState(false);
  
  const isMobile = useIsMobile();
  
  useEffect(() => {
    setIsMounted(true);
  }, []);

  if (pathname.startsWith('/shriramadmin')) {
    return null;
  }

  const renderMobileMenu = () => (
    <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
      <SheetTrigger asChild>
        <Button variant="ghost" className="p-2 text-foreground">
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
                </SheetHeader>
                <GetAQuoteForm />
              </SheetContent>
            </Sheet>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  );

  const renderDesktopMenu = () => (
    <nav className="hidden md:flex absolute left-1/2 transform -translate-x-1/2 items-center space-x-1 lg:space-x-4 text-sm font-medium">
      {NAV_ITEMS.map((item) => {
        const isActive = item.href === pathname;
        return (
          <Link
            key={item.href}
            href={item.href}
            className={cn(
              'relative transition-colors duration-300 group py-2 px-2 lg:px-3',
              isActive ? 'text-primary' : 'text-foreground/80 hover:text-foreground'
            )}
          >
             {isActive && (
              <motion.div
                layoutId="nav-underline-top"
                className="absolute left-0 top-0 block h-[2px] w-full bg-primary"
                initial={{ scaleX: 0 }}
                animate={{ scaleX: 1 }}
                exit={{ scaleX: 0 }}
                transition={{ duration: 0.3, ease: "easeInOut" }}
              />
            )}
            <span>{item.label}</span>
             {isActive && (
              <motion.div
                layoutId="nav-underline-bottom"
                className="absolute left-0 bottom-0 block h-[2px] w-full bg-primary"
                 initial={{ scaleX: 0 }}
                animate={{ scaleX: 1 }}
                exit={{ scaleX: 0 }}
                transition={{ duration: 0.3, ease: "easeInOut" }}
              />
            )}
          </Link>
        )
      })}
    </nav>
  );
  
  return (
    <header className="fixed top-0 z-50 w-full transition-all duration-300 bg-background shadow-md border-b">
      <div className="flex h-20 items-center relative px-4 sm:px-6 lg:px-8">
        {/* Logo - Left Corner */}
        <div className="flex items-center">
          <Link href="/" className="flex items-center space-x-2">
            <Image src="/company.png" alt="Shriram Interio Logo" width={150} height={40} className="object-contain" data-ai-hint="company logo" />
          </Link>
        </div>

        {/* Desktop Navigation - Center */}
        {isMounted && !isMobile && renderDesktopMenu()}
        
        {/* Get a Quote Button - Right Corner */}
        <div className="ml-auto flex items-center">
          {isMounted && isMobile ? (
            renderMobileMenu()
          ) : (
            <Sheet>
              <SheetTrigger asChild>
                <Button>Get a Quote</Button>
              </SheetTrigger>
              <SheetContent className="w-full sm:max-w-lg overflow-y-auto">
                <SheetHeader>
                  <SheetTitle>Get a Free Quote</SheetTitle>
                </SheetHeader>
                <GetAQuoteForm />
              </SheetContent>
            </Sheet>
          )}
        </div>
      </div>
    </header>
  );
}
