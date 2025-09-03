
'use client';

import Link from 'next/link';
import { motion } from 'framer-motion';

const WhatsAppIcon = () => (
    <svg
        role="img"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
        className="w-8 h-8"
        fill="currentColor"
    >
        <title>WhatsApp</title>
        <path d="M12.04 2C6.58 2 2.13 6.45 2.13 12c0 1.77.46 3.43 1.29 4.89L2 22l5.29-1.38c1.45.83 3.08 1.32 4.75 1.32h.01c5.46 0 9.91-4.45 9.91-9.92 0-5.46-4.45-9.91-9.92-9.91zM17.51 16c-.28-.14-1.64-.81-1.9-0.9c-.25-.09-.44-.14-.62.14c-.18.28-.71.9-.88 1.08c-.16.18-.32.2-.59.06c-.27-.14-1.14-.42-2.17-1.34c-.81-.72-1.35-1.61-1.57-1.89c-.22-.28-.02-0.43.12-0.57c.13-.13.28-0.34.42-0.5c.14-.17.19-0.28.28-0.47c.09-0.18.04-0.36-0.02-0.5c-.06-.14-.62-1.49-0.85-2.04c-.23-.55-.46-.48-.62-.48c-.16 0-.34 0-.52 0c-.18 0-.47.07-.71.35c-.24.28-.93.9-0.93 2.2c0 1.3.96 2.55 1.1 2.73c.14.18 1.88 2.88 4.56 4.03c2.67 1.15 2.67.77 3.15.71c.48-.06 1.64-0.67 1.87-1.32c.23-0.65.23-1.2.16-1.32c-.07-.12-.25-.2-.52-.34z" />
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
