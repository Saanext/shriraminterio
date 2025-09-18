
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
import { Textarea } from "@/components/ui/textarea";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { useToast } from '@/hooks/use-toast';
import { createClient } from '@/lib/supabase/client';
import { Upload } from 'lucide-react';
import { saveTestimonial } from './testimonial-actions';
import { Switch } from './ui/switch';

const testimonialSchema = z.object({
  id: z.number().optional().nullable(),
  is_featured: z.boolean().default(false),
  client_name: z.string().min(1, "Client name is required"),
  client_image_url: z.string().url("A valid image URL is required").optional().nullable(),
  location: z.string().optional().nullable(),
  project_type: z.string().optional().nullable(),
  project_size: z.string().optional().nullable(),
  quote: z.string().optional().nullable(),
  full_review: z.string().optional().nullable(),
});

type TestimonialFormValues = z.infer<typeof testimonialSchema>;

export function TestimonialEditor({ initialData }: { initialData: TestimonialFormValues | null }) {
  const router = useRouter();
  const { toast } = useToast();
  const supabase = createClient();
  const [isUploading, setIsUploading] = useState(false);

  const form = useForm<TestimonialFormValues>({
    resolver: zodResolver(testimonialSchema),
    defaultValues: initialData || {
      is_featured: false,
      client_name: '',
      client_image_url: null,
      location: '',
      project_type: '',
      project_size: '',
      quote: '',
      full_review: '',
    },
  });

  const handleImageUpload = async (file: File) => {
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

  const handleClientImageChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const url = await handleImageUpload(file);
      if (url) form.setValue('client_image_url', url, { shouldValidate: true });
    }
  };

  const onSubmit = async (data: TestimonialFormValues) => {
    const result = await saveTestimonial(data);
    if (result.success) {
      toast({ title: 'Testimonial saved successfully!' });
      router.push('/shriramadmin/testimonials');
      router.refresh();
    } else {
      toast({ title: 'Error saving testimonial', description: result.error, variant: 'destructive' });
    }
  };

  const isNew = !initialData;

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold">{isNew ? 'Create New Testimonial' : 'Edit Testimonial'}</h1>
          <Button type="submit" disabled={form.formState.isSubmitting || isUploading}>
            {form.formState.isSubmitting ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>Testimonial Details</CardTitle>
            <CardDescription>Fill in the client's feedback and project details.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <FormField control={form.control} name="client_name" render={({ field }) => (
                    <FormItem><FormLabel>Client Name</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="location" render={({ field }) => (
                    <FormItem><FormLabel>Location</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="project_type" render={({ field }) => (
                    <FormItem><FormLabel>Project Type</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="project_size" render={({ field }) => (
                    <FormItem><FormLabel>Project Size</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
            </div>
            
            <FormField control={form.control} name="quote" render={({ field }) => (
                <FormItem><FormLabel>Short Quote</FormLabel><FormControl><Textarea {...field} /></FormControl><FormMessage /></FormItem>
            )} />
            
            <FormField control={form.control} name="full_review" render={({ field }) => (
                <FormItem><FormLabel>Full Review</FormLabel><FormControl><Textarea rows={5} {...field} /></FormControl><FormMessage /></FormItem>
            )} />

            <FormField control={form.control} name="client_image_url" render={({ field }) => (
                <FormItem>
                    <FormLabel>Client Image</FormLabel>
                    {field.value && <Image src={field.value} alt="Client" width={100} height={100} className="rounded-md object-cover" />}
                    <FormControl>
                        <div className="relative mt-2">
                           <Button asChild variant="outline" size="sm">
                            <label htmlFor="client-image-upload" className="cursor-pointer">
                                <Upload className="mr-2 h-4 w-4" /> Upload Image
                            </label>
                           </Button>
                           <Input id="client-image-upload" type="file" className="sr-only" accept="image/*" onChange={handleClientImageChange} />
                        </div>
                    </FormControl>
                    <FormMessage />
                </FormItem>
            )} />
            
            <FormField
              control={form.control}
              name="is_featured"
              render={({ field }) => (
                <FormItem className="flex flex-row items-center justify-between rounded-lg border p-4">
                  <div className="space-y-0.5">
                    <FormLabel className="text-base">
                      Featured Testimonial
                    </FormLabel>
                    <FormDescription>
                      Display this testimonial prominently on the clients page. Only one can be featured at a time.
                    </FormDescription>
                  </div>
                  <FormControl>
                    <Switch
                      checked={field.value}
                      onCheckedChange={field.onChange}
                    />
                  </FormControl>
                </FormItem>
              )}
            />

          </CardContent>
        </Card>
      </form>
    </Form>
  );
}
