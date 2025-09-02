
'use client';

import { useToast } from "@/hooks/use-toast";
import { useRouter } from "next/navigation";
import { useTransition, type ReactNode } from "react";
import { togglePageVisibility } from "./actions";

type Props = {
    pageId: number;
    isVisible: boolean;
    children: ReactNode;
};

export function PageVisibilityToggle({ pageId, isVisible, children }: Props) {
    const { toast } = useToast();
    const router = useRouter();
    const [isPending, startTransition] = useTransition();

    const handleClick = async () => {
        startTransition(async () => {
            const result = await togglePageVisibility(pageId, isVisible);
            if (result.success) {
                toast({
                    title: `Page ${isVisible ? 'Hidden' : 'Shown'}`,
                    description: `The page is now ${isVisible ? 'hidden from' : 'visible on'} the site.`,
                });
                router.refresh();
            } else {
                toast({
                    title: 'Error',
                    description: result.error,
                    variant: 'destructive'
                });
            }
        });
    };

    return (
        <div onClick={handleClick} className="w-full h-full">
            {children}
        </div>
    );
}
