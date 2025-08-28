
'use client';

import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetDescription } from "@/components/ui/sheet";
import { GetAQuoteForm } from "@/components/get-a-quote-form";
import { useQuoteSidebar } from "@/components/quote-sidebar-provider";

export function QuoteSidebar() {
    const { isOpen, setIsOpen } = useQuoteSidebar();

    return (
        <Sheet open={isOpen} onOpenChange={setIsOpen}>
            <SheetContent className="w-full sm:max-w-md p-0">
                <div className="h-full flex flex-col">
                    <SheetHeader className="p-6 border-b">
                        <SheetTitle className="text-2xl">Get a Free Quote</SheetTitle>
                        <SheetDescription>
                            Fill out the form below and we'll get back to you with a personalized quote.
                        </SheetDescription>
                    </SheetHeader>
                    <div className="flex-grow overflow-y-auto p-6">
                        <GetAQuoteForm />
                    </div>
                </div>
            </SheetContent>
        </Sheet>
    );
}
