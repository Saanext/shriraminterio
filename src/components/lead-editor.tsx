
'use client';

import { useRouter } from 'next/navigation';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useToast } from '@/hooks/use-toast';
import { createLead } from './lead-actions';
import { Textarea } from './ui/textarea';
import { Checkbox } from './ui/checkbox';

const serviceOptions = [
    { id: 'tv-unit', label: 'TV Unit' },
    { id: 'sofa', label: 'Sofa' },
    { id: 'kitchen-unit', label: 'Kitchen Unit' },
    { id: 'loft', label: 'Loft' },
    { id: 'pooja-unit', label: 'Pooja Unit' },
    { id: 'wardrobe', label: 'Wardrobe' },
    { id: 'study-table', label: 'Study Table' },
    { id: 'bed', label: 'Bed' },
    { id: 'dressing-unit', label: 'Dressing Unit' },
    { id: 'pop', label: 'POP' },
];

const leadSchema = z.object({
  name: z.string().min(1, 'Name is required'),
  email: z.string().email('Invalid email address').optional().or(z.literal('')),
  mobile: z.string().min(10, 'Mobile number is required'),
  services: z.array(z.string()).optional(),
  message: z.string().optional(),
  assigned_to_id: z.string().uuid().optional().nullable(),
});

type LeadFormValues = z.infer<typeof leadSchema>;

type SalesPerson = {
    id: string;
    name: string;
}

export function LeadEditor({ salesPersons }: { salesPersons: SalesPerson[] }) {
  const router = useRouter();
  const { toast } = useToast();
  const form = useForm<LeadFormValues>({
    resolver: zodResolver(leadSchema),
    defaultValues: {
      name: '',
      email: '',
      mobile: '',
      services: [],
      message: '',
      assigned_to_id: null,
    },
  });

  const onSubmit = async (values: LeadFormValues) => {
    const result = await createLead(values);
    if (result.success) {
      toast({
        title: 'Lead Created!',
        description: `The lead for "${values.name}" has been successfully created.`,
      });
      router.push('/shriramadmin/leads');
      router.refresh();
    } else {
      toast({
        title: 'Error',
        description: result.error,
        variant: 'destructive',
      });
    }
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-3xl font-bold">Add New Lead</h1>
        <Button onClick={form.handleSubmit(onSubmit)} disabled={form.formState.isSubmitting}>
          {form.formState.isSubmitting ? 'Creating...' : 'Create Lead'}
        </Button>
      </div>

      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
          <Card>
            <CardHeader>
              <CardTitle>Lead Details</CardTitle>
              <CardDescription>Enter the details for the new lead.</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <FormField
                    control={form.control}
                    name="name"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel>Name</FormLabel>
                        <FormControl>
                        <Input placeholder="e.g., John Doe" {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />
                <FormField
                    control={form.control}
                    name="mobile"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel>Mobile Number</FormLabel>
                        <FormControl>
                        <Input placeholder="e.g., 9876543210" {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />
                <FormField
                    control={form.control}
                    name="email"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel>Email (Optional)</FormLabel>
                        <FormControl>
                        <Input placeholder="e.g., john.doe@example.com" {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />
                <FormField
                    control={form.control}
                    name="assigned_to_id"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel>Assign to Sales Person</FormLabel>
                        <Select onValueChange={field.onChange} defaultValue={field.value || ""}>
                        <FormControl>
                            <SelectTrigger>
                            <SelectValue placeholder="Select a sales person" />
                            </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                            <SelectItem value="">Unassigned</SelectItem>
                            {salesPersons.map(person => (
                                <SelectItem key={person.id} value={person.id}>{person.name}</SelectItem>
                            ))}
                        </SelectContent>
                        </Select>
                        <FormMessage />
                    </FormItem>
                    )}
                />
              </div>

               <FormField
                control={form.control}
                name="services"
                render={() => (
                    <FormItem>
                        <div className="mb-4">
                            <FormLabel className="text-base">Services Interested In</FormLabel>
                        </div>
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        {serviceOptions.map((item) => (
                            <FormField
                                key={item.id}
                                control={form.control}
                                name="services"
                                render={({ field }) => {
                                    return (
                                        <FormItem
                                            key={item.id}
                                            className="flex flex-row items-center space-x-3 space-y-0"
                                        >
                                            <FormControl>
                                                <Checkbox
                                                    checked={field.value?.includes(item.id)}
                                                    onCheckedChange={(checked) => {
                                                        return checked
                                                            ? field.onChange([...(field.value || []), item.id])
                                                            : field.onChange(
                                                                field.value?.filter(
                                                                    (value) => value !== item.id
                                                                )
                                                            )
                                                    }}
                                                />
                                            </FormControl>
                                            <FormLabel className="font-normal flex items-center text-sm">
                                                {item.label}
                                            </FormLabel>
                                        </FormItem>
                                    )
                                }}
                            />
                        ))}
                        </div>
                        <FormMessage />
                    </FormItem>
                )}
                />

              <FormField
                    control={form.control}
                    name="message"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel>Message / Notes (Optional)</FormLabel>
                        <FormControl>
                         <Textarea placeholder="Any additional notes about the lead..." {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />

            </CardContent>
          </Card>
        </form>
      </Form>
    </div>
  );
}
