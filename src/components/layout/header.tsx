
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { Menu, ChevronDown, LucideIcon, Home, Info, BookText, ShoppingCart, GanttChartSquare, Wrench, GalleryHorizontal, Phone, Users, CalendarPlus } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Sheet, SheetContent, SheetTrigger, SheetHeader, SheetTitle } from '@/components/ui/sheet';
import { cn } from '@/lib/utils';
import Image from 'next/image';
import { useIsMobile } from '@/hooks/use-mobile';
import { motion } from 'framer-motion';
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from '@/components/ui/collapsible';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { createClient } from '@/lib/supabase/client';
import { useQuoteSidebar } from '@/components/quote-sidebar-provider';

const iconMap: { [key: string]: LucideIcon } = {
    'home': Home,
    'about': Info,
    'customer-stories': BookText,
    'products': ShoppingCart,
    'how-it-works': GanttChartSquare,
    'services': Wrench,
    'portfolio': GalleryHorizontal,
    'contact': Phone,
    'clients': Users,
    'appointment': CalendarPlus
};

type NavItem = {
    title: string;
    slug: string;
    icon: LucideIcon;
    subItems?: NavItem[];
}

export function Header() {
  const pathname = usePathname();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isMounted, setIsMounted] = useState(false);
  const [navItems, setNavItems] = useState<NavItem[]>([]);
  const { setIsOpen } = useQuoteSidebar();
  
  const isMobile = useIsMobile();
  
  useEffect(() => {
    setIsMounted(true);
    const fetchNavItems = async () => {
        const supabase = createClient();
        const { data, error } = await supabase
            .from('pages')
            .select('title, slug, parent_slug')
            .order('nav_order');

        if (error) {
            console.error("Error fetching nav items", error);
            return;
        }
        
        let topLevelItems: NavItem[] = data
            .filter(item => !item.parent_slug)
             .filter(item => item.slug !== 'appointment' && item.slug !== 'contact') // Exclude appointment & contact from nav links
            .map(item => ({
                title: item.title,
                slug: item.slug === 'home' ? '/' : `/${item.slug}`,
                icon: iconMap[item.slug] || Home,
                subItems: data
                    .filter(sub => sub.parent_slug === item.slug)
                    .map(sub => ({
                        title: sub.title,
                        slug: `/${item.slug}/${sub.slug}`,
                        icon: iconMap[sub.slug] || Home
                    }))
            }));
        
        // Define the desired order of navigation items
        const desiredOrder = [
            'Home',
            'About Us',
            'How It Works',
            'Clients',
            'Services',
            'Portfolio',
            'Customer Stories',
            'Products',
        ];

        // Sort the topLevelItems array based on the desiredOrder
        topLevelItems.sort((a, b) => {
            const aIndex = desiredOrder.indexOf(a.title);
            const bIndex = desiredOrder.indexOf(b.title);
            
            // If an item is not in the desiredOrder array, push it to the end.
            if (aIndex === -1) return 1;
            if (bIndex === -1) return -1;
            
            return aIndex - bIndex;
        });

        setNavItems(topLevelItems);
    };
    fetchNavItems();
  }, []);

  if (pathname.startsWith('/shriramadmin')) {
    return null;
  }

  const renderMobileMenu = () => (
    <Sheet open={isMobileMenuOpen} onOpenChange={setIsMobileMenuOpen}>
      <SheetTrigger asChild>
        <Button variant="ghost" className="p-2 text-foreground xl:hidden">
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
          <nav className="flex-grow flex flex-col space-y-1 p-4 overflow-y-auto">
            {navItems.map((item) => 
              item.subItems && item.subItems.length > 0 ? (
                <Collapsible key={item.slug}>
                  <CollapsibleTrigger className="w-full">
                    <div
                      className={cn(
                        'flex items-center justify-between text-sm rounded-md p-3 transition-colors hover:bg-accent hover:text-accent-foreground',
                        pathname.startsWith(item.slug === '/' ? '/ ' : item.slug) ? 'text-primary bg-primary/10 font-semibold' : 'text-foreground/80'
                      )}
                    >
                      <div className="flex items-center gap-4">
                        <item.icon className="h-5 w-5" />
                        {item.title}
                      </div>
                       <ChevronDown className="h-5 w-5 transition-transform ui-open:rotate-180" />
                    </div>
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <div className="flex flex-col space-y-1 py-2 pl-8">
                       {item.subItems.map(subItem => (
                         <Link
                          key={subItem.slug}
                          href={subItem.slug}
                          onClick={() => setIsMobileMenuOpen(false)}
                          className={cn(
                            'flex items-center gap-4 text-sm rounded-md p-3 transition-colors hover:bg-accent hover:text-accent-foreground',
                            pathname === subItem.slug ? 'text-primary bg-primary/10 font-semibold' : 'text-foreground/80'
                          )}
                        >
                          <subItem.icon className="h-5 w-5" />
                          {subItem.title}
                        </Link>
                       ))}
                    </div>
                  </CollapsibleContent>
                </Collapsible>
              ) : (
                <Link
                  key={item.slug}
                  href={item.title === 'Products' ? 'https://amazon.in' : item.slug}
                  target={item.title === 'Products' ? '_blank' : '_self'}
                  rel={item.title === 'Products' ? 'noopener noreferrer' : ''}
                  onClick={() => setIsMobileMenuOpen(false)}
                  className={cn(
                    'flex items-center gap-4 text-sm rounded-md p-3 transition-colors hover:bg-accent hover:text-accent-foreground',
                    pathname === item.slug ? 'text-primary bg-primary/10 font-semibold' : 'text-foreground/80'
                  )}
                >
                  <item.icon className="h-5 w-5" />
                  <span>{item.title}</span>
                  {item.title === 'Products' && <ShoppingCart className="h-5 w-5 text-primary" />}
                </Link>
              )
            )}
          </nav>
          <div className="p-4 mt-auto border-t space-y-2">
             <Button asChild className="w-full">
                <Link href="/appointment">Appointment</Link>
             </Button>
             <Button className="w-full" variant="outline" onClick={() => { setIsOpen(true); setIsMobileMenuOpen(false); }}>
                Get Quote
            </Button>
          </div>
        </div>
      </SheetContent>
    </Sheet>
  );

  const renderDesktopMenu = () => (
    <nav className="hidden xl:flex items-center space-x-2 font-medium">
      {navItems.map((item) => {
        const isActive = pathname === item.slug || (item.slug !== '/' && pathname.startsWith(item.slug));
        
        if (item.title === 'Products') {
            return (
                <a
                    key={item.slug}
                    href="https://amazon.in"
                    target="_blank"
                    rel="noopener noreferrer"
                    className={cn(
                      'relative transition-colors duration-300 group py-2 px-3 flex items-center gap-1.5 text-sm',
                      isActive ? 'text-primary' : 'text-foreground/80 hover:text-foreground'
                    )}
                >
                    <span>{item.title}</span>
                    <ShoppingCart className="h-4 w-4 text-primary transition-transform group-hover:scale-125" />
                </a>
            );
        }

        return item.subItems && item.subItems.length > 0 ? (
           <DropdownMenu key={item.slug}>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" className={cn(
                    'relative transition-colors duration-300 group py-2 px-3 flex items-center gap-1 text-sm',
                    isActive ? 'text-primary' : 'text-foreground/80 hover:text-foreground'
                  )}>
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
                  <span>{item.title}</span>
                  <ChevronDown className="h-4 w-4 transition-transform duration-200 group-data-[state=open]:rotate-180" />
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
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                 <DropdownMenuItem asChild>
                    <Link href={item.slug} className="flex items-center gap-2">
                      <item.icon className="h-4 w-4 text-muted-foreground" />
                      <span>Overview</span>
                    </Link>
                  </DropdownMenuItem>
                {item.subItems.map(subItem => (
                  <DropdownMenuItem key={subItem.slug} asChild>
                    <Link href={subItem.slug} className="flex items-center gap-2">
                      <subItem.icon className="h-4 w-4 text-muted-foreground" />
                      <span>{subItem.title}</span>
                    </Link>
                  </DropdownMenuItem>
                ))}
              </DropdownMenuContent>
            </DropdownMenu>
        ) : (
          <Link
            key={item.slug}
            href={item.slug}
            className={cn(
              'relative transition-colors duration-300 group py-2 px-3 text-sm',
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
            <span>{item.title}</span>
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
      <div className="px-4 sm:px-6 lg:px-8">
        <div className="flex h-20 items-center justify-between gap-4">
          <Link href="/" className="flex items-center space-x-2 shrink-0">
            <Image src="/company.png" alt="Shriram Interio Logo" width={150} height={40} className="object-contain" data-ai-hint="company logo" />
          </Link>
        
          <div className="flex-1 min-w-0 flex justify-center">
             <div className="flex-shrink overflow-hidden">
              {isMounted && renderDesktopMenu()}
            </div>
          </div>
        
          <div className="flex items-center gap-2 shrink-0">
            <div className="hidden sm:flex items-center gap-2">
              <Button asChild>
                  <Link href="/appointment">Appointment</Link>
              </Button>
              <Button onClick={() => setIsOpen(true)}>Get Quote</Button>
            </div>
            {isMounted && renderMobileMenu()}
          </div>
        </div>
      </div>
    </header>
  );
}
