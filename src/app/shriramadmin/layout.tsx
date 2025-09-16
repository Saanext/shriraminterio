
import { ReactNode } from 'react';
import { LayoutDashboard, Newspaper, Shield, Users, UserPlus, Quote, Palette, BookText, ShoppingCart, CalendarCheck, GalleryHorizontal, Share2, LogOut, Phone } from 'lucide-react';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { logout } from '@/app/login/actions';

function LogoutButton() {
    return (
        <form action={logout}>
            <Button variant="ghost" className="w-full justify-start text-destructive hover:text-destructive hover:bg-destructive/10">
                <LogOut className="w-5 h-5 mr-2" />
                Log Out
            </Button>
        </form>
    );
}

export default function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex min-h-screen">
      <aside className="w-64 bg-secondary p-6 hidden md:block border-r">
        <div className="flex flex-col h-full">
            <div className="flex items-center gap-2 mb-8">
            <Shield className="w-8 h-8 text-primary" />
            <h1 className="text-xl font-bold font-headline">Admin Panel</h1>
            </div>
            <nav className="flex-grow">
            <ul>
                <li><Link href="/shriramadmin" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><LayoutDashboard className="w-5 h-5" /> Dashboard</Link></li>
                <li><Link href="/shriramadmin/pages" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Newspaper className="w-5 h-5" /> Pages</Link></li>
                <li><Link href="/shriramadmin/stories" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><BookText className="w-5 h-5" /> Stories</Link></li>
                <li><Link href="/shriramadmin/products" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><ShoppingCart className="w-5 h-5" /> Products</Link></li>
                <li><Link href="/shriramadmin/portfolio" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><GalleryHorizontal className="w-5 h-5" /> Portfolio</Link></li>
                <li><Link href="/shriramadmin/leads" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Users className="w-5 h-5" /> Leads</Link></li>
                <li><Link href="/shriramadmin/sales-persons" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><UserPlus className="w-5 h-5" /> Sales Persons</Link></li>
                <li><Link href="/shriramadmin/appointments" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><CalendarCheck className="w-5 h-5" /> Appointments</Link></li>
                <li><Link href="/shriramadmin/quotes" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Quote className="w-5 h-5" /> Quotes</Link></li>
                <li><Link href="/shriramadmin/appearance" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Palette className="w-5 h-5" /> Appearance</Link></li>
                <li><Link href="/shriramadmin/social-links" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Share2 className="w-5 h-5" /> Social</Link></li>
                <li><Link href="/shriramadmin/contact" className="flex items-center gap-2 py-2 px-4 rounded hover:bg-muted"><Phone className="w-5 h-5" /> Contact</Link></li>
            </ul>
            </nav>
             <div className="mt-auto">
                <LogoutButton />
             </div>
        </div>
      </aside>
      <main className="flex-1 p-6 md:p-10 bg-background">
        {children}
      </main>
    </div>
  );
}
