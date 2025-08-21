
import type { LucideIcon } from 'lucide-react';
import { GalleryHorizontal, GanttChartSquare, Home, Info, Layers, Users, Wrench, Phone, ShoppingCart, LocateFixed } from 'lucide-react';

export type NavItem = {
  label: string;
  href: string;
  icon: LucideIcon;
};

export const NAV_ITEMS: NavItem[] = [
  { label: 'HOME', href: '/', icon: Home },
  { label: 'ABOUT US', href: '/about', icon: Info },
  { label: 'HOW IT WORKS', href: '/how-it-works', icon: GanttChartSquare },
  { label: 'SERVICES', href: '/services', icon: Wrench },
  { label: 'TESTIMONIALS', href: '/clients', icon: Users },
  { label: 'CLIENTS', href: '/clients', icon: Users },
  { label: 'PORTFOLIO', href: '/portfolio', icon: GalleryHorizontal },
  { label: 'SHOP NOW', href: '/products', icon: ShoppingCart },
  { label: 'TRACKING', href: '/tracking', icon: LocateFixed },
  { label: 'CONTACT US', href: '/contact', icon: Phone },
];
