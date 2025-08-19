'use client';

import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import * as z from "zod";
import { format } from "date-fns";
import { CalendarIcon, User, Mail, Phone, Home, Building, Wrench, ArrowRight, ArrowLeft } from "lucide-react";
import { cn } from "@/lib/utils";
import { useState } from 'react';

import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Checkbox } from "@/components/ui/checkbox";
import { Textarea } from "@/components/ui/textarea";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Calendar } from "@/components/ui/calendar";
import { useToast } from "@/hooks/use-toast";
import { Card, CardContent } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";

const formSchema = z.object({
  name: z.string().min(2, { message: "Name must be at least 2 characters." }),
  email: z.string().email({ message: "Please enter a valid email address." }),
  phone: z.string().min(10, { message: "Phone number must be at least 10 digits." }),
  appointmentDate: z.date({ required_error: "An appointment date is required." }),
  timeSlot: z.string({ required_error: "Please select a time slot." }),
  floorplan: z.string({ required_error: "Please select a floorplan." }),
  items: z.array(z.string()).refine(value => value.some(item => item), {
    message: "You have to select at least one item.",
  }),
  purpose: z.string({ required_error: "Please select a purpose." }),
  message: z.string().optional(),
});

const formItems = [
    { id: "kitchen", label: "Kitchen" },
    { id: "bed", label: "Bed" },
    { id: "wardrobe", label: "Wardrobe" },
    { id: "studyUnit", label: "Study Unit" },
    { id: "entertainmentUnit", label: "Entertainment Unit" },
    { id: "crockeryUnit", label: "Crockery Unit" },
];

const purposeOptions = [
    { id: "new-home", label: "New Home Interior", icon: <Home className="h-8 w-8 mb-2" /> },
    { id: "renovation", label: "Renovation", icon: <Wrench className="h-8 w-8 mb-2" /> },
    { id: "commercial", label: "Commercial Space", icon: <Building className="h-8 w-8 mb-2" /> },
];

const floorplanOptions = [
    { id: "1bhk", label: "1 BHK" },
    { id: "2bhk", label: "2 BHK" },
    { id: "3bhk", label: "3 BHK" },
    { id: "4bhk+", label: "4 BHK+" },
    { id: "other", label: "Other" },
];

const timeSlots = [
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 01:00 PM",
    "02:00 PM - 03:00 PM",
    "03:00 PM - 04:00 PM",
    "04:00 PM - 05:00 PM",
]

const totalSteps = 6;

