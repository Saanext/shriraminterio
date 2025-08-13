import { ReactNode } from 'react';
import { Newspaper, Shield } from 'lucide-react';
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
            <li><Link href="/shriramadmin" className="block py-2 px-4 rounded hover:bg-muted">Dashboard</Link></li>
            <li><Link href="/shriramadmin/pages" className="block py-2 px-4 rounded hover:bg-muted flex items-center gap-2"><Newspaper className="w-5 h-5" /> Pages</Link></li>
            {/* Future admin links will go here */}
          </ul>
        </nav>
      </aside>
      <main className="flex-1 p-6 md:p-10 bg-background">
        {children}
      </main>
    </div>
  );
}
