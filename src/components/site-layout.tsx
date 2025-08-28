
'use client';

import { Footer } from "@/components/layout/footer";
import { Header } from "@/components/layout/header";
import { PageTransition } from "@/components/page-transition";
import { usePathname } from "next/navigation";
import { QuoteSidebarProvider } from '@/components/quote-sidebar-provider';
import { QuoteSidebar } from '@/components/quote-sidebar';


export function SiteLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    const pathname = usePathname();

    // Do not show header/footer on admin routes
    if (pathname.startsWith('/shriramadmin')) {
        return <>{children}</>
    }

    return (
        <QuoteSidebarProvider>
            <div className="flex flex-col min-h-screen">
                <Header />
                <main className="flex-grow pt-20">
                    <PageTransition>
                        {children}
                    </PageTransition>
                </main>
                <Footer />
                <QuoteSidebar />
            </div>
        </QuoteSidebarProvider>
    );
}
