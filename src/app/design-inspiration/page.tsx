'use client';

import { useState } from 'react';
import Image from 'next/image';
import { useForm, SubmitHandler } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { getInspiration } from './actions';
import type { DesignInspirationOutput } from '@/ai/flows/design-inspiration';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Skeleton } from '@/components/ui/skeleton';
import { useToast } from '@/hooks/use-toast';
import { Sparkles, Lightbulb } from 'lucide-react';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';

const formSchema = z.object({
  style: z.string({ required_error: 'Please select a style.' }),
  colorPalette: z.string({ required_error: 'Please select a color palette.' }),
  roomType: z.string({ required_error: 'Please select a room type.' }),
});

type FormValues = z.infer<typeof formSchema>;

export default function DesignInspirationPage() {
  const [inspiration, setInspiration] = useState<DesignInspirationOutput | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const { toast } = useToast();

  const form = useForm<FormValues>({
    resolver: zodResolver(formSchema),
  });

  const onSubmit: SubmitHandler<FormValues> = async (data) => {
    setIsLoading(true);
    setInspiration(null);
    const result = await getInspiration(data);

    if (result.error) {
      toast({
        variant: 'destructive',
        title: 'Error',
        description: result.error,
      });
    } else {
      setInspiration(result.data);
    }
    setIsLoading(false);
  };

  return (
    <div className="bg-secondary">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">AI Design Inspiration</h1>
          <p className="text-lg text-muted-foreground mt-2">Unleash your creativity. Let our AI generate a unique design concept for you.</p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-12">
          <Card className="shadow-lg">
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-2xl">
                <Sparkles className="h-6 w-6 text-primary" />
                Generate Your Design
              </CardTitle>
              <CardDescription>Fill out your preferences below to get a custom design idea.</CardDescription>
            </CardHeader>
            <CardContent>
              <Form {...form}>
                <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
                  <FormField
                    control={form.control}
                    name="style"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Design Style</FormLabel>
                        <Select onValueChange={field.onChange} defaultValue={field.value}>
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="e.g., Modern, Minimalist" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            <SelectItem value="Modern">Modern</SelectItem>
                            <SelectItem value="Minimalist">Minimalist</SelectItem>
                            <SelectItem value="Contemporary">Contemporary</SelectItem>
                            <SelectItem value="Industrial">Industrial</SelectItem>
                            <SelectItem value="Rustic">Rustic</SelectItem>
                            <SelectItem value="Bohemian">Bohemian</SelectItem>
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <FormField
                    control={form.control}
                    name="colorPalette"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Color Palette</FormLabel>
                        <Select onValueChange={field.onChange} defaultValue={field.value}>
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="e.g., Warm, Cool" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            <SelectItem value="Warm">Warm Tones</SelectItem>
                            <SelectItem value="Cool">Cool Tones</SelectItem>
                            <SelectItem value="Neutral">Neutral</SelectItem>
                            <SelectItem value="Earthy">Earthy</SelectItem>
                            <SelectItem value="Monochromatic">Monochromatic</SelectItem>
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <FormField
                    control={form.control}
                    name="roomType"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Room Type</FormLabel>
                        <Select onValueChange={field.onChange} defaultValue={field.value}>
                          <FormControl>
                            <SelectTrigger>
                              <SelectValue placeholder="e.g., Living Room, Kitchen" />
                            </SelectTrigger>
                          </FormControl>
                          <SelectContent>
                            <SelectItem value="Living Room">Living Room</SelectItem>
                            <SelectItem value="Kitchen">Kitchen</SelectItem>
                            <SelectItem value="Bedroom">Bedroom</SelectItem>
                            <SelectItem value="Dining Room">Dining Room</SelectItem>
                            <SelectItem value="Home Office">Home Office</SelectItem>
                          </SelectContent>
                        </Select>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <Button type="submit" className="w-full" size="lg" disabled={isLoading}>
                    {isLoading ? 'Generating...' : 'Get Inspiration'}
                  </Button>
                </form>
              </Form>
            </CardContent>
          </Card>

          <div className="flex items-center justify-center">
            {isLoading && (
              <Card className="w-full shadow-lg">
                <CardHeader>
                  <Skeleton className="h-8 w-3/4" />
                </CardHeader>
                <CardContent className="space-y-4">
                  <Skeleton className="w-full aspect-video rounded-lg" />
                  <Skeleton className="h-4 w-full" />
                  <Skeleton className="h-4 w-full" />
                  <Skeleton className="h-4 w-5/6" />
                </CardContent>
              </Card>
            )}
            {!isLoading && inspiration && (
              <Card className="w-full shadow-lg animate-fade-in-up">
                <CardHeader>
                  <CardTitle className="text-2xl">Your AI-Generated Design</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="relative w-full aspect-video mb-4 overflow-hidden rounded-lg">
                    <Image src={inspiration.imageUri} alt="AI generated design" layout="fill" objectFit="cover" />
                  </div>
                  <p className="text-muted-foreground">{inspiration.designDescription}</p>
                </CardContent>
              </Card>
            )}
            {!isLoading && !inspiration && (
               <Alert>
                 <Lightbulb className="h-4 w-4" />
                 <AlertTitle>Ready for Inspiration?</AlertTitle>
                 <AlertDescription>
                   Your personalized design concept will appear here once you fill out the form.
                 </AlertDescription>
               </Alert>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
