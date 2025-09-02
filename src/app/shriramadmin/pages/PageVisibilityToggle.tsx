
'use client';

import { DropdownMenuItem } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Eye, EyeOff } from "lucide-react";
import { useRouter } from "next/navigation";
import { useTransition } from "react";
import { togglePageVisibility } from "./actions";

type Props = {
    pageId: number;
    isVisible: boolean;
};

export function PageVisibilityToggle({ pageId, isVisible }: Props) {
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
        <DropdownMenuItem onClick={handleClick} disabled={isPending}>
            {isVisible ? (
                <><EyeOff className="mr-2 h-4 w-4" /><span>Hide</span></>
            ) : (
                <><Eye className="mr-2 h-4 w-4" /><span>Show</span></>
            )}
        </DropdownMenuItem>
    );
}
