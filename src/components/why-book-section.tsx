
'use client';

import { Card, CardContent } from "@/components/ui/card";
import { Award, GanttChartSquare, Users } from "lucide-react";

export function WhyBookSection() {
    const benefits = [
        {
            icon: <Users className="h-10 w-10 text-primary" />,
            title: "Expert Consultation",
            description: "Our experienced designers will provide personalized advice and solutions tailored to your needs.",
        },
        {
            icon: <GanttChartSquare className="h-10 w-10 text-primary" />,
            title: "See Your Vision in 3D",
            description: "Visualize your new space with our advanced 3D rendering technology during the consultation.",
        },
        {
            icon: <Award className="h-10 w-10 text-primary" />,
            title: "No-Obligation Quote",
            description: "Receive a detailed, transparent quote for your project with no commitment required.",
        }
    ];

    return (
        <div className="py-16 md:py-24 bg-background">
            <div className="container mx-auto px-4">
                <div className="text-center mb-12">
                    <h2 className="text-3xl md:text-4xl font-bold">Why Book A Consultation?</h2>
                    <p className="text-lg text-muted-foreground mt-2">Unlock the potential of your home with expert guidance.</p>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-5xl mx-auto">
                    {benefits.map((benefit, index) => (
                        <Card key={index} className="text-center p-6 bg-secondary/50 border-0">
                            <CardContent className="flex flex-col items-center">
                                <div className="p-4 bg-primary/10 rounded-full mb-4">
                                    {benefit.icon}
                                </div>
                                <h3 className="text-xl font-bold mb-2">{benefit.title}</h3>
                                <p className="text-muted-foreground text-sm">{benefit.description}</p>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            </div>
        </div>
    );
}
