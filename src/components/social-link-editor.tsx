
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
import { saveSocialLink } from './social-link-actions';
import { Facebook, Instagram, Twitter, Youtube } from 'lucide-react';

const socialLinkSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1, "Name is required"),
  url: z.string().url("A valid URL is required"),
  icon: z.string().min(1, "An icon is required"),
});

type SocialLinkFormValues = z.infer<typeof socialLinkSchema>;

const iconOptions = [
    { value: 'Facebook', label: 'Facebook', icon: <Facebook/> },
    { value: 'Twitter', label: 'Twitter', icon: <Twitter/> },
    { value: 'Instagram', label: 'Instagram', icon: <Instagram/> },
    { value: 'Youtube', label: 'Youtube', icon: <Youtube/> },
]

export function SocialLinkEditor({ initialData }: { initialData: any | null }) {
  const router = useRouter();
  const { toast } = useToast();

  const form = useForm<SocialLinkFormValues>({
    resolver: zodResolver(socialLinkSchema),
    defaultValues: initialData || {
      name: '',
      url: '',
      icon: '',
    },
  });

  const onSubmit = async (data: SocialLinkFormValues) => {
    const result = await saveSocialLink(data);
    if (result.success) {
      toast({ title: 'Social link saved successfully!' });
      router.push('/shriramadmin/social-links');
      router.refresh();
    } else {
      toast({ title: 'Error saving link', description: result.error, variant: 'destructive' });
    }
  };

  const isNew = !initialData;

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold">{isNew ? 'Create New Social Link' : 'Edit Social Link'}</h1>
          <Button type="submit" disabled={form.formState.isSubmitting}>
            {form.formState.isSubmitting ? 'Saving...' : 'Save Link'}
          </Button>
        </div>
        
        <Card>
            <CardHeader>
                <CardTitle>Link Details</CardTitle>
                <CardDescription>Enter the details for the social media link.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
                <FormField control={form.control} name="name" render={({ field }) => (
                    <FormItem>
                        <FormLabel>Name</FormLabel>
                        <FormControl><Input {...field} placeholder="e.g., Facebook" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="url" render={({ field }) => (
                    <FormItem>
                        <FormLabel>URL</FormLabel>
                        <FormControl><Input {...field} placeholder="https://www.facebook.com/your-page" /></FormControl>
                        <FormMessage />
                    </FormItem>
                )} />
                <FormField control={form.control} name="icon" render={({ field }) => (
                  <FormItem>
                    <FormLabel>Icon</FormLabel>
                    <Select onValueChange={field.onChange} defaultValue={field.value}>
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
