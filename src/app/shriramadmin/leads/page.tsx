
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { FilePlus, MoreVertical, Pencil, Trash2 } from 'lucide-react';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import Link from 'next/link';
import Image from 'next/image';
import { Badge } from '@/components/ui/badge';
import { format } from 'date-fns';
import { LeadStatusBadge } from '@/components/lead-status-badge';
import { LeadDeleteAction } from '@/components/lead-delete-action';

async function getLeads() {
    const supabase = createClient();
    const { data, error } = await supabase.from('leads').select(`
        *,
        sales_persons ( name, profile_image_url )
    `).order('created_at', { ascending: false });

    if (error) {
        console.error('Error fetching leads:', error);
        return [];
    }
    return data;
}

export default async function LeadsPage() {
    const leads = await getLeads();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Leads Management</h1>
                <Button asChild>
                    <Link href="/shriramadmin/leads/new">
                        <FilePlus className="w-5 h-5 mr-2" />
                        Add New Lead
                    </Link>
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>All Leads</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Created</TableHead>
                                <TableHead>Name</TableHead>
                                <TableHead>Contact</TableHead>
                                <TableHead>Status</TableHead>
                                <TableHead>Assigned To</TableHead>
                                <TableHead>Services</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {leads.map((lead: any) => (
                                <TableRow key={lead.id}>
                                    <TableCell>{format(new Date(lead.created_at), 'PPP')}</TableCell>
                                    <TableCell className="font-medium">{lead.name}</TableCell>
                                    <TableCell>
                                        <div>{lead.email}</div>
                                        <div>{lead.mobile}</div>
                                    </TableCell>
                                    <TableCell>
                                        <LeadStatusBadge status={lead.status} />
                                    </TableCell>
                                    <TableCell className="flex items-center gap-2">
                                        {lead.sales_persons ? (
                                            <>
                                                <Image src={lead.sales_persons.profile_image_url || '/user-placeholder.png'} alt={lead.sales_persons.name} width={24} height={24} className="rounded-full" />
                                                <span>{lead.sales_persons.name}</span>
                                            </>
                                        ) : (
                                            <span className="text-muted-foreground">Unassigned</span>
                                        )}
                                    </TableCell>
                                     <TableCell>
                                        <div className="flex flex-wrap gap-1">
                                            {(lead.services || []).map((service: string) => (
                                                <Badge key={service} variant="outline">{service}</Badge>
                                            ))}
                                        </div>
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
                                                    <Link href={`/shriramadmin/leads/edit/${lead.id}`}>
                                                        <Pencil className="mr-2 h-4 w-4" />
                                                        <span>Edit</span>
                                                    </Link>
                                                </DropdownMenuItem>
                                                <LeadDeleteAction leadId={lead.id}>
                                                    <div className="relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 text-destructive">
                                                        <Trash2 className="mr-2 h-4 w-4" />
                                                        <span>Delete</span>
                                                    </div>
                                                </LeadDeleteAction>
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
