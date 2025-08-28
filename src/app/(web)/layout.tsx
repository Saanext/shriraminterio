
import { SiteLayout } from "@/components/site-layout";

export default function WebLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <SiteLayout>{children}</SiteLayout>;
}
