
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
import { deleteTestimonial } from "./testimonial-actions";
import { useRouter } from "next/navigation";
import { DropdownMenuItem } from "./ui/dropdown-menu";

export function TestimonialDeleteAction({ testimonialId, children }: { testimonialId: number; children: React.ReactNode }) {
    const { toast } = useToast();
    const router = useRouter();

    const handleDelete = async () => {
        const result = await deleteTestimonial(testimonialId);
        if (result.success) {
            toast({ title: 'Testimonial deleted successfully!' });
            router.refresh();
        } else {
            toast({ title: 'Error deleting testimonial', description: result.error, variant: 'destructive' });
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
                    This action cannot be undone. This will permanently delete this testimonial.
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
