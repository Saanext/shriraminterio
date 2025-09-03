
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
        <path d="M17.472 14.382c-.297-.149-.758-.372-1.03-.463-.272-.09-.543-.149-.814.15-.271.296-.42.592-.543.74-.122.149-.244.178-.487.03-.244-.149-.986-.372-1.875-1.147-.692-.574-1.153-1.29-1.325-1.518-.172-.227-.021-.354.122-.487.122-.122.271-.297.42-.464.122-.148.172-.27.243-.463.072-.194.021-.373-.04-.52-.06-.148-.758-.935-1.03-1.29-.271-.354-.543-.324-.758-.324-.194 0-.42.02-.63.02s-.543.09-.814.373c-.271.296-1.03.957-1.03 2.313 0 1.355 1.05 2.67 1.2 2.84.148.172 2.056 3.194 5.006 4.41 2.95 1.214 2.95 1.803 3.472 1.748.522-.056 1.62-.68 1.848-1.354.228-.673.228-1.26.172-1.354-.04-.09-.271-.148-.543-.296zM12 2.038c-5.522 0-9.962 4.456-9.962 9.962 0 1.76.455 3.424 1.288 4.887L2.038 22l5.225-1.288c1.463.76 3.09.214 4.737.214h.002c5.522 0 9.962-4.456 9.962-9.962 0-5.522-4.44-9.962-9.962-9.962z"/>
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
