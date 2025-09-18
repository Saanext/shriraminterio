import { WhyBookSection } from "@/components/why-book-section";
import type { Metadata } from 'next';
import { AppointmentPageClient } from "@/components/appointment-page-client";

export const metadata: Metadata = {
  title: 'Book an Appointment',
  description: 'Schedule a free consultation with our expert interior designers in Pune. Book your appointment online today.',
};

export default function AppointmentPage() {
    return (
        <div className="bg-secondary">
            <div className="container mx-auto px-4 py-16">
                <AppointmentPageClient />
            </div>
            <WhyBookSection />
        </div>
    );
}
