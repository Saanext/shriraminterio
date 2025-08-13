import { ReactNode } from 'react';
import { Shield } from 'lucide-react';

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
            <li><a href="/shriramadmin" className="block py-2 px-4 rounded hover:bg-muted">Dashboard</a></li>
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
