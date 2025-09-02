
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { FilePlus, MoreVertical, Pencil, Trash2, Eye, EyeOff } from 'lucide-react';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger, DropdownMenuSeparator } from '@/components/ui/dropdown-menu';
import Link from 'next/link';
import { PageVisibilityToggle } from './PageVisibilityToggle';
import { Badge } from '@/components/ui/badge';

async function getPages() {
    const supabase = createClient();
    const { data: pages, error } = await supabase.from('pages').select('id, title, slug, visible, parent_slug').order('nav_order');
    if (error) {
        console.error('Error fetching pages:', error);
        return [];
    }
    return pages;
}

export default async function PagesManagementPage() {
    const pages = await getPages();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Pages Management</h1>
                 <Button asChild>
                    <Link href="/shriramadmin/pages/new">
                        <FilePlus className="w-5 h-5 mr-2" />
                        Create New Page
                    </Link>
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Existing Pages</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Page Name</TableHead>
                                <TableHead>Path</TableHead>
                                <TableHead>Status</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {pages.map((page) => (
                                <TableRow key={page.id}>
                                    <TableCell className="font-medium">{page.title}</TableCell>
                                    <TableCell>/{page.parent_slug ? `${page.parent_slug}/` : ''}{page.slug === 'home' ? '' : page.slug}</TableCell>
                                    <TableCell>
                                        <Badge variant={page.visible ? 'default' : 'secondary'} className={page.visible ? 'bg-green-500 hover:bg-green-600' : ''}>
                                            {page.visible ? <Eye className="mr-2 h-4 w-4" /> : <EyeOff className="mr-2 h-4 w-4" />}
                                            {page.visible ? 'Visible' : 'Hidden'}
                                        </Badge>
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
                                                    <Link href={`/shriramadmin/pages/edit?page=${page.slug}`}>
                                                        <Pencil className="mr-2 h-4 w-4" />
                                                        <span>Edit</span>
                                                    </Link>
                                                </DropdownMenuItem>
                                                <DropdownMenuItem onSelect={(e) => e.preventDefault()}>
                                                    <PageVisibilityToggle pageId={page.id} isVisible={page.visible}>
                                                        {page.visible ? (
                                                            <><EyeOff className="mr-2 h-4 w-4" /><span>Hide</span></>
                                                        ) : (
                                                            <><Eye className="mr-2 h-4 w-4" /><span>Show</span></>
                                                        )}
                                                    </PageVisibilityToggle>
                                                </DropdownMenuItem>
                                                <DropdownMenuSeparator />
                                                <DropdownMenuItem className="text-destructive" disabled>
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
