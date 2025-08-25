

'use client';

import { Suspense, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { NAV_ITEMS } from '@/lib/constants';
import Link from 'next/link';
import { Textarea } from '@/components/ui/textarea';
import { Upload, Eye, EyeOff } from 'lucide-react';
import { Switch } from '@/components/ui/switch';

// This forces the page to be rendered dynamically
export const dynamic = 'force-dynamic';

// Mock data representing the sections of the pages
const pageStructure = {
    '/': {
        title: 'Home Page',
        metaTitle: 'Shriram Interio | Top Interior Designers in Pune',
        metaDescription: 'Shriram Interio offers the best interior design services in Pune. We specialize in modular kitchens, wardrobes, and full home interiors with a focus on quality and timely delivery.',
        sections: [
             {
                type: 'hero',
                title: 'Hero Section',
                visible: true,
                fields: [
                    { name: 'videoUrl', label: 'Background Video URL', value: 'https://videos.pexels.com/video-files/7578544/7578544-uhd_2560_1440_30fps.mp4', type: 'text' },
                    { name: 'title', label: 'Title', value: 'Crafting Dreams, Designing Reality', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Your trusted partner in Pune for bespoke modular kitchens, wardrobes, and complete home interiors.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Explore Our Services', type: 'text' },
                ]
            },
             {
                type: 'welcome',
                title: 'Welcome Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Welcome to Shriram Interio', type: 'text' },
                    { name: 'paragraph1', label: 'Paragraph 1', value: 'Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team of passionate and skilled interior designers specializes in designing and decorating residential spaces — focusing on space planning, color theory, furniture selection, and lighting design.', type: 'textarea' },
                    { name: 'paragraph2', label: 'Paragraph 2', value: "We believe well-designed interiors transform lives. By understanding our client's aspirations, we create personalized plans that fit their style, lifestyle, and budget. Whether it's a living room makeover, a kitchen update, or a full home transformation, we bring your dream space to life.", type: 'textarea' },
                    { name: 'image', label: 'Image', value: '/b2.jpg', type: 'image' },
                ]
            },
            {
                type: 'about_company',
                title: 'About Company Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'About Company', type: 'text' },
                    { name: 'text', label: 'Text', value: 'SHRIRAM INTERIO — Where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we combine creativity, functionality, and personalization in every project.', type: 'textarea' },
                ]
            },
            {
                type: 'why_us',
                title: 'Why Shriram Interio Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Why Shriram Interio', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Our commitment to quality and customer satisfaction.', type: 'text' },
                ]
            },
             {
                type: 'work_gallery',
                title: 'Work Gallery Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Work Gallery', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: "A glimpse into the spaces we've transformed.", type: 'textarea' },
                ]
            },
             {
                type: 'comfort_design',
                title: 'Design at Your Comfort Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Design at Your Comfort – Our Expertise', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'We bring a wealth of expertise and passion for creating interiors at your comfort. Our process is designed to be seamless, transparent, and centered around you.', type: 'textarea' },
                ]
            },
            {
                type: 'what_we_do',
                title: 'What We Do Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'What We Do', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'End-to-end interior solutions.', type: 'text' },
                ]
            },
            {
                type: 'testimonials',
                title: 'Testimonials Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Client Reviews', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'We are proud of the homes we have transformed and the relationships we have built.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'More Testimonials', type: 'text' },
                ]
            },
            {
                type: 'faq',
                title: 'FAQ Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Frequently Asked Questions', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Have questions? We have answers.', type: 'textarea' },
                ]
            },
             {
                type: 'partners',
                title: 'Partners Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Partners', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'MEET OUR PARTNERS', type: 'text' },
                ]
            },
        ]
    },
    '/about': {
        title: 'About Us Page',
        metaTitle: 'About Shriram Interio | Our Story & Team',
        metaDescription: 'Learn about Shriram Interio, our journey since 2016, our design philosophy, and meet the expert team dedicated to creating beautiful spaces in Pune.',
        sections: [
            {
                type: 'hero',
                title: 'Hero Section',
                visible: true,
                fields: [
                    { name: 'backgroundImage', label: 'Background Image', value: '/b1.jpg', type: 'image' },
                    { name: 'title', label: 'Title', value: 'About Shriram Interio', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Your vision, our passion.', type: 'text' },
                ]
            },
            {
                type: 'story',
                title: 'Our Story Section',
                visible: true,
                fields: [
                    { name: 'heading', label: 'Heading', value: 'Welcome to Shriram Interio', type: 'text' },
                    { name: 'subheading', label: 'Subheading', value: 'Since we started work in 2016', type: 'text' },
                    { name: 'image', label: 'Image', value: '/r1.jpg', type: 'image' },
                    { name: 'paragraph1', label: 'Paragraph 1', value: "Since our establishment in 2016, we have been dedicated to providing exceptional interior design services in Pune and throughout Maharashtra. Our team consists of the most passionate and best interior designers in Pune who love what they do and are committed to creating beautiful and functional spaces that reflect our client's unique styles and needs.", type: 'textarea' },
                    { name: 'paragraph2', label: 'Paragraph 2', value: "We specialize in designing and decorating residential spaces. With years of experience in the industry, we have honed our skills in space planning, color theory, furniture selection, and lighting design.", type: 'textarea' },
                    { name: 'paragraph3', label: 'Paragraph 3', value: "We strongly believe that a well-designed interior can have a profound impact on people's lives. That's why we take the time to truly understand our client's aspirations and preferences for their space. By working closely with them, we develop a personalized design plan that perfectly fits their aesthetic preferences, lifestyle, and budget.", type: 'textarea' },
                    { name: 'paragraph4', label: 'Paragraph 4', value: "Whether you want to give your living room a makeover, update your kitchen, or transform your entire home, our team is here to turn your dreams into reality. Feel Free to Contact us for a consultation and take the first step toward creating your dream space !!", type: 'textarea' },
                ]
            },
            {
                type: 'journey',
                title: 'Our Journey Section',
                visible: true,
                fields: [
                    { name: 'image', label: 'Image', value: '/SlidingWardrobe.jpg', type: 'image' },
                    { name: 'heading', label: 'Heading', value: 'Our Journey', type: 'text' },
                    { name: 'paragraph1', label: 'Paragraph 1', value: "We have a deep love for Interior Design and a strong vision of creating spaces that are both beautiful and functional for our clients. This passion led us to start our own interior design company in Pune, where we are dedicated to delivering exceptional designs and personalized services to every client.", type: 'textarea' },
                    { name: 'paragraph2', label: 'Paragraph 2', value: "As we embarked on this journey, we worked hard to establish a strong brand identity and build a portfolio of our best work. With the growth of our brand, our client base also expanded. We now work with clients from diverse backgrounds, including families who want to update their homes and create warm and functional spaces.", type: 'textarea' },
                    { name: 'paragraph3', label: 'Paragraph 3', value: "With every new project, Shriram Interiors' interior design team approaches the design process with a fresh perspective. Our goal is not only to create stunning designs but also to ensure that the spaces we design are practical and serve their intended purpose.", type: 'textarea' },
                    { name: 'paragraph4', label: 'Paragraph 4', value: "Over time, Shriram Interio has experienced tremendous growth and expansion. We have welcomed more talented designers and staff members to our team, further enhancing our capabilities to serve our clients. We are excited to continue our journey of creating beautiful and functional spaces, and we look forward to the opportunity to work with you.", type: 'textarea' },
                ]
            },
            {
                type: 'values',
                title: 'Our Values Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'What we do', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Our Values', type: 'text' },
                ]
            },
            {
                type: 'mission_vision',
                title: 'Mission and Vision Section',
                visible: true,
                fields: [
                    { name: 'visionTitle', label: 'Vision Title', value: 'Our Vision', type: 'text' },
                    { name: 'visionText', label: 'Vision Text', value: 'To be the most trusted and creative interior design firm in Maharashtra, known for our innovative solutions and unwavering commitment to quality.', type: 'textarea' },
                    { name: 'missionTitle', label: 'Mission Title', value: 'Our Mission', type: 'text' },
                    { name: 'missionText', label: 'Mission Text', value: 'To create beautiful, functional, and personal living spaces by listening to our clients, embracing creativity, and delivering excellence in every detail.', type: 'textarea' },
                ]
            },
             {
                type: 'team',
                title: 'Meet the Team Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Meet Our Team', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'The creative minds behind our success.', type: 'textarea' },
                ]
            }
        ]
    },
    '/products': {
        title: 'Products Page',
        metaTitle: 'Our Interior Design Products | Shriram Interio',
        metaDescription: 'Explore our wide range of interior design products including modular kitchens, custom wardrobes, bedroom sets, and more. Quality craftsmanship from Pune\'s top designers.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Products', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Crafted with precision, designed for life.', type: 'text' },
                ]
            },
        ]
    },
     '/how-it-works': {
        title: 'How It Works Page',
        metaTitle: 'Our Interior Design Process | Shriram Interio',
        metaDescription: 'Understand our seamless 6-step interior design process, from initial consultation and 3D visualization to manufacturing, installation, and final handover.',
        sections: [
            {
                type: 'hero',
                title: 'Hero Section',
                visible: true,
                fields: [
                    { name: 'backgroundImage', label: 'Background Image', value: 'https://images.unsplash.com/photo-1606744837616-56c9a5c6a6eb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw4fHxpbnRlcmlvcnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080', type: 'image' },
                    { name: 'title', label: 'Title', value: 'How It Works', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Your seamless journey from concept to reality.', type: 'text' },
                ]
            },
            {
                type: 'process',
                title: 'Our Process Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our 6-Step Process', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'A seamless journey from concept to completion.', type: 'textarea' },
                ]
            },
             {
                type: 'benefits',
                title: 'Why Our Process Works Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Why Our Process Works', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: "We've refined our approach to guarantee a smooth and successful project.", type: 'textarea' },
                ]
            },
             {
                type: 'get_started',
                title: 'Get Started Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Ready to Start Your Project?', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: "Let's bring your vision to life. Schedule a free, no-obligation consultation with our design experts today.", type: 'textarea' },
                     { name: 'buttonText', label: 'Button Text', value: 'Book a Free Consultation', type: 'text' },
                ]
            }
        ]
    },
     '/services': {
        title: 'Services Page',
        metaTitle: 'Interior Design Services in Pune | Shriram Interio',
        metaDescription: 'We offer a wide range of interior design services in Pune, including modular kitchens, wardrobe design, full home interiors, and exterior design.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Services', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Comprehensive design solutions for every corner of your home.', type: 'text' },
                ]
            },
            {
                type: 'detailed_services',
                title: 'Detailed Services',
                visible: true,
                fields: [],
            }
        ]
    },
    '/portfolio': {
        title: 'Portfolio Page',
        metaTitle: 'Our Interior Design Portfolio | Shriram Interio Projects',
        metaDescription: 'Browse our portfolio of completed projects. See examples of our modular kitchens, living areas, wardrobes, and other interior design work in Pune.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Portfolio', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'A glimpse into the spaces we have transformed.', type: 'text' },
                ]
            },
             {
                type: 'partners',
                title: 'Partners Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Partners', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'MEET OUR PARTNERS', type: 'text' },
                ]
            },
        ]
    },
    '/clients': {
        title: 'Clients Page',
        metaTitle: 'Client Testimonials & Reviews | Shriram Interio',
        metaDescription: 'Read reviews and watch video testimonials from our happy clients across Pune. See why we are the trusted choice for interior design.',
        sections: [
             {
                type: 'video_testimonials',
                title: 'Client Video Testimonials',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Client Video Testimonials', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'See our happy clients in action.', type: 'text' },
                ]
            },
            {
                type: 'text_testimonials',
                title: 'Client Testimonials',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Client Testimonials', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Hear from our happy clients across Pune.', type: 'text' },
                ]
            }
        ]
    },
    '/customer-stories': {
        title: 'Customer Stories Page',
        metaTitle: 'Customer Stories | Shriram Interio Project Showcases',
        metaDescription: 'Read in-depth stories about our client projects. See how we transformed homes and lives with our interior design expertise in Pune.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Customer Stories', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: "Read about the journeys we've shared with our clients to create their dream homes.", type: 'text' },
                ]
            },
             {
                type: 'featured_story',
                title: 'Featured Story',
                visible: true,
                fields: [],
            },
            {
                type: 'more_stories',
                title: 'More Stories',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'More Stories', type: 'text' },
                ],
            },
            {
                type: 'work_gallery',
                title: 'Work Gallery Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Work Gallery', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: "A glimpse into the spaces we've transformed.", type: 'textarea' },
                ]
            },
            {
                type: 'partners',
                title: 'Partners Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Our Partners', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'MEET OUR PARTNERS', type: 'text' },
                ]
            },
             {
                type: 'faq',
                title: 'FAQ Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Frequently Asked Questions', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Have questions? We have answers.', type: 'textarea' },
                ]
            },
        ]
    },
    '/contact': {
        title: 'Contact Us Page',
        metaTitle: 'Contact Shriram Interio | Get in Touch',
        metaDescription: 'Contact us for a free interior design consultation in Pune. Find our address, phone number, and email. We look forward to hearing from you.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Contact Us', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Get in touch with us for a free consultation.', type: 'text' },
                ]
            },
        ]
    },
     '/appointment': {
        title: 'Appointment Page',
        metaTitle: 'Book an Appointment | Shriram Interio',
        metaDescription: 'Schedule a free consultation with our expert interior designers in Pune. Use our easy online booking form to find a convenient time.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Book an Appointment', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Schedule a free consultation with our design experts by following the steps below.', type: 'text' },
                ]
            },
        ]
    },
    '/get-a-quote': {
        title: 'Get a Quote Page',
        metaTitle: 'Get a Free Quote for Interior Design | Shriram Interio',
        metaDescription: 'Request a free, no-obligation quote for your interior design project in Pune. Fill out our form and we will get back to you with a personalized estimate.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Get a Free Quote', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: "Fill out the form below and we'll get back to you with a personalized quote.", type: 'text' },
                ]
            },
        ]
    },
    '/tracking': {
        title: 'Tracking Page',
        metaTitle: 'Track Your Project | Shriram Interio',
        metaDescription: 'Track the status of your ongoing interior design project with Shriram Interio. Enter your project ID for the latest updates.',
        sections: [
             {
                type: 'pageHeader',
                title: 'Page Header',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Track Your Project', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Enter your project ID or registered contact number to see the latest updates on your interior design project.', type: 'text' },
                ]
            },
        ]
    },
    '/products/kitchen': {
        title: 'Kitchen Products Page',
        metaTitle: 'Modular Kitchens in Pune | Shriram Interio',
        metaDescription: 'Discover our beautiful and functional modular kitchens. We offer custom designs, premium materials, and smart storage solutions for your home in Pune.',
        sections: [
            {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Modular Kitchens', type: 'text' },
                    { name: 'description', label: 'Description', value: 'Discover the heart of your home with a Shriram Interio modular kitchen. We design beautiful, functional spaces that blend elegance and ergonomics, tailored to your unique lifestyle. Our kitchens are built to last, using premium materials and hardware for a seamless cooking experience every day.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Get a Free Quote', type: 'text' },
                ]
            },
            {
                type: 'why_choose_us',
                title: 'Why Choose Us Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Why Choose Our Kitchens?', type: 'text' },
                    { name: 'subtitle', label: 'Subtitle', value: 'Experience the perfect fusion of functionality and style.', type: 'text' },
                ]
            }
        ]
    },
    '/products/wardrobe': {
        title: 'Wardrobe Products Page',
        metaTitle: 'Custom Wardrobes in Pune | Shriram Interio',
        metaDescription: 'Explore our custom wardrobe solutions. We design and build sliding, hinged, and walk-in wardrobes to maximize your storage and enhance your bedroom decor.',
        sections: [
             {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Custom Wardrobes', type: 'text' },
                    { name: 'description', label: 'Description', value: 'Our wardrobes are thoughtfully designed to offer maximum storage while enhancing the aesthetics of your bedroom. From sleek sliding doors to classic hinged designs, we create personalized storage solutions that cater to your specific needs.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Design Your Wardrobe', type: 'text' },
                ]
            }
        ]
    },
    '/products/bedroom': {
        title: 'Bedroom Products Page',
        metaTitle: 'Bedroom Interior Design in Pune | Shriram Interio',
        metaDescription: 'Create your dream sanctuary with our bespoke bedroom interior designs. We focus on comfort, style, and functionality to give you a space for relaxation.',
        sections: [
             {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Bedroom Interiors', type: 'text' },
                    { name: 'image', label: 'Image', value: 'https://images.unsplash.com/photo-1617098900591-3f90928e8c54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxMnx8YmVkcm9vbSUyMGludGVyaW9yfGVufDB8fHx8MTc1NjAxMzgxMnww&ixlib=rb-4.1.0&q=80&w=1080', type: 'image' },
                    { name: 'description', label: 'Description', value: 'Create your dream sanctuary with our bespoke bedroom interior designs. We focus on creating a perfect balance of comfort, style, and functionality to give you a space where you can truly relax and rejuvenate.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Get a Free Quote', type: 'text' },
                ]
            }
        ]
    },
    '/products/living-room': {
        title: 'Living Room Products Page',
        metaTitle: 'Living Room Design in Pune | Shriram Interio',
        metaDescription: 'Design inviting and functional living spaces. Our experts help with furniture, lighting, and color schemes to create a warm atmosphere.',
        sections: [
             {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Living Room Design', type: 'text' },
                    { name: 'image', label: 'Image', value: 'https://placehold.co/600x400.png', type: 'image' },
                    { name: 'description', label: 'Description', value: 'Design inviting and functional living spaces for family and friends. Our expert designers help you choose the right furniture, lighting, and color schemes to create a warm and welcoming atmosphere.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Get a Free Quote', type: 'text' },
                ]
            }
        ]
    },
    '/products/bathroom': {
        title: 'Bathroom Products Page',
        metaTitle: 'Bathroom Design in Pune | Shriram Interio',
        metaDescription: 'Transform your bathroom into a stylish and practical oasis with our contemporary and classic design solutions.',
        sections: [
             {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Bathroom Design', type: 'text' },
                    { name: 'image', label: 'Image', value: 'https://placehold.co/600x400.png', type: 'image' },
                    { name: 'description', label: 'Description', value: 'Transform your bathroom into a stylish and practical oasis. We offer a range of solutions from contemporary to classic designs, ensuring a refreshing and luxurious experience.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Get a Free Quote', type: 'text' },
                ]
            }
        ]
    },
     '/products/space-saving-furniture': {
        title: 'Space Saving Furniture Page',
        metaTitle: 'Space Saving Furniture in Pune | Shriram Interio',
        metaDescription: 'Maximize your living area with our innovative and smart furniture solutions, perfect for modern apartments and compact homes.',
        sections: [
             {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Space Saving Furniture', type: 'text' },
                    { name: 'image', label: 'Image', value: 'https://placehold.co/600x400.png', type: 'image' },
                    { name: 'description', label: 'Description', value: 'Maximize your living area with our innovative and smart furniture solutions. Perfect for modern apartments and compact homes, our designs are both stylish and functional.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Get a Free Quote', type: 'text' },
                ]
            }
        ]
    },
     '/products/home-office': {
        title: 'Home Office Page',
        metaTitle: 'Home Office Design in Pune | Shriram Interio',
        metaDescription: 'Create a productive and comfortable workspace at home with our tailored home office solutions that blend ergonomics and aesthetics.',
        sections: [
             {
                type: 'main',
                title: 'Main Section',
                visible: true,
                fields: [
                    { name: 'title', label: 'Title', value: 'Home Office Design', type: 'text' },
                    { name: 'image', label: 'Image', value: 'https://placehold.co/600x400.png', type: 'image' },
                    { name: 'description', label: 'Description', value: 'Create a productive and comfortable workspace at home. Our home office solutions are tailored to your professional needs, ensuring a seamless blend of ergonomics and aesthetics.', type: 'textarea' },
                    { name: 'buttonText', label: 'Button Text', value: 'Get a Free Quote', type: 'text' },
                ]
            }
        ]
    },
};

