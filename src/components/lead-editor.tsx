
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
import { saveLead } from './lead-actions';
import { Textarea } from './ui/textarea';
import { Checkbox } from './ui/checkbox';
import { useEffect } from 'react';
import { X } from 'lucide-react';

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
  id: z.number().optional().nullable(),
  name: z.string().min(1, 'Name is required'),
  email: z.string().email('Invalid email address').optional().or(z.literal('')),
  mobile: z.string().min(10, 'Mobile number is required'),
  services: z.array(z.string()).optional(),
  message: z.string().optional(),
  assigned_to_id: z.number().optional().nullable(),
  status: z.string().min(1, 'Status is required'),
});

type LeadFormValues = z.infer<typeof leadSchema>;

type SalesPerson = {
    id: number;
    name: string;
}

const statusOptions = ['in progress', 'qualified', 'not qualified'];

type LeadEditorProps = {
    initialData?: any;
    salesPersons: SalesPerson[];
}

export function LeadEditor({ initialData, salesPersons }: LeadEditorProps) {
  const router = useRouter();
  const { toast } = useToast();
  const isNew = !initialData;

  const form = useForm<LeadFormValues>({
    resolver: zodResolver(leadSchema),
    defaultValues: {
      id: undefined,
      name: '',
      email: '',
      mobile: '',
      services: [],
      message: '',
      assigned_to_id: undefined,
      status: 'in progress',
    },
  });
  
  useEffect(() => {
    if (initialData) {
      form.reset({
        ...initialData,
        id: initialData.id,
        assigned_to_id: initialData.assigned_to_id || undefined,
        services: initialData.services || [],
      });
    }
  }, [initialData, form]);

  const onSubmit = async (values: LeadFormValues) => {
    const result = await saveLead({ ...values, id: initialData?.id });
    if (result.success) {
      toast({
        title: isNew ? 'Lead Created!' : 'Lead Updated!',
        description: `The lead for "${values.name}" has been successfully saved.`,
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
        <h1 className="text-3xl font-bold">{isNew ? 'Add New Lead' : 'Edit Lead'}</h1>
        <Button onClick={form.handleSubmit(onSubmit)} disabled={form.formState.isSubmitting}>
          {form.formState.isSubmitting ? 'Saving...' : (isNew ? 'Create Lead' : 'Save Changes')}
        </Button>
      </div>

      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
          <Card>
            <CardHeader>
              <CardTitle>Lead Details</CardTitle>
              <CardDescription>Enter the details for the lead.</CardDescription>
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
                        <div className="flex items-center gap-2">
                          <Select 
                            onValueChange={(value) => field.onChange(value === 'unassigned' ? null : parseInt(value, 10))} 
                            value={field.value?.toString() ?? undefined}
                          >
                            <FormControl>
                                <SelectTrigger>
                                  <SelectValue placeholder="Unassigned" />
                                </SelectTrigger>
                            </FormControl>
                            <SelectContent>
                                <SelectItem value="unassigned">Unassigned</SelectItem>
                                {salesPersons.map(person => (
                                    <SelectItem key={person.id} value={person.id.toString()}>{person.name}</SelectItem>
                                ))}
                            </SelectContent>
                          </Select>
                           {field.value && <Button type="button" variant="ghost" size="icon" onClick={() => field.onChange(null)}><X className="h-4 w-4" /></Button>}
                        </div>
                        <FormMessage />
                    </FormItem>
                    )}
                />
                <FormField
                    control={form.control}
                    name="status"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel>Status</FormLabel>
                        <Select onValueChange={field.onChange} value={field.value}>
                        <FormControl>
                            <SelectTrigger>
                            <SelectValue placeholder="Select a status" />
                            </SelectTrigger>
                        </FormControl>
                        <SelectContent>
                            {statusOptions.map(status => (
                                <SelectItem key={status} value={status}>{status}</SelectItem>
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
