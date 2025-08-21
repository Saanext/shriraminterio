
import type { LucideIcon } from 'lucide-react';
import { Home, Info, GanttChartSquare, Wrench, Users, GalleryHorizontal, ShoppingCart, Phone } from 'lucide-react';

export type NavItem = {
  label: string;
  href: string;
  icon: LucideIcon;
};

export const NAV_ITEMS: NavItem[] = [
  { label: 'HOME', href: '/', icon: Home },
  { label: 'ABOUT US', href: '/about', icon: Info },
  { label: 'PRODUCTS', href: '/products', icon: ShoppingCart },
  { label: 'HOW IT WORKS', href: '/how-it-works', icon: GanttChartSquare },
  { label: 'SERVICES', href: '/services', icon: Wrench },
  { label: 'PORTFOLIO', href: '/portfolio', icon: GalleryHorizontal },
  { label: 'CLIENTS', href: '/clients', icon: Users },
  { label: 'CONTACT', href: '/contact', icon: Phone },
  { label: 'APPOINTMENT', href: '/appointment', icon: Users },
];
