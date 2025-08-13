import type { LucideIcon } from 'lucide-react';
import { GalleryHorizontal, GanttChartSquare, Home, Layers, Users, Wrench } from 'lucide-react';

export type NavItem = {
  label: string;
  href: string;
  icon: LucideIcon;
};

export const NAV_ITEMS: NavItem[] = [
  { label: 'Home', href: '/', icon: Home },
  { label: 'Products', href: '/products', icon: Layers },
  { label: 'How It Works', href: '/how-it-works', icon: GanttChartSquare },
  { label: 'Services', href: '/services', icon: Wrench },
  { label: 'Portfolio', href: '/portfolio', icon: GalleryHorizontal },
  { label: 'Clients', href: '/clients', icon: Users },
];
