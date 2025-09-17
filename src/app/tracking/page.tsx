
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { LocateFixed } from "lucide-react";
import type { Metadata } from 'next';

export const metadata: Metadata = {
    title: 'Track Your Project',
    description: 'Track the status of your interior design project with Shriram Interio Digital. Enter your project ID or phone number for updates.',
};


export default function TrackingPage() {
    return (
        <div className="container mx-auto px-4 py-16 md:py-24">
            <Card className="max-w-2xl mx-auto">
                <CardHeader className="text-center">
                    <LocateFixed className="mx-auto h-12 w-12 text-primary mb-4" />
                    <CardTitle className="text-3xl">Track Your Project</CardTitle>
                    <CardDescription>
                        Enter your project ID or registered contact number to see the latest updates on your interior design project.
                    </CardDescription>
                </CardHeader>
                <CardContent>
                    <div className="flex flex-col sm:flex-row gap-4">
                        <Input type="text" placeholder="Project ID or Phone Number" className="flex-grow" />
                        <Button className="w-full sm:w-auto">Track</Button>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
