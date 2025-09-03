
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { FilePlus, MoreVertical, Pencil, Trash2 } from 'lucide-react';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import Link from 'next/link';
import Image from 'next/image';
import { SalesPersonDeleteAction } from '@/components/sales-person-delete-action';

async function getSalesPersons() {
    const supabase = createClient();
    const { data, error } = await supabase.from('sales_persons').select('*').order('name');
    if (error) {
        console.error('Error fetching sales persons:', error);
        return [];
    }
    return data;
}

export default async function SalesPersonsPage() {
    const salesPersons = await getSalesPersons();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Sales Persons</h1>
                 <Button asChild>
                    <Link href="/shriramadmin/sales-persons/new">
                        <FilePlus className="w-5 h-5 mr-2" />
                        Add New Person
                    </Link>
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Your Sales Team</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Profile</TableHead>
                                <TableHead>Name</TableHead>
                                <TableHead>Contact Number</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {salesPersons.map((person) => (
                                <TableRow key={person.id}>
                                    <TableCell>
                                        <Image src={person.profile_image_url || '/user-placeholder.png'} alt={person.name} width={40} height={40} className="rounded-full object-cover" />
                                    </TableCell>
                                    <TableCell className="font-medium">{person.name}</TableCell>
                                    <TableCell>{person.contact_number}</TableCell>
                                    <TableCell className="text-right">
                                        <DropdownMenu>
                                            <DropdownMenuTrigger asChild>
                                                <Button variant="ghost" size="icon">
                                                    <MoreVertical className="h-4 w-4" />
                                                </Button>
                                            </DropdownMenuTrigger>
                                            <DropdownMenuContent align="end">
                                                <DropdownMenuItem asChild>
                                                    <Link href={`/shriramadmin/sales-persons/edit/${person.slug}`}>
                                                        <Pencil className="mr-2 h-4 w-4" />
                                                        <span>Edit</span>
                                                    </Link>
                                                </DropdownMenuItem>
                                                <SalesPersonDeleteAction personId={person.id}>
                                                    <div className="relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 text-destructive">
                                                         <Trash2 className="mr-2 h-4 w-4" />
                                                         <span>Delete</span>
                                                    </div>
                                                </SalesPersonDeleteAction>
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
