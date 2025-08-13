import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { FilePlus, MoreVertical, Pencil, Trash2 } from 'lucide-react';

const sampleProjects = [
    {
        name: 'Modern Minimalist Living',
        category: 'Living Areas',
        date: '2024-05-10',
    },
    {
        name: 'Elegant U-Shaped Kitchen',
        category: 'Kitchens',
        date: '2024-05-15',
    },
    {
        name: 'Sleek Sliding Wardrobe',
        category: 'Wardrobes',
        date: '2024-05-20',
    },
];

export default function ProjectsManagementPage() {
    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Project Management</h1>
                <Button>
                    <FilePlus className="w-5 h-5 mr-2" />
                    Add New Project
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Existing Projects</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Project Name</TableHead>
                                <TableHead>Category</TableHead>
                                <TableHead>Date Added</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {sampleProjects.map((project) => (
                                <TableRow key={project.name}>
                                    <TableCell className="font-medium">{project.name}</TableCell>
                                    <TableCell>{project.category}</TableCell>
                                    <TableCell>{project.date}</TableCell>
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
