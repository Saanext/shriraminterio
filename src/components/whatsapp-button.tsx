
'use client';

import Link from 'next/link';
import { motion } from 'framer-motion';
import Image from 'next/image';

const whatsappIconSrc = `data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgY2xhc3M9Imx1Y2lkZSBsdWNpZGUtcGhlaSI+PHBhdGggZD0iTTIyIDExLjA4VjEyYTggOCAwIDAgMS04IDhINmEzIDMgMCAwIDEtMy0zVjZhMyAzIDAgMCAxIDMtM2g0LjkyIiAvPjxwYXRoIGQ9Ik0yMiA3VjVhMyAzIDAgMCAwLTMtM2gtMSIgLz48cGF0aCBkPSJNMTUgMy4xM1ZNYTE0IDE0IDAgMCAxIDQgMTAuMjUiIC8+PHBhdGggZD0iTTE4IDlhMyAzIDAgMSA xIDAgNnoiIC8+PC9zdmc+`;

export function WhatsAppButton() {
    const phoneNumber = "918767951981"; // Your WhatsApp number
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
                <Image src="https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg" alt="WhatsApp" width={32} height={32} />
            </Link>
        </motion.div>
    );
}
