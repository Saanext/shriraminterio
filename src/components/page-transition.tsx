'use client';

import { motion, AnimatePresence } from 'framer-motion';
import { usePathname } from 'next/navigation';

export function PageTransition({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  return (
    <AnimatePresence mode="wait">
      <motion.div
        key={pathname}
        initial="initialState"
        animate="animateState"
        exit="exitState"
        transition={{
          duration: 0.75,
        }}
        variants={{
          initialState: {
            opacity: 0,
            clipPath: 'polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)',
          },
          animateState: {
            opacity: 1,
            clipPath: 'polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)',
          },
          exitState: {
            clipPath: 'polygon(100% 0%, 100% 0%, 100% 100%, 100% 100%)',
          },
        }}
      >
        {children}
      </motion.div>
    </AnimatePresence>
  );
}
