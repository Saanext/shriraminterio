
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
import { deleteSalesPerson } from "./sales-person-actions";
import { useRouter } from "next/navigation";
import { DropdownMenuItem } from "./ui/dropdown-menu";

export function SalesPersonDeleteAction({ personId, children }: { personId: number; children: React.ReactNode }) {
    const { toast } = useToast();
    const router = useRouter();

    const handleDelete = async () => {
        const result = await deleteSalesPerson(personId);
        if (result.success) {
            toast({ title: 'Sales person deleted successfully!' });
            router.refresh();
        } else {
            toast({ title: 'Error deleting sales person', description: result.error, variant: 'destructive' });
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
                    This action cannot be undone. This will permanently delete this sales person
                    and remove their data from our servers. Any leads assigned to them will be unassigned.
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
