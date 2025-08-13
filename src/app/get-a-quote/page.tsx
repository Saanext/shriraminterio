'use client';

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { GetAQuoteForm } from "@/components/get-a-quote-form";

export default function GetAQuotePage() {
    return (
        <div className="container mx-auto px-4 py-16">
             <Card className="max-w-3xl mx-auto">
                <CardHeader>
                    <CardTitle className="text-3xl text-center">Get a Free Quote</CardTitle>
                    <p className="text-muted-foreground text-center">Fill out the form below and we'll get back to you with a personalized quote.</p>
                </CardHeader>
                <CardContent>
                    <GetAQuoteForm />
                </CardContent>
            </Card>
        </div>
    );
}
