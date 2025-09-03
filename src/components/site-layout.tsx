
'use client';

import { Header } from "@/components/layout/header";
import { PageTransition } from "@/components/page-transition";
import { usePathname } from "next/navigation";
import { WhatsAppButton } from "./whatsapp-button";


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
        <div className="flex flex-col min-h-screen">
            <Header />
            <main className="flex-grow pt-20">
                <PageTransition>
                    {children}
                </PageTransition>
            </main>
            <WhatsAppButton />
        </div>
    );
}
