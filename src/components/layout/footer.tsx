
import React from 'react';
import { Facebook, Instagram, Twitter, Youtube, Mail, Phone, MapPin } from 'lucide-react';
import Link from 'next/link';
import { NAV_ITEMS } from '@/lib/constants';

const socialLinks = [
    { href: '#', icon: <Facebook className="h-5 w-5" />, name: 'Facebook' },
    { href: '#', icon: <Twitter className="h-5 w-5" />, name: 'Twitter' },
    { href: '#', icon: <Instagram className="h-5 w-5" />, name: 'Instagram' },
    { href: '#', icon: <Youtube className="h-5 w-5" />, name: 'YouTube' },
];

export function Footer() {
    const allNavLinks = NAV_ITEMS.flatMap(item => 
        item.subItems ? [item, ...item.subItems] : [item]
    ).filter(item => item.href !== '/about');


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
                            {NAV_ITEMS.map((item) => (
                                <React.Fragment key={item.href}>
                                    {item.href !== '/about' && (
                                         <li>
                                            <Link href={item.href} className="text-sm text-muted-foreground hover:text-primary transition-colors">
                                                {item.label}
                                            </Link>
                                        </li>
                                    )}
                                    {item.subItems && item.subItems.map(subItem => (
                                        <li key={subItem.href} className="pl-4">
                                            <Link href={subItem.href} className="text-sm text-muted-foreground hover:text-primary transition-colors">
                                                {subItem.label}
                                            </Link>
                                        </li>
                                    ))}
                                </React.Fragment>
                            ))}
                        </ul>
                    </div>

                    {/* Get in Touch & Social */}
                    <div className="lg:col-span-2 grid grid-cols-1 sm:grid-cols-2 gap-8">
                        <div>
                            <h3 className="text-lg font-bold font-headline mb-4">GET IN TOUCH</h3>
                            <ul className="space-y-3 text-sm text-muted-foreground">
                                <li className="flex items-start">
                                    <MapPin className="h-4 w-4 mr-3 mt-1 flex-shrink-0 text-primary" />
                                    <span>Shop No 2, Shri Hsg Society, Sankalp Nagari, Dehuroad, Pune-412101</span>
                                </li>
                                <li className="flex items-center">
                                    <Mail className="h-4 w-4 mr-3 text-primary" />
                                    <a href="mailto:support@shriraminterio.com" className="hover:text-primary transition-colors">support@shriraminterio.com</a>
                                </li>
                                <li className="flex items-center">
                                    <Phone className="h-4 w-4 mr-3 text-primary" />
                                    <a href="tel:+918767951981" className="hover:text-primary transition-colors">+91 8767951981</a>
                                </li>
                            </ul>
                        </div>
                        <div>
                            <h3 className="text-lg font-bold font-headline mb-4">SOCIAL</h3>
                            <div className="flex space-x-2">
                                {socialLinks.map((social) => (
                                     <Link key={social.name} href={social.href} className="bg-white text-primary p-2 rounded-full hover:bg-primary hover:text-white transition-colors">
                                        {social.icon}
                                        <span className="sr-only">{social.name}</span>
                                    </Link>
                                ))}
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