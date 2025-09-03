
'use client';

import Link from 'next/link';
import { motion } from 'framer-motion';

const WhatsAppIcon = () => (
    <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 448 512"
        className="w-8 h-8"
        fill="currentColor"
    >
        <path d="M380.9 97.1C339 55.1 283.2 32 223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157zm-157 341.6c-33.8 0-65.7-10.8-94-31.4l-6.7-4-69.8 18.3L72 359.2l-4.4-7c-22.7-36.1-35.1-77.3-35.1-120.5 0-106.1 86-192.2 192.2-192.2 51.2 0 99.2 19.9 135.7 56.5 36.6 36.6 56.5 84.5 56.5 135.7-.1 106-86.1 192.2-192.2 192.2zM223.9 150.1c-12.2 0-22 9.8-22 22v77.5c0 12.2 9.8 22 22 22h77.5c12.2 0 22-9.8 22-22s-9.8-22-22-22h-55.5V172.1c0-12.2-9.8-22-22-22zM438.6 127.3c-9.4-9.4-24.6-9.4-33.9 0L343 188.7c-9.4 9.4-9.4 24.6 0 33.9l12.5 12.5c9.4 9.4 24.6 9.4 33.9 0L438.6 161.2c9.4-9.4 9.4-24.6 0-33.9z"/>
        <path d="M223.9 32c-122.4 0-222 99.6-222 222 0 39.1 10.2 77.3 29.6 111L0 480l117.7-30.9c32.4 17.7 68.9 27 106.1 27h.1c122.3 0 224.1-99.6 224.1-222 0-59.3-25.2-115-67.1-157C339 55.1 283.2 32 223.9 32zM128.5 367.6C100.9 346.2 84 311.4 84 274c0-75.3 61.2-136.5 136.5-136.5 37.6 0 72.9 14.6 99.4 41.1s41.1 61.8 41.1 99.4c0 75.3-61.2 136.5-136.5 136.5-37.6 0-72.9-14.6-99.4-41.1l-1.1-1.1-1.2-1.2zM223.9 150.1c-12.2 0-22 9.8-22 22v77.5c0 12.2 9.8 22 22 22h77.5c12.2 0 22-9.8 22-22s-9.8-22-22-22h-55.5V172.1c0-12.2-9.8-22-22-22z" />
    </svg>
);

export function WhatsAppButton() {
    const phoneNumber = "+918767951981"; // Your WhatsApp number
    const message = "Hello! I'm interested in your services."; // Pre-filled message
    const whatsappUrl = `https://wa.me/${phoneNumber}?text=${encodeURIComponent(message)}`;

    return (
        <motion.div
            initial={{ scale: 0, y: 100 }}
            animate={{ scale: 1, y: 0 }}
            transition={{
                delay: 1.5,
                duration: 0.5,
                type: 'spring',
                stiffness: 120
            }}
            whileHover={{ scale: 1.1 }}
            whileTap={{ scale: 0.9 }}
            className="fixed bottom-6 right-6 z-50"
        >
            <Link
                href={whatsappUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center w-16 h-16 bg-green-500 rounded-full shadow-lg text-white hover:bg-green-600 transition-colors duration-300"
                aria-label="Chat on WhatsApp"
            >
                <WhatsAppIcon />
            </Link>
        </motion.div>
    );
}
