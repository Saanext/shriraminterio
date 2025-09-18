
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { FilePlus, MoreVertical, Pencil, Trash2, Star } from 'lucide-react';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import Link from 'next/link';
import Image from 'next/image';
import { Badge } from '@/components/ui/badge';
import { TestimonialDeleteAction } from '@/components/testimonial-delete-action';

async function getTestimonials() {
    const supabase = createClient();
    const { data, error } = await supabase.from('testimonials').select('*').order('created_at', { ascending: false });
    if (error) {
        console.error('Error fetching testimonials:', error);
        return [];
    }
    return data;
}

export default async function TestimonialsManagementPage() {
    const testimonials = await getTestimonials();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Testimonials Management</h1>
                <Button asChild>
                    <Link href="/shriramadmin/testimonials/new">
                        <FilePlus className="w-5 h-5 mr-2" />
                        Add New Testimonial
                    </Link>
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Existing Testimonials</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Client</TableHead>
                                <TableHead>Quote</TableHead>
                                <TableHead>Location</TableHead>
                                <TableHead>Project</TableHead>
                                <TableHead>Featured</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {testimonials.map((item) => (
                                <TableRow key={item.id}>
                                    <TableCell className="font-medium flex items-center gap-3">
                                        <Image src={item.client_image_url || '/user-placeholder.png'} alt={item.client_name} width={40} height={40} className="rounded-full object-cover" />
                                        {item.client_name}
                                    </TableCell>
                                    <TableCell className="max-w-xs truncate">{item.quote}</TableCell>
                                    <TableCell>{item.location}</TableCell>
                                    <TableCell>{item.project_type}</TableCell>
                                    <TableCell>
                                        {item.is_featured && <Badge><Star className="w-3 h-3 mr-1" /> Featured</Badge>}
                                    </TableCell>
                                    <TableCell className="text-right">
                                        <DropdownMenu>
                                            <DropdownMenuTrigger asChild>
                                                <Button variant="ghost" size="icon">
                                                    <MoreVertical className="h-4 w-4" />
                                                </Button>
                                            </DropdownMenuTrigger>
                                            <DropdownMenuContent align="end">
                                                <DropdownMenuItem asChild>
                                                    <Link href={`/shriramadmin/testimonials/edit/${item.id}`}>
                                                        <Pencil className="mr-2 h-4 w-4" />
                                                        <span>Edit</span>
                                                    </Link>
                                                </DropdownMenuItem>
                                                <TestimonialDeleteAction testimonialId={item.id}>
                                                    <div className="relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 text-destructive">
                                                        <Trash2 className="mr-2 h-4 w-4" />
                                                        <span>Delete</span>
                                                    </div>
                                                </TestimonialDeleteAction>
                                            </DropdownMenuContent>
                                        </DropdownMenu>
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </CardContent>
            </Card>
        </div>
    );
}
