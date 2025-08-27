
'use client';

import { useState } from 'react';
import { useForm, useFieldArray } from 'react-hook-form';
import { useRouter } from 'next/navigation';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import Image from 'next/image';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { useToast } from '@/hooks/use-toast';
import { createClient } from '@/lib/supabase/client';
import { Upload, Trash2 } from 'lucide-react';
import { saveStory } from './story-actions';

const galleryItemSchema = z.object({
  src: z.string().url(),
  alt: z.string().min(1, "Alt text is required"),
  dataAiHint: z.string().optional(),
});

const storySchema = z.object({
  id: z.number().optional().nullable(),
  slug: z.string().min(1, "Slug is required").regex(/^[a-z0-9-]+$/, "Slug must be lowercase with no spaces"),
  title: z.string().min(1, "Title is required"),
  image: z.string().url("A valid image URL is required"),
  dataAiHint: z.string().optional(),
  category: z.string().min(1, "Category is required"),
  excerpt: z.string().min(1, "Excerpt is required"),
  author: z.string().min(1, "Author is required"),
  authorAvatar: z.string().url("A valid avatar URL is required"),
  date: z.string().min(1, "Date is required"),
  clientImage: z.string().url("A valid client image URL is required"),
  location: z.string().min(1, "Location is required"),
  project: z.string().min(1, "Project type is required"),
  size: z.string().min(1, "Project size is required"),
  quote: z.string().min(1, "Quote is required"),
  content: z.string().min(1, "Content is required"),
  gallery: z.array(galleryItemSchema),
});

type StoryFormValues = z.infer<typeof storySchema>;

