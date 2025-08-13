import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { FilePlus, MoreVertical, Pencil, Trash2 } from 'lucide-react';

const sampleVideos = [
    {
        title: 'Modern Kitchen Showcase',
        page: 'Modular Kitchens',
        url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        date: '2024-06-01',
    },
    {
        title: 'Living Room Transformation Time-lapse',
        page: 'Living Area Design',
        url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
        date: '2024-06-05',
    },
];

export default function VideoManagementPage() {
    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Video Management</h1>
                <Button>
                    <FilePlus className="w-5 h-5 mr-2" />
                    Add New Video
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Existing Videos</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Video Title</TableHead>
                                <TableHead>Assigned Page</TableHead>
                                <TableHead>URL</TableHead>
                                <TableHead>Date Added</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {sampleVideos.map((video) => (
                                <TableRow key={video.title}>
                                    <TableCell className="font-medium">{video.title}</TableCell>
                                    <TableCell>{video.page}</TableCell>
                                    <TableCell><a href={video.url} target="_blank" rel="noopener noreferrer" className="text-primary hover:underline">View Video</a></TableCell>
                                    <TableCell>{video.date}</TableCell>
                                    <TableCell className="text-right">
                                        <DropdownMenu>
                                            <DropdownMenuTrigger asChild>
                                                <Button variant="ghost" size="icon">
                                                    <MoreVertical className="h-4 w-4" />
                                                </Button>
                                            </DropdownMenuTrigger>
                                            <DropdownMenuContent align="end">
                                                <DropdownMenuItem>
                                                    <Pencil className="mr-2 h-4 w-4" />
                                                    <span>Edit</span>
                                                </DropdownMenuItem>
                                                <DropdownMenuItem className="text-destructive">
                                                    <Trash2 className="mr-2 h-4 w-4" />
                                                    <span>Delete</span>
                                                </DropdownMenuItem>
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
