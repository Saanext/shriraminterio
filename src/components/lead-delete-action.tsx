
'use client';

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog"
import { useToast } from "@/hooks/use-toast";
import { deleteLead } from "./lead-actions";
import { useRouter } from "next/navigation";
import { DropdownMenuItem } from "./ui/dropdown-menu";

export function LeadDeleteAction({ leadId, children }: { leadId: number; children: React.ReactNode }) {
    const { toast } = useToast();
    const router = useRouter();

    const handleDelete = async () => {
        const result = await deleteLead(leadId);
        if (result.success) {
            toast({ title: 'Lead deleted successfully!' });
            router.refresh();
        } else {
            toast({ title: 'Error deleting lead', description: result.error, variant: 'destructive' });
        }
    };

    return (
        <AlertDialog>
            <AlertDialogTrigger asChild>
                 <DropdownMenuItem onSelect={(e) => e.preventDefault()}>
                    {children}
                 </DropdownMenuItem>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                <AlertDialogDescription>
                    This action cannot be undone. This will permanently delete this lead
                    and remove its data from our servers.
                </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                <AlertDialogCancel>Cancel</AlertDialogCancel>
                <AlertDialogAction onClick={handleDelete} className="bg-destructive hover:bg-destructive/90">Continue</AlertDialogAction>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    );
}
