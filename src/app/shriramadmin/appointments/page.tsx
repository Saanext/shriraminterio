
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { format } from 'date-fns';
import { Trash2 } from 'lucide-react';
import { Badge } from '@/components/ui/badge';

async function getAppointments() {
    const supabase = createClient();
    const { data, error } = await supabase.from('appointments').select('*').order('created_at', { ascending: false });
    if (error) {
        console.error("Error fetching appointments:", error);
        return [];
    }
    return data;
}

export default async function AppointmentsPage() {
    const appointments = await getAppointments();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Appointment Submissions</h1>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Received Appointments</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Submission Date</TableHead>
                                <TableHead>Name</TableHead>
                                <TableHead>Email</TableHead>
                                <TableHead>Phone</TableHead>
                                <TableHead>Appointment Date</TableHead>
                                <TableHead>Time Slot</TableHead>
                                <TableHead>Purpose</TableHead>
                                <TableHead>Floorplan</TableHead>
                                <TableHead>Services</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {appointments.map((submission) => (
                                <TableRow key={submission.id}>
                                    <TableCell>{format(new Date(submission.created_at), 'PPP')}</TableCell>
                                    <TableCell className="font-medium">{submission.name}</TableCell>
                                    <TableCell>{submission.email}</TableCell>
                                    <TableCell>{submission.phone}</TableCell>
                                    <TableCell>{format(new Date(submission.appointment_date), 'PPP')}</TableCell>
                                    <TableCell>{submission.time_slot}</TableCell>
                                    <TableCell>{submission.purpose}</TableCell>
                                    <TableCell>{submission.floorplan}</TableCell>
                                    <TableCell>
                                        <div className="flex flex-wrap gap-1">
                                            {(submission.services || []).map((service: string) => (
                                                <Badge key={service} variant="secondary">{service}</Badge>
                                            ))}
                                        </div>
                                    </TableCell>
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
