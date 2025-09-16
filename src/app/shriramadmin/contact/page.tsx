
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { FilePlus, MoreVertical, Pencil, Trash2, LucideProps, MapPin, Mail, Phone } from 'lucide-react';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import Link from 'next/link';
import { ContactDetailDeleteAction } from '@/components/contact-detail-delete-action';

const iconMap: { [key: string]: React.FC<LucideProps> } = {
    MapPin,
    Mail,
    Phone,
};

async function getContactDetails() {
    const supabase = createClient();
    const { data, error } = await supabase.from('contact_details').select('*').order('name');
    if (error) {
        console.error('Error fetching contact details:', error);
        return [];
    }
    return data;
}

export default async function ContactDetailsPage() {
    const details = await getContactDetails();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Contact Details</h1>
                 <Button asChild>
                    <Link href="/shriramadmin/contact/new">
                        <FilePlus className="w-5 h-5 mr-2" />
                        Add New Detail
                    </Link>
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Your Contact Information</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Icon</TableHead>
                                <TableHead>Name</TableHead>
                                <TableHead>Value</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {details.map((detail) => {
                                const Icon = detail.icon ? iconMap[detail.icon] : null;
                                return (
                                <TableRow key={detail.id}>
                                    <TableCell>
                                        {Icon && <Icon className="h-6 w-6" />}
                                    </TableCell>
                                    <TableCell className="font-medium">{detail.name}</TableCell>
                                    <TableCell>{detail.value}</TableCell>
                                    <TableCell className="text-right">
                                        <DropdownMenu>
                                            <DropdownMenuTrigger asChild>
                                                <Button variant="ghost" size="icon">
                                                    <MoreVertical className="h-4 w-4" />
                                                </Button>
                                            </DropdownMenuTrigger>
                                            <DropdownMenuContent align="end">
                                                <DropdownMenuItem asChild>
                                                    <Link href={`/shriramadmin/contact/edit/${detail.slug}`}>
                                                        <Pencil className="mr-2 h-4 w-4" />
                                                        <span>Edit</span>
                                                    </Link>
                                                </DropdownMenuItem>
                                                <ContactDetailDeleteAction detailId={detail.id}>
                                                    <div className="relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 text-destructive">
                                                        <Trash2 className="mr-2 h-4 w-4" />
                                                        <span>Delete</span>
                                                    </div>
                                                </ContactDetailDeleteAction>
                                            </DropdownMenuContent>
                                        </DropdownMenu>
                                    </TableCell>
                                </TableRow>
                            )})}
                        </TableBody>
                    </Table>
                </CardContent>
            </Card>
        </div>
    );
}
