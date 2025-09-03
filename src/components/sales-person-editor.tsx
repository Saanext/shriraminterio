
'use client';

import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { useRouter } from 'next/navigation';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import Image from 'next/image';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { useToast } from '@/hooks/use-toast';
import { createClient } from '@/lib/supabase/client';
import { Upload } from 'lucide-react';
import { saveSalesPerson } from './sales-person-actions';

const salesPersonSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1, "Name is required"),
  contact_number: z.string().min(10, "A valid contact number is required"),
  profile_image_url: z.string().url("A profile image is required"),
});

type SalesPersonFormValues = z.infer<typeof salesPersonSchema>;

export function SalesPersonEditor({ initialData }: { initialData: any | null }) {
  const router = useRouter();
  const { toast } = useToast();
  const supabase = createClient();
  const [isUploading, setIsUploading] = useState(false);

  const form = useForm<SalesPersonFormValues>({
    resolver: zodResolver(salesPersonSchema),
    defaultValues: initialData || {
      name: '',
      contact_number: '',
      profile_image_url: '',
    },
  });

  const handleImageUpload = async (file: File): Promise<string | null> => {
    if (!file) return null;

    setIsUploading(true);
    const toastId = toast({ title: 'Uploading image...' }).id;

    const fileName = `${Date.now()}-${file.name}`;
    const { data, error } = await supabase.storage.from('public').upload(fileName, file);

    setIsUploading(false);
    if (error) {
      toast({ id: toastId, title: 'Upload failed', description: error.message, variant: 'destructive' });
      return null;
    }

    const { data: { publicUrl } } = supabase.storage.from('public').getPublicUrl(fileName);
    toast({ id: toastId, title: 'Upload successful!' });
    return publicUrl;
  };
  
  const handleProfileImageChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const url = await handleImageUpload(file);
      if (url) form.setValue('profile_image_url', url, { shouldValidate: true });
    }
  };

  const onSubmit = async (data: SalesPersonFormValues) => {
    const result = await saveSalesPerson(data);
    if (result.success) {
      toast({ title: 'Sales Person saved successfully!' });
      router.push('/shriramadmin/sales-persons');
      router.refresh();
    } else {
      toast({ title: 'Error saving sales person', description: result.error, variant: 'destructive' });
    }
  };

  const isNew = !initialData;

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold">{isNew ? 'Create New Sales Person' : 'Edit Sales Person'}</h1>
          <Button type="submit" disabled={form.formState.isSubmitting || isUploading}>
            {form.formState.isSubmitting ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>
        
        <Card>
            <CardHeader>
                <CardTitle>Sales Person Details</CardTitle>
                <CardDescription>Enter the details for the sales person.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
                <FormField control={form.control} name="name" render={({ field }) => (
                    <FormItem>
                        <FormLabel>Full Name</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., Jane Smith" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="contact_number" render={({ field }) => (
                    <FormItem>
                        <FormLabel>Contact Number</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., 9876543210" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="profile_image_url" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Profile Image</FormLabel>
                    <div className="flex items-center gap-4">
                        {field.value && <Image src={field.value} alt="Profile preview" width={80} height={80} className="rounded-full object-cover h-20 w-20" />}
                        <div className="flex-grow">
                            <FormControl>
                                <div className="relative mt-2">
                                <Button asChild variant="outline" size="sm" className="w-full">
                                    <label htmlFor="profile-image-upload" className="cursor-pointer">
                                        <Upload className="mr-2 h-4 w-4" /> Upload Profile Image
                                    </label>
                                </Button>
                                <Input 
                                    id="profile-image-upload"
                                    type="file" 
                                    className="sr-only" 
                                    accept="image/*"
                                    onChange={handleProfileImageChange}
                                />
                                </div>
                            </FormControl>
                        </div>
                    </div>
                    <FormMessage />
                  </FormItem>
                )} />
            </CardContent>
        </Card>
      </form>
    </Form>
  );
}
