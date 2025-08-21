
'use client';

import { useSearchParams } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { NAV_ITEMS } from '@/lib/constants';
import Link from 'next/link';
import { Textarea } from '@/components/ui/textarea';
import { Upload } from 'lucide-react';

// Mock data representing the sections of the pages
const pageStructure = {
    '/': {
        title: 'Home Page',
        sections: [
             { 
                type: 'hero', 
                title: 'Hero Section', 
                fields: [
                    { name: 'videoUrl', label: 'Background Video URL', value: 'https://videos.pexels.com/video-files/7578544/7578544-uhd_2560_1440_30fps.mp4', type: 'text' },
                    { name: 'title', label: 'Title', value: 'Crafting Dreams, Designing Reality', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Your trusted partner in Pune for bespoke modular kitchens, wardrobes, and complete home interiors.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Explore Our Services', type: 'text' },
                ]
            },
        ]
    },
    '/about': {
        title: 'About Shriram Interio',
        sections: [
            { 
                type: 'hero', 
                title: 'Hero Section', 
                fields: [
                    { name: 'backgroundImage', label: 'Background Image', value: '/b1.jpg', type: 'image' },
                    { name: 'title', label: 'Title', value: 'About Shriram Interio', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Your vision, our passion.', type: 'text' },
                ]
            },
            {
                type: 'content',
                title: 'Welcome Section',
                fields: [
                    { name: 'heading', label: 'Heading', value: 'Welcome to Shriram Interio', type: 'text' },
                    { name: 'subheading', label: 'Subheading', value: 'Since we started work in 2016', type: 'text' },
                    { name: 'image', label: 'Image', value: '/r1.jpg', type: 'image' },
                    { name: 'paragraph1', label: 'Paragraph 1', value: "Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team consists of the most passionate and best interior designers in Pune who love what they do and are committed to creating beautiful and functional spaces that reflect our client's unique styles and needs.", type: 'textarea' },
                ]
            }
        ]
    },
    '/products': {
        title: 'Products',
        sections: [
             { 
                type: 'pageHeader', 
                title: 'Page Header', 
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Products', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Crafted with precision, designed for life.', type: 'text' },
                ]
            },
        ]
    },
    '/how-it-works': {
        title: 'How It Works',
        sections: [
            { 
                type: 'hero', 
                title: 'Hero Section', 
                fields: [
                    { name: 'backgroundImage', label: 'Background Image', value: 'https://images.unsplash.com/photo-1606744837616-56c9a5c6a6eb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw4fHxpbnRlcmlvcnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080', type: 'image' },
                    { name: 'title', label: 'Title', value: 'How It Works', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Your seamless journey from concept to reality.', type: 'text' },
                ]
            },
        ]
    },
     '/services': {
        title: 'Services',
        sections: [
             { 
                type: 'pageHeader', 
                title: 'Page Header', 
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Services', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Comprehensive design solutions for every corner of your home.', type: 'text' },
                ]
            },
        ]
    },
    '/portfolio': {
        title: 'Portfolio',
        sections: [
             { 
                type: 'pageHeader', 
                title: 'Page Header', 
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Portfolio', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'A glimpse into the spaces we have transformed.', type: 'text' },
                ]
            },
        ]
    },
    '/clients': {
        title: 'Clients',
        sections: [
             { 
                type: 'pageHeader', 
                title: 'Page Header', 
                fields: [
                    { name: 'title', label: 'Title', value: 'Client Video Testimonials', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'See our happy clients in action.', type: 'text' },
                ]
            },
        ]
    },
    '/contact': {
        title: 'Contact Us',
        sections: [
             { 
                type: 'pageHeader', 
                title: 'Page Header', 
                fields: [
                    { name: 'title', label: 'Title', value: 'Contact Us', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Get in touch with us for a free consultation.', type: 'text' },
                ]
            },
        ]
    },
     '/appointment': {
        title: 'Book an Appointment',
        sections: [
             { 
                type: 'pageHeader', 
                title: 'Page Header', 
                fields: [
                    { name: 'title', label: 'Title', value: 'Book an Appointment', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Schedule a free consultation with our design experts by following the steps below.', type: 'text' },
                ]
            },
        ]
    },
};


export default function EditPage() {
    const searchParams = useSearchParams();
    const pageSlug = searchParams.get('page') || '';
    const pageData = NAV_ITEMS.find(p => p.href === `/${pageSlug}`);
    
    // @ts-ignore
    const structure = pageStructure[`/${pageSlug}`];


    if (!pageData) {
        return (
            <div>
                <h1 className="text-3xl font-bold mb-8">Page Not Found</h1>
                <p>The page you are trying to edit does not exist.</p>
                 <Button asChild variant="outline" className="mt-4">
                    <Link href="/shriramadmin/pages">Back to Pages</Link>
                </Button>
            </div>
        )
    }

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                 <h1 className="text-3xl font-bold">Edit Page: {pageData.label}</h1>
                <div className="flex gap-4">
                    <Button variant="outline">Preview</Button>
                    <Button>Save Changes</Button>
                </div>
            </div>

            <div className="space-y-8">
                 <Card>
                    <CardHeader>
                        <CardTitle>Page Settings</CardTitle>
                    </CardHeader>
                    <CardContent className="grid grid-cols-1 md:grid-cols-2 gap-6">
                         <div className="space-y-2">
                            <Label htmlFor="page-title">Page Title</Label>
                            <Input id="page-title" defaultValue={pageData.label} />
                        </div>
                         <div className="space-y-2">
                            <Label htmlFor="page-slug">Slug</Label>
                            <Input id="page-slug" defaultValue={pageData.href} />
                        </div>
                    </CardContent>
                </Card>

                {structure ? structure.sections.map((section, index) => (
                    <Card key={index}>
                        <CardHeader>
                            <CardTitle>{section.title}</CardTitle>
                            <CardDescription>Edit the content for this section.</CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-6">
                            {section.fields.map(field => (
                                <div key={field.name} className="space-y-2">
                                    <Label htmlFor={`${section.type}-${field.name}`}>{field.label}</Label>
                                    {field.type === 'text' && (
                                        <Input id={`${section.type}-${field.name}`} defaultValue={field.value} />
                                    )}
                                    {field.type === 'textarea' && (
                                        <Textarea id={`${section.type}-${field.name}`} defaultValue={field.value} rows={5}/>
                                    )}
                                    {field.type === 'image' && (
                                        <div className="flex items-center gap-4">
                                            <img src={field.value} alt={field.label} className="w-20 h-20 object-cover rounded-md border" />
                                            <Button variant="outline">
                                                <Upload className="mr-2 h-4 w-4"/>
                                                Change Image
                                            </Button>
                                        </div>
                                    )}
                                </div>
                            ))}
                        </CardContent>
                    </Card>
                )) : (
                     <Card>
                        <CardHeader>
                            <CardTitle>Page Content</CardTitle>
                        </CardHeader>
                        <CardContent>
                            <Textarea rows={15} placeholder="This page does not have a structured editor yet. Raw content can be edited here." />
                        </CardContent>
                    </Card>
                )}
            </div>
        </div>
    );
}
