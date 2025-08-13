
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Download, Settings, Trash2 } from 'lucide-react';

const sampleSubmissions = [
    {
        name: 'Rohan Sharma',
        email: 'rohan.sharma@example.com',
        phone: '+91 9876543210',
        service: 'Full Home Interiors',
        date: '2024-06-10',
        floorplan: '2 BHK',
        items: 'Kitchen, Wardrobe',
        purpose: 'New Home'
    },
    {
        name: 'Priya Mehta',
        email: 'priya.mehta@example.com',
        phone: '+91 9876543211',
        service: 'Modular Kitchen',
        date: '2024-06-11',
        floorplan: '3 BHK',
        items: 'Kitchen',
        purpose: 'Renovation'
    },
];

export default function QuoteManagementPage() {
    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">"Get Quote" Form Management</h1>
                <div className="flex gap-2">
                    <Button variant="outline">
                        <Settings className="w-5 h-5 mr-2" />
                        Customize Form
                    </Button>
                    <Button>
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
                                <TableHead>Name</TableHead>
                                <TableHead>Email</TableHead>
                                <TableHead>Phone</TableHead>
                                <TableHead>Floorplan</TableHead>
                                <TableHead>Items</TableHead>
                                <TableHead>Purpose</TableHead>
                                <TableHead>Date</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {sampleSubmissions.map((submission) => (
                                <TableRow key={submission.email}>
                                    <TableCell className="font-medium">{submission.name}</TableCell>
                                    <TableCell>{submission.email}</TableCell>
                                    <TableCell>{submission.phone}</TableCell>
                                    <TableCell>{submission.floorplan}</TableCell>
                                    <TableCell>{submission.items}</TableCell>
                                    <TableCell>{submission.purpose}</TableCell>
                                    <TableCell>{submission.date}</TableCell>
                                    <TableCell className="text-right">
                                        <Button variant="ghost" size="icon">
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
