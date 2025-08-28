
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
import { deleteStory } from "./story-actions";
import { useRouter } from "next/navigation";
import { DropdownMenuItem } from "./ui/dropdown-menu";
import React from "react";

export function StoryDeleteAction({ storyId, children }: { storyId: number; children: React.ReactNode }) {
    const { toast } = useToast();
    const router = useRouter();

    const handleDelete = async () => {
        const result = await deleteStory(storyId);
        if (result.success) {
            toast({ title: 'Story deleted successfully!' });
            router.refresh();
        } else {
            toast({ title: 'Error deleting story', description: result.error, variant: 'destructive' });
        }
    };

    return (
        <AlertDialog>
            <AlertDialogTrigger asChild>
                <DropdownMenuItem
                    onSelect={(e) => e.preventDefault()}
                    className="text-destructive focus:text-destructive"
                >
                    {children}
                </DropdownMenuItem>
            </AlertDialogTrigger>
            <AlertDialogContent>
                <AlertDialogHeader>
                <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
                <AlertDialogDescription>
                    This action cannot be undone. This will permanently delete this story
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