function EditPageImpl() {
    const searchParams = useSearchParams();
    const pageSlug = searchParams.get('page') || '';
    const allNavItems = [...NAV_ITEMS, ...NAV_ITEMS.flatMap(item => item.subItems || [])];
    const pageData = allNavItems.find(p => p.href === `/${pageSlug}`);

    // Handle nested product pages
    const isProductSubPage = pageSlug.startsWith('products/');
    const isCustomerStorySubPage = pageSlug.startsWith('customer-stories/');

    let structure;
    if (isProductSubPage || isCustomerStorySubPage) {
         // @ts-ignore
        structure = pageStructure[`/${pageSlug}`];
    } else {
         // @ts-ignore
        structure = pageStructure[pageData?.href || ''];
    }

    const title = structure?.title || pageData?.label || "Page"


    if (!structure && !pageData) {
        return (
            <div>
                <h1 className="text-3xl font-bold mb-8">Page Not Found</h1>
                <p>The page you are trying to edit does not exist or has no editable structure.</p>
                 <Button asChild variant="outline" className="mt-4">
                    <Link href="/shriramadmin/pages">Back to Pages</Link>
                </Button>
            </div>
        )
    }

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                 <h1 className="text-3xl font-bold">Edit Page: {title}</h1>
                <div className="flex gap-4">
                    <Button variant="outline">Preview</Button>
                    <Button>Save Changes</Button>
                </div>
            </div>

            <div className="space-y-8">
                 <Card>
                    <CardHeader>
                        <CardTitle>Page Settings</CardTitle>
                        <CardDescription>Manage SEO settings and page metadata.</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-6">
                         <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div className="space-y-2">
                                <Label htmlFor="page-title">Page Title</Label>
                                <Input id="page-title" defaultValue={pageData?.label || title} />
                            </div>
                             <div className="space-y-2">
                                <Label htmlFor="page-slug">Slug</Label>
                                <Input id="page-slug" defaultValue={pageData?.href || `/${pageSlug}`} />
                            </div>
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="meta-title">Meta Title</Label>
                            <Input id="meta-title" defaultValue={structure?.metaTitle} />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="meta-description">Meta Description</Label>
                            <Textarea id="meta-description" defaultValue={structure?.metaDescription} rows={3} />
                        </div>
                    </CardContent>
                </Card>

                {structure ? structure.sections.map((section, index) => (
                    <Card key={index}>
                        <CardHeader className="flex flex-row items-center justify-between">
                            <div>
                                <CardTitle>{section.title}</CardTitle>
                                {section.fields.length > 0 && <CardDescription>Edit the content for this section.</CardDescription>}
                            </div>
                            <div className="flex items-center gap-2">
                                <Label htmlFor={`section-visible-${index}`} className="text-sm text-muted-foreground">
                                    {section.visible ? <Eye className="h-5 w-5" /> : <EyeOff className="h-5 w-5" />}
                                </Label>
                                <Switch id={`section-visible-${index}`} defaultChecked={section.visible} />
                            </div>
                        </CardHeader>
                         {section.fields.length > 0 && (
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
                         )}
                    </Card>
                )) : (
                     <Card>
                        <CardHeader>
                            <CardTitle>Page Content</CardTitle>
                            <CardDescription>This page does not have a structured editor yet.</CardDescription>
                        </CardHeader>
                        <CardContent>
                            <Textarea rows={15} placeholder="Raw content can be edited here." />
                        </CardContent>
                    </Card>
                )}
            </div>
        </div>
    );
}

export default function EditPage() {
    return (
        <Suspense fallback={<div>Loading...</div>}>
            <EditPageImpl />
        </Suspense>
    )
}
