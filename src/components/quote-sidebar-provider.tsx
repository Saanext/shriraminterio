
'use client';

import React, { createContext, useContext, useState, ReactNode } from 'react';

type QuoteSidebarContextType = {
    isOpen: boolean;
    setIsOpen: (isOpen: boolean) => void;
};

const QuoteSidebarContext = createContext<QuoteSidebarContextType | undefined>(undefined);

export function QuoteSidebarProvider({ children }: { children: ReactNode }) {
    const [isOpen, setIsOpen] = useState(false);

    return (
        <QuoteSidebarContext.Provider value={{ isOpen, setIsOpen }}>
            {children}
        </QuoteSidebarContext.Provider>
    );
}

export function useQuoteSidebar() {
    const context = useContext(QuoteSidebarContext);
    if (context === undefined) {
        throw new Error('useQuoteSidebar must be used within a QuoteSidebarProvider');
    }
    return context;
}
