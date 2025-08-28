
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Download, Settings, Trash2 } from 'lucide-react';
import { createClient } from '@/lib/supabase/server';
import { format } from 'date-fns';

async function getSubmissions() {
    const supabase = createClient();
    const { data, error } = await supabase.from('quotes').select('*').order('created_at', { ascending: false });
    if (error) {
        console.error("Error fetching quotes:", error);
        return [];
    }
    return data;
}


export default async function QuoteManagementPage() {
    const submissions = await getSubmissions();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">"Get Quote" Form Management</h1>
                <div className="flex gap-2">
                    <Button variant="outline" disabled>
                        <Settings className="w-5 h-5 mr-2" />
                        Customize Form
                    </Button>
                    <Button disabled>
                        <Download className="w-5 h-5 mr-2" />
                        Export Submissions
                    </Button>
                </div>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Form Submissions</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Date</TableHead>
                                <TableHead>Name</TableHead>
                                <TableHead>Email</TableHead>
                                <TableHead>Phone</TableHead>
                                <TableHead>Floorplan</TableHead>
                                <TableHead>Purpose</TableHead>
                                <TableHead>Message</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {submissions.map((submission) => (
                                <TableRow key={submission.id}>
                                     <TableCell>{format(new Date(submission.created_at), 'PPP')}</TableCell>
                                    <TableCell className="font-medium">{submission.name}</TableCell>
                                    <TableCell>{submission.email}</TableCell>
                                    <TableCell>{submission.phone}</TableCell>
                                    <TableCell>{submission.floorplan}</TableCell>
                                    <TableCell>{submission.purpose}</TableCell>
                                    <TableCell className="max-w-xs truncate">{submission.message}</TableCell>
                                    <TableCell className="text-right">
                                        <Button variant="ghost" size="icon" disabled>
                                            <Trash2 className="h-4 w-4 text-destructive" />
                                        </Button>
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
