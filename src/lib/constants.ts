
import type { LucideIcon } from 'lucide-react';
import { Home, Info, GanttChartSquare, Wrench, Users, GalleryHorizontal, ShoppingCart, Phone, BookText, CalendarPlus } from 'lucide-react';

export type SubNavItem = {
  label: string;
  href: string;
  icon: LucideIcon;
};

export type NavItem = {
  label: string;
  href: string;
  icon: LucideIcon;
  subItems?: SubNavItem[];
};

export const STATIC_NAV_ITEMS: NavItem[] = [
  { label: 'Home', href: '/', icon: Home },
  { 
    label: 'About Us', 
    href: '/about', 
    icon: Info,
  },
  { 
    label: 'Customer Stories', 
    href: '/customer-stories', 
    icon: BookText 
  },
  { label: 'Products', href: '/products', icon: ShoppingCart },
  { label: 'How It Works', href: '/how-it-works', icon: GanttChartSquare },
  { label: 'Services', href: '/services', icon: Wrench },
  { label: 'Portfolio', href: '/portfolio', icon: GalleryHorizontal },
  { label: 'Contact', href: '/contact', icon: Phone },
];
