
import { ReactNode } from 'react';
import { LayoutDashboard, Newspaper, Shield, Video, Quote, Palette, BookText, ShoppingCart, CalendarCheck } from 'lucide-react';
import Link from 'next/link';

export default function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex min-h-screen">
      <aside className="w-64 bg-secondary p-6 hidden md:block border-r">
        <div className="flex items-center gap-2 mb-8">
          <Shield className="w-8 h-8 text-primary" />
          <h1 className="text-xl font-bold font-headline">Admin Panel</h1>
        </div>
        <nav>
          <ul>
            <li><Link href="/shriramadmin" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><LayoutDashboard className="w-5 h-5" /> Dashboard</Link></li>
            <li><Link href="/shriramadmin/pages" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Newspaper className="w-5 h-5" /> Pages</Link></li>
            <li><Link href="/shriramadmin/stories" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><BookText className="w-5 h-5" /> Stories</Link></li>
            <li><Link href="/shriramadmin/products" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><ShoppingCart className="w-5 h-5" /> Products</Link></li>
            <li><Link href="/shriramadmin/appointments" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><CalendarCheck className="w-5 h-5" /> Appointments</Link></li>
            <li><Link href="/shriramadmin/quotes" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Quote className="w-5 h-5" /> Quotes</Link></li>
            <li><Link href="/shriramadmin/appearance" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Palette className="w-5 h-5" /> Appearance</Link></li>
          </ul>
        </nav>
      </aside>
      <main className="flex-1 p-6 md:p-10 bg-background">
        {children}
      </main>
    </div>
  );
}
