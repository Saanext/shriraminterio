
'use client';

import { useForm } from 'react-hook-form';
import { useRouter } from 'next/navigation';
import { z } from 'zod';
import { zodResolver } from '@hookform/resolvers/zod';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from '@/hooks/use-toast';
import { saveContactDetail } from './contact-actions';
import { MapPin, Mail, Phone } from 'lucide-react';
import { useEffect } from 'react';

const contactDetailSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1, "Name is required"),
  value: z.string().min(1, "Value is required"),
  icon: z.string().optional().nullable(),
  slug: z.string().min(1, "Slug is required"),
  url_prefix: z.string().optional().nullable(),
});

type ContactFormValues = z.infer<typeof contactDetailSchema>;

const iconOptions = [
    { value: 'MapPin', label: 'Address', icon: <MapPin/> },
    { value: 'Mail', label: 'Email', icon: <Mail/> },
    { value: 'Phone', label: 'Phone', icon: <Phone/> },
]

export function ContactEditor({ initialData }: { initialData: any | null }) {
  const router = useRouter();
  const { toast } = useToast();

  const form = useForm<ContactFormValues>({
    resolver: zodResolver(contactDetailSchema),
    defaultValues: initialData || {
      name: '',
      slug: '',
      value: '',
      icon: '',
      url_prefix: '',
    },
  });
  
  const name = form.watch('name');
  useEffect(() => {
    if (name && !form.formState.dirtyFields.slug) {
        form.setValue('slug', name.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, ''));
    }
  }, [name, form]);


  const onSubmit = async (data: ContactFormValues) => {
    const result = await saveContactDetail(data);
    if (result.success) {
      toast({ title: 'Contact detail saved successfully!' });
      router.push('/shriramadmin/contact');
      router.refresh();
    } else {
      toast({ title: 'Error saving detail', description: result.error, variant: 'destructive' });
    }
  };

  const isNew = !initialData;

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold">{isNew ? 'Create New Contact Detail' : 'Edit Contact Detail'}</h1>
          <Button type="submit" disabled={form.formState.isSubmitting}>
            {form.formState.isSubmitting ? 'Saving...' : 'Save Detail'}
          </Button>
        </div>
        
        <Card>
            <CardHeader>
                <CardTitle>Detail Information</CardTitle>
                <CardDescription>Enter the details for the contact item.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
                 {initialData?.id && <input type="hidden" {...form.register('id')} />}
                <FormField control={form.control} name="name" render={({ field }) => (
                    <FormItem>
                        <FormLabel>Name</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., Address" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="slug" render={({ field }) => (
                    <FormItem>
                        <FormLabel>Slug</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., address" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="value" render={({ field }) => (
                    <FormItem>
                        <FormLabel>Value</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., 123 Main St..." /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                 <FormField control={form.control} name="url_prefix" render={({ field }) => (
                    <FormItem>
                        <FormLabel>URL Prefix (Optional)</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., mailto: or tel:" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="icon" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Icon</FormLabel>
                    <Select onValueChange={field.onChange} defaultValue={field.value ?? undefined}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select an icon" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {iconOptions.map(option => (
                           <SelectItem key={option.value} value={option.value}>
                             <div className="flex items-center gap-2">
                               {option.icon}
                               <span>{option.label}</span>
                             </div>
                           </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )} />
            </CardContent>
        </Card>
      </form>
    </Form>
  );
}
