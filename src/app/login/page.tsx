
'use client';

import { Suspense } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { Input } from '@/components/ui/input';
import { useToast } from '@/hooks/use-toast';
import { login } from './actions';
import { Shield } from 'lucide-react';
import { useSearchParams } from 'next/navigation';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';

const loginSchema = z.object({
  email: z.string().email('Please enter a valid email address.'),
  password: z.string().min(1, 'Password is required.'),
});

type LoginFormValues = z.infer<typeof loginSchema>;

function LoginFormComponent() {
  const { toast } = useToast();
  const searchParams = useSearchParams();
  const message = searchParams.get('message');
  const router = useRouter();

  const form = useForm<LoginFormValues>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      email: '',
      password: '',
    },
  });

  const onSubmit = async (values: LoginFormValues) => {
    const formData = new FormData();
    formData.append('email', values.email);
    formData.append('password', values.password);

    try {
      await login(formData);
      // The redirect is handled by the server action, but we might want to refresh the router state
      // to ensure the user is navigated correctly if they somehow stay on the page.
      router.refresh();
    } catch (error: any) {
      // The server action now handles redirects internally.
      // We only need to show an error if the action itself throws or returns one.
      // The current implementation returns an object with an error key.
      const result = error; // This isn't quite right. Let's adjust.
    }
  };
  
  const handleFormSubmit = async (values: LoginFormValues) => {
    const formData = new FormData();
    formData.append('email', values.email);
    formData.append('password', values.password);

    const result = await login(formData);

    if (result?.error) {
       toast({
        title: 'Login Failed',
        description: result.error,
        variant: 'destructive',
      });
    }
    // No explicit success handling needed here, as the redirect is handled in the server action.
  }

  return (
    <Card className="w-full max-w-md">
      <CardHeader className="text-center">
        <div className="flex justify-center mb-4">
          <Shield className="w-12 h-12 text-primary" />
        </div>
        <CardTitle className="text-3xl font-bold">Admin Login</CardTitle>
        <CardDescription>Enter your credentials to access the admin panel.</CardDescription>
      </CardHeader>
      <CardContent>
        {message && (
            <Alert variant="destructive" className="mb-4">
              <AlertTitle>Error</AlertTitle>
              <AlertDescription>{message}</AlertDescription>
            </Alert>
        )}
        <Form {...form}>
          <form onSubmit={form.handleSubmit(handleFormSubmit)} className="space-y-6">
            <FormField
              control={form.control}
              name="email"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Email</FormLabel>
                  <FormControl>
                    <Input type="email" placeholder="admin@example.com" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="password"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Password</FormLabel>
                  <FormControl>
                    <Input type="password" placeholder="••••••••" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <Button type="submit" className="w-full" disabled={form.formState.isSubmitting}>
              {form.formState.isSubmitting ? 'Signing In...' : 'Sign In'}
            </Button>
          </form>
        </Form>
      </CardContent>
    </Card>
  )
}


export default function LoginPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-secondary">
      <Suspense fallback={<div>Loading...</div>}>
        <LoginFormComponent />
      </Suspense>
    </div>
  );
}