export function StoryEditor({ initialData }: { initialData: StoryFormValues | null }) {
  const router = useRouter();
  const { toast } = useToast();
  const supabase = createClient();
  const [isUploading, setIsUploading] = useState(false);

  const form = useForm<StoryFormValues>({
    resolver: zodResolver(storySchema),
    defaultValues: initialData || {
      slug: '',
      title: '',
      image: '',
      dataAiHint: '',
      category: '',
      excerpt: '',
      author: '',
      authorAvatar: '',
      date: new Date().toISOString().split('T')[0],
      clientImage: '',
      location: '',
      project: '',
      size: '',
      quote: '',
      content: '',
      gallery: [],
    },
  });

  const { fields, append, remove } = useFieldArray({
    control: form.control,
    name: 'gallery',
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
  
  const handleFileChange = (field: keyof StoryFormValues) => async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
        const url = await handleImageUpload(file);
        if (url) {
            form.setValue(field, url, { shouldValidate: true });
        }
    }
  };
  
  const handleGalleryFileChange = (index: number) => async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
        const url = await handleImageUpload(file);
        if (url) {
            form.setValue(`gallery.${index}.src`, url, { shouldValidate: true });
        }
    }
  };

  const onSubmit = async (data: StoryFormValues) => {
    const result = await saveStory(data);
    if (result.success) {
      toast({ title: 'Story saved successfully!' });
      router.push('/shriramadmin/stories');
      router.refresh(); // To reflect changes in the list
    } else {
      toast({ title: 'Error saving story', description: result.error, variant: 'destructive' });
    }
  };

  const isNew = !initialData;

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold">{isNew ? 'Create New Story' : 'Edit Story'}</h1>
          <Button type="submit" disabled={form.formState.isSubmitting || isUploading}>
            {form.formState.isSubmitting ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2 space-y-8">
            <Card>
              <CardHeader><CardTitle>Story Details</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                <FormField control={form.control} name="title" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Title</FormLabel>
                    <FormControl><Input {...field} /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
                <FormField control={form.control} name="slug" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Slug</FormLabel>
                    <FormControl><Input {...field} /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
                 <FormField control={form.control} name="content" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Content (HTML)</FormLabel>
                    <FormControl><Textarea {...field} rows={15} /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
              </CardContent>
            </Card>
             <Card>
              <CardHeader><CardTitle>Client Details &amp; Testimonial</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <FormField control={form.control} name="location" render={({ field }) => (
                        <FormItem><FormLabel>Location</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                    )} />
                     <FormField control={form.control} name="project" render={({ field }) => (
                        <FormItem><FormLabel>Project Type</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                    )} />
                     <FormField control={form.control} name="size" render={({ field }) => (
                        <FormItem><FormLabel>Project Size</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                    )} />
                    <div className="md:col-span-2">
                        <FormField control={form.control} name="quote" render={({ field }) => (
                            <FormItem><FormLabel>Client Quote</FormLabel><FormControl><Textarea {...field} /></FormControl><FormMessage /></FormItem>
                        )} />
                    </div>
                </div>
                 <FormField control={form.control} name="clientImage" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Client Image</FormLabel>
                    {field.value && <Image src={field.value} alt="Client" width={80} height={80} className="rounded-md object-cover" />}
                    <FormControl><Input type="file" accept="image/*" onChange={handleFileChange('clientImage')} /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
              </CardContent>
            </Card>

            <Card>
                <CardHeader>
                    <div className="flex justify-between items-center">
                        <CardTitle>Project Gallery</CardTitle>
                        <Button type="button" variant="outline" size="sm" onClick={() => append({ src: '', alt: '', dataAiHint: '' })}>Add Gallery Image</Button>
                    </div>
                </CardHeader>
                <CardContent className="space-y-4">
                    {fields.map((field, index) => (
                        <Card key={field.id} className="p-4 bg-muted/50">
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <FormField control={form.control} name={`gallery.${index}.src`} render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Image</FormLabel>
                                    {field.value && <Image src={field.value} alt="Gallery item" width={80} height={80} className="rounded-md object-cover" />}
                                    <FormControl><Input type="file" accept="image/*" onChange={handleGalleryFileChange(index)} /></FormControl>
                                    <FormMessage />
                                </FormItem>
                                )} />
                                <FormField control={form.control} name={`gallery.${index}.alt`} render={({ field }) => (
                                <FormItem><FormLabel>Alt Text</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                                )} />
                                <FormField control={form.control} name={`gallery.${index}.dataAiHint`} render={({ field }) => (
                                <FormItem><FormLabel>AI Hint</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                                )} />
                            </div>
                            <Button type="button" variant="destructive" size="sm" className="mt-4" onClick={() => remove(index)}>
                                <Trash2 className="mr-2 h-4 w-4"/>Remove
                            </Button>
                        </Card>
                    ))}
                </CardContent>
            </Card>

          </div>
          <div className="lg:col-span-1 space-y-8">
            <Card>
              <CardHeader><CardTitle>Metadata</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                 <FormField control={form.control} name="category" render={({ field }) => (
                  <FormItem><FormLabel>Category</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="date" render={({ field }) => (
                  <FormItem><FormLabel>Date</FormLabel><FormControl><Input type="date" {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                 <FormField control={form.control} name="excerpt" render={({ field }) => (
                  <FormItem><FormLabel>Excerpt</FormLabel><FormControl><Textarea {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="dataAiHint" render={({ field }) => (
                  <FormItem><FormLabel>Main Image AI Hint</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
              </CardContent>
            </Card>
             <Card>
              <CardHeader><CardTitle>Images</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                 <FormField control={form.control} name="image" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Main Image</FormLabel>
                    {field.value && <Image src={field.value} alt="Main Story" width={80} height={80} className="rounded-md object-cover" />}
                    <FormControl><Input type="file" accept="image/*" onChange={handleFileChange('image')} /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
              </CardContent>
            </Card>
            <Card>
              <CardHeader><CardTitle>Author</CardTitle></CardHeader>
              <CardContent className="space-y-4">
                <FormField control={form.control} name="author" render={({ field }) => (
                  <FormItem><FormLabel>Author Name</FormLabel><FormControl><Input {...field} /></FormControl><FormMessage /></FormItem>
                )} />
                <FormField control={form.control} name="authorAvatar" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Author Avatar</FormLabel>
                     {field.value && <Image src={field.value} alt="Author" width={80} height={80} className="rounded-full object-cover" />}
                    <FormControl><Input type="file" accept="image/*" onChange={handleFileChange('authorAvatar')} /></FormControl>
                    <FormMessage />
                  </FormItem>
                )} />
              </CardContent>
            </Card>
          </div>
        </div>
      </form>
    </Form>
  );
}

    