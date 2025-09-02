
'use client';

import { useState, useEffect } from 'react';
import { useForm, useFieldArray } from 'react-hook-form';
import { useRouter } from 'next/navigation';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import Image from 'next/image';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { useToast } from '@/hooks/use-toast';
import { createClient } from '@/lib/supabase/client';
import { Upload, Trash2 } from 'lucide-react';
import { savePortfolioItem } from './portfolio-actions';

const portfolioSchema = z.object({
  id: z.number().optional().nullable(),
  title: z.string().min(1, "Title is required"),
  slug: z.string().min(1, "Slug is required").regex(/^[a-z0-9-]+$/, "Slug must be lowercase with no spaces"),
  content: z.string().optional(),
  main_image: z.string().url("A valid main image URL is required"),
  gallery: z.array(z.object({ value: z.string() })).optional().default([]),
});

type PortfolioFormValues = z.infer<typeof portfolioSchema>;

export function PortfolioEditor({ initialData }: { initialData: any | null }) {
  const router = useRouter();
  const { toast } = useToast();
  const supabase = createClient();
  const [isUploading, setIsUploading] = useState(false);

  const form = useForm<PortfolioFormValues>({
    resolver: zodResolver(portfolioSchema),
    defaultValues: initialData ? {
        ...initialData,
        gallery: (initialData.gallery || []).map((g: string) => ({ value: g })),
    } : {
      title: '',
      slug: '',
      content: '',
      main_image: '',
      gallery: [],
    },
  });

  const { fields: galleryFields, append: appendGallery, remove: removeGallery } = useFieldArray({
    control: form.control,
    name: 'gallery',
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
  
  const handleMainImageChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const url = await handleImageUpload(file);
      if (url) form.setValue('main_image', url, { shouldValidate: true });
    }
  };
  
  const handleGalleryFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      const url = await handleImageUpload(file);
      if (url) appendGallery({ value: url });
    }
  };

  const onSubmit = async (data: PortfolioFormValues) => {
    const result = await savePortfolioItem({
        ...data,
        gallery: (data.gallery || []).map(g => g.value).filter(Boolean),
    });
    if (result.success) {
      toast({ title: 'Portfolio item saved successfully!' });
      router.push('/shriramadmin/portfolio');
      router.refresh();
    } else {
      toast({ title: 'Error saving item', description: result.error, variant: 'destructive' });
    }
  };

  const isNew = !initialData;
  
  const title = form.watch('title');
  
  useEffect(() => {
    if (title && !form.formState.dirtyFields.slug) {
        form.setValue('slug', title.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, ''));
    }
  }, [title, form]);

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold">{isNew ? 'Create New Portfolio Item' : 'Edit Portfolio Item'}</h1>
          <Button type="submit" disabled={form.formState.isSubmitting || isUploading}>
            {form.formState.isSubmitting ? 'Saving...' : 'Save Item'}
          </Button>
        </div>
        
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2 space-y-8">
            <Card>
              <CardHeader><CardTitle>Item Information</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                <FormField control={form.control} name="title" render={({ field }) => (
                  <FormItem><FormLabel>Title</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="slug" render={({ field }) => (
                  <FormItem><FormLabel>Slug</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="content" render={({ field }) => (
                  <FormItem><FormLabel>Content (HTML is supported)</FormLabel><FormControl><Textarea rows={10} {...field} /></FormControl><FormMessage /></FormItem>
                )} />
              </CardContent>
            </Card>
          </div>

          <div className="lg:col-span-1 space-y-8">
             <Card>
              <CardHeader><CardTitle>Images</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                <FormField control={form.control} name="main_image" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Main/Card Image</FormLabel>
                    {field.value && <Image src={field.value} alt="Main Image" width={120} height={90} className="rounded-md object-cover" />}
                    <FormControl>
                        <div className="relative mt-2">
                           <Button asChild variant="outline" size="sm" className="w-full">
                            <label htmlFor="main-image-upload" className="cursor-pointer">
                                <Upload className="mr-2 h-4 w-4" /> Upload Main Image
                            </label>
                           </Button>
                           <Input 
                            id="main-image-upload"
                            type="file" 
                            className="sr-only" 
                            accept="image/*"
                            onChange={handleMainImageChange}
                           />
                        </div>
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
                
                <div className="space-y-2">
                    <FormLabel>Slider Gallery Images</FormLabel>
                    <div className="space-y-4">
                        {galleryFields.map((field, index) => (
                            <div key={field.id} className="flex items-center gap-2">
                                <Image src={form.getValues(`gallery.${index}.value`)} alt={`Gallery image ${index + 1}`} width={80} height={60} className="rounded-md object-cover" />
                                <Button type="button" variant="destructive" size="icon" onClick={() => removeGallery(index)}>
                                    <Trash2 className="h-4 w-4" />
                                </Button>
                            </div>
                        ))}
                    </div>
                     <FormControl>
                        <div className="relative mt-2">
                           <Button asChild variant="outline" size="sm" className="w-full">
                            <label htmlFor="gallery-upload" className="cursor-pointer">
                                <Upload className="mr-2 h-4 w-4" /> Upload Gallery Image
                            </label>
                           </Button>
                           <Input 
                            id="gallery-upload"
                            type="file" 
                            className="sr-only" 
                            accept="image/*"
                            onChange={handleGalleryFileChange}
                           />
                        </div>
                    </FormControl>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </form>
    </Form>
  );
}