export function AppointmentForm() {
    const { toast } = useToast();
    const [currentStep, setCurrentStep] = useState(1);

    const form = useForm<z.infer<typeof formSchema>>({
        resolver: zodResolver(formSchema),
        defaultValues: {
            name: "",
            email: "",
            phone: "",
            items: [],
        },
    });

    const nextStep = async () => {
        let fieldsToValidate: (keyof z.infer<typeof formSchema>)[] = [];
        switch (currentStep) {
            case 1: fieldsToValidate = ['purpose']; break;
            case 2: fieldsToValidate = ['items']; break;
            case 3: fieldsToValidate = ['floorplan']; break;
            case 4: fieldsToValidate = ['name', 'email', 'phone']; break;
            case 5: fieldsToValidate = ['appointmentDate', 'timeSlot']; break;
        }

        const isValid = await form.trigger(fieldsToValidate);
        if (isValid) {
            setCurrentStep(prev => prev + 1);
        }
    };
    const prevStep = () => setCurrentStep(prev => prev - 1);

    function onSubmit(values: z.infer<typeof formSchema>) {
        console.log(values);
        setCurrentStep(prev => prev + 1);
        toast({
            title: "Appointment Request Submitted!",
            description: "Thank you! We'll be in touch shortly to confirm.",
        });
    }
    
    const progress = (currentStep / totalSteps) * 100;

    return (
        <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8 mt-6">
                <Progress value={progress} className="w-full" />
                
                {currentStep === 1 && (
                    <FormField
                        control={form.control}
                        name="purpose"
                        render={({ field }) => (
                            <FormItem className="space-y-4">
                                <FormLabel className="text-xl font-bold">What is the purpose of your consultation?</FormLabel>
                                <FormControl>
                                    <RadioGroup
                                        onValueChange={field.onChange}
                                        defaultValue={field.value}
                                        className="grid grid-cols-1 md:grid-cols-3 gap-4 pt-4"
                                    >
                                        {purposeOptions.map(option => (
                                            <FormItem key={option.id}>
                                                <FormControl>
                                                    <RadioGroupItem value={option.id} className="sr-only" />
                                                </FormControl>
                                                <FormLabel className={cn(
                                                    "flex flex-col items-center justify-center rounded-md border-2 border-muted bg-popover p-4 hover:bg-accent hover:text-accent-foreground cursor-pointer",
                                                    field.value === option.id && "border-primary"
                                                )}>
                                                    {option.icon}
                                                    {option.label}
                                                </FormLabel>
                                            </FormItem>
                                        ))}
                                    </RadioGroup>
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />
                )}
                
                {currentStep === 2 && (
                    <FormField
                        control={form.control}
                        name="items"
                        render={() => (
                            <FormItem>
                                <div className="mb-4">
                                    <FormLabel className="text-xl font-bold">What are you looking to furnish?</FormLabel>
                                    <p className="text-muted-foreground">Select all that apply.</p>
                                </div>
                                <div className="grid grid-cols-2 md:grid-cols-3 gap-4 pt-4">
                                {formItems.map((item) => (
                                    <FormField
                                        key={item.id}
                                        control={form.control}
                                        name="items"
                                        render={({ field }) => (
                                            <FormItem key={item.id} className="flex flex-row items-center space-x-3 space-y-0">
                                                <FormControl>
                                                    <Checkbox
                                                        checked={field.value?.includes(item.id)}
                                                        onCheckedChange={(checked) => {
                                                            const updatedValue = checked
                                                                ? [...(field.value || []), item.id]
                                                                : field.value?.filter(v => v !== item.id);
                                                            field.onChange(updatedValue);
                                                        }}
                                                    />
                                                </FormControl>
                                                <FormLabel className="font-normal text-base">{item.label}</FormLabel>
                                            </FormItem>
                                        )}
                                    />
                                    ))}
                                </div>
                                <FormMessage />
                            </FormItem>
                        )}
                    />
                )}

                {currentStep === 3 && (
                     <FormField
                        control={form.control}
                        name="floorplan"
                        render={({ field }) => (
                            <FormItem className="space-y-4">
                                <FormLabel className="text-xl font-bold">What is your floor plan?</FormLabel>
                                <FormControl>
                                     <RadioGroup
                                        onValueChange={field.onChange}
                                        defaultValue={field.value}
                                        className="flex flex-col space-y-1"
                                    >
                                        {floorplanOptions.map(option => (
                                        <FormItem key={option.id} className="flex items-center space-x-3 space-y-0">
                                            <FormControl>
                                                <RadioGroupItem value={option.id} />
                                            </FormControl>
                                            <FormLabel className="font-normal text-base">{option.label}</FormLabel>
                                        </FormItem>
                                        ))}
                                    </RadioGroup>
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}
                    />
                )}

                {currentStep === 4 && (
                    <div className="space-y-4">
                        <h2 className="text-xl font-bold">Please provide your contact details</h2>
                        <FormField control={form.control} name="name" render={({ field }) => (
                            <FormItem>
                                <FormLabel>Name</FormLabel>
                                <FormControl>
                                    <Input placeholder="Your Name" {...field} />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}/>
                        <FormField control={form.control} name="email" render={({ field }) => (
                            <FormItem>
                                <FormLabel>Email</FormLabel>
                                <FormControl>
                                    <Input placeholder="your.email@example.com" {...field} />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}/>
                        <FormField control={form.control} name="phone" render={({ field }) => (
                            <FormItem>
                                <FormLabel>Phone</FormLabel>
                                <FormControl>
                                    <Input placeholder="+91 12345 67890" {...field} />
                                </FormControl>
                                <FormMessage />
                            </FormItem>
                        )}/>
                    </div>
                )}
                
                {currentStep === 5 && (
                    <div className="space-y-4">
                        <h2 className="text-xl font-bold">Schedule your consultation</h2>
                        <FormField
                            control={form.control}
                            name="appointmentDate"
                            render={({ field }) => (
                                <FormItem className="flex flex-col">
                                    <FormLabel>Select a Date</FormLabel>
                                    <Popover>
                                        <PopoverTrigger asChild>
                                            <FormControl>
                                                <Button variant={"outline"} className={cn("w-full pl-3 text-left font-normal", !field.value && "text-muted-foreground")}>
                                                    {field.value ? format(field.value, "PPP") : <span>Pick a date</span>}
                                                    <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                                                </Button>
                                            </FormControl>
                                        </PopoverTrigger>
                                        <PopoverContent className="w-auto p-0" align="start">
                                            <Calendar mode="single" selected={field.value} onSelect={field.onChange} disabled={(date) => date < new Date(new Date().setDate(new Date().getDate() - 1))} initialFocus />
                                        </PopoverContent>
                                    </Popover>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                         <FormField
                            control={form.control}
                            name="timeSlot"
                            render={({ field }) => (
                                <FormItem className="space-y-2">
                                <FormLabel>Select a Time Slot</FormLabel>
                                 <FormControl>
                                    <RadioGroup
                                        onValueChange={field.onChange}
                                        defaultValue={field.value}
                                        className="grid grid-cols-2 gap-4"
                                    >
                                        {timeSlots.map(slot => (
                                        <FormItem key={slot}>
                                            <FormControl>
                                                <RadioGroupItem value={slot} className="sr-only" />
                                            </FormControl>
                                            <FormLabel className={cn(
                                                "flex items-center justify-center rounded-md border-2 border-muted bg-popover p-3 hover:bg-accent hover:text-accent-foreground cursor-pointer text-sm",
                                                field.value === slot && "border-primary"
                                            )}>
                                                {slot}
                                            </FormLabel>
                                        </FormItem>
                                        ))}
                                    </RadioGroup>
                                 </FormControl>
                                <FormMessage />
                                </FormItem>
                            )}
                        />
                        <FormField
                            control={form.control}
                            name="message"
                            render={({ field }) => (
                                <FormItem>
                                    <FormLabel>Additional Message (Optional)</FormLabel>
                                    <FormControl>
                                        <Textarea placeholder="Anything else you'd like to share?" {...field} />
                                    </FormControl>
                                    <FormMessage />
                                </FormItem>
                            )}
                        />
                    </div>
                )}
                 {currentStep === 6 && (
                    <div className="text-center py-12">
                        <h2 className="text-2xl font-bold text-primary mb-4">Thank You!</h2>
                        <p className="text-lg text-muted-foreground">Your appointment request has been submitted successfully.</p>
                        <p className="text-muted-foreground">We will contact you shortly to confirm the details.</p>
                        <Button onClick={() => { form.reset(); setCurrentStep(1); }} className="mt-8">Book Another Appointment</Button>
                    </div>
                )}


                <div className="flex justify-between pt-4">
                    {currentStep > 1 && currentStep <= totalSteps -1 && (
                        <Button type="button" variant="outline" onClick={prevStep}>
                            <ArrowLeft className="mr-2 h-4 w-4" /> Previous
                        </Button>
                    )}
                    <div />
                    {currentStep < totalSteps -1 && (
                        <Button type="button" onClick={nextStep}>
                            Next <ArrowRight className="ml-2 h-4 w-4" />
                        </Button>
                    )}
                    {currentStep === totalSteps -1 && (
                        <Button type="submit" size="lg" className="w-full">
                            Book Appointment
                        </Button>
                    )}
                </div>
            </form>
        </Form>
    );
}
