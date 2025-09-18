
'use client';

import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { AppointmentForm } from "@/components/appointment-form";

export function AppointmentPageClient() {
    return (
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
    );
}
