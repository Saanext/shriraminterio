
'use client';

import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { AppointmentForm } from "@/components/appointment-form";
import { WhyBookSection } from "@/components/why-book-section";
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Book an Appointment',
  description: 'Schedule a free consultation with our expert interior designers in Pune. Book your appointment online today.',
};


export default function AppointmentPage() {
    return (
        <div className="bg-secondary">
            <div className="container mx-auto px-4 py-16">
                 <Card className="max-w-3xl mx-auto">
                    <CardHeader>
                        <CardTitle className="text-3xl text-center">Book an Appointment</CardTitle>
                        <CardDescription className="text-muted-foreground text-center">
                            Schedule a free consultation with our design experts by following the steps below.
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <AppointmentForm />
                    </CardContent>
                </Card>
            </div>
            
            <WhyBookSection />
        </div>
    );
}
