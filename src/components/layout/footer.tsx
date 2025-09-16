
'use server';

import React from 'react';
import { Facebook, Instagram, Twitter, Youtube, Mail, Phone, MapPin, LucideProps } from 'lucide-react';
import Link from 'next/link';
import { createClient } from '@/lib/supabase/server';

const iconMap: { [key: string]: React.FC<LucideProps> } = {
    Facebook,
    Twitter,
    Instagram,
    Youtube,
};

const contactIconMap: { [key: string]: React.FC<LucideProps> } = {
    MapPin,
    Mail,
    Phone,
};


async function getSocialLinks() {
    const supabase = createClient();
    const { data } = await supabase.from('social_links').select('*').order('name');
    return data || [];
}

async function getContactDetails() {
    const supabase = createClient();
    const { data } = await supabase.from('contact_details').select('*');
    return data || [];
}

export async function Footer() {
    const socialLinks = await getSocialLinks();
    const contactDetails = await getContactDetails();
    
    const quickLinks = [
        { href: '/', label: 'Home' },
        { href: '/contact', label: 'Contact' },
        { href: '/appointment', label: 'Appointment' },
    ];

    return (
        <footer className="bg-secondary text-secondary-foreground border-t">
            <div className="container mx-auto py-12 px-4">
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                    {/* About Company */}
                    <div className="col-span-1 md:col-span-2 lg:col-span-1">
                        <h3 className="text-lg font-bold font-headline mb-4">ABOUT COMPANY</h3>
                        <p className="text-sm text-muted-foreground mb-4">
                            SHRIRAM INTERIO is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul.
                        </p>
                        <p className="text-sm text-muted-foreground">
                            Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we've evolved, but our commitment to excellence remains unwavering.
                        </p>
                    </div>

                    {/* Quick Links */}
                    <div>
                        <h3 className="text-lg font-bold font-headline mb-4">QUICK LINKS</h3>
                        <ul className="space-y-2">
                            {quickLinks.map((item) => (
                                <li key={item.href}>
                                    <Link href={item.href} className="text-sm text-muted-foreground hover:text-primary transition-colors">
                                        {item.label}
                                    </Link>
                                </li>
                            ))}
                        </ul>
                    </div>

                    {/* Get in Touch & Social */}
                    <div className="lg:col-span-2 grid grid-cols-1 sm:grid-cols-2 gap-8">
                        <div>
                            <h3 className="text-lg font-bold font-headline mb-4">GET IN TOUCH</h3>
                            <ul className="space-y-3 text-sm text-muted-foreground">
                                {contactDetails.map((detail) => {
                                    const Icon = detail.icon ? contactIconMap[detail.icon] : null;
                                    const href = detail.url_prefix ? `${detail.url_prefix}${detail.value}` : undefined;
                                    return (
                                        <li key={detail.id} className="flex items-start">
                                            {Icon && <Icon className="h-4 w-4 mr-3 mt-1 flex-shrink-0 text-primary" />}
                                            {href ? (
                                                 <a href={href} className="hover:text-primary transition-colors">{detail.value}</a>
                                            ) : (
                                                 <span>{detail.value}</span>
                                            )}
                                        </li>
                                    );
                                })}
                            </ul>
                        </div>
                        <div>
                            <h3 className="text-lg font-bold font-headline mb-4">SOCIAL</h3>
                            <div className="flex space-x-2">
                                {socialLinks.map((social) => {
                                    const Icon = iconMap[social.icon as string];
                                    return (
                                        <Link key={social.name} href={social.url} target="_blank" rel="noopener noreferrer" className="bg-white text-primary p-2 rounded-full hover:bg-primary hover:text-white transition-colors">
                                            {Icon && <Icon className="h-5 w-5" />}
                                            <span className="sr-only">{social.name}</span>
                                        </Link>
                                    );
                                })}
                            </div>
                        </div>
                    </div>
                </div>
                <div className="mt-12 pt-8 border-t text-center text-sm text-muted-foreground">
                    <p>&copy; {new Date().getFullYear()} Shriram Interio Digital. All rights reserved.</p>
                </div>
            </div>
        </footer>
    );
}
