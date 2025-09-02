
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { createClient } from '@/lib/supabase/server';
import { FilePlus, MoreVertical, Pencil, Trash2, Facebook, Instagram, Twitter, Youtube, LucideProps } from 'lucide-react';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import Link from 'next/link';

const iconMap: { [key: string]: React.FC<LucideProps> } = {
    Facebook,
    Twitter,
    Instagram,
    Youtube,
};

async function getSocialLinks() {
    const supabase = createClient();
    const { data, error } = await supabase.from('social_links').select('*').order('name');
    if (error) {
        console.error('Error fetching social links:', error);
        return [];
    }
    return data;
}

export default async function SocialLinksPage() {
    const links = await getSocialLinks();

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Social Links</h1>
                 <Button asChild disabled>
                    <Link href="#">
                        <FilePlus className="w-5 h-5 mr-2" />
                        Add New Link
                    </Link>
                </Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Your Social Media Links</CardTitle>
                </CardHeader>
                <CardContent>
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>Icon</TableHead>
                                <TableHead>Name</TableHead>
                                <TableHead>URL</TableHead>
                                <TableHead className="text-right">Actions</TableHead>
                            </TableRow>
                        </TableHeader>
                        <TableBody>
                            {links.map((link) => {
                                const Icon = iconMap[link.icon as string];
                                return (
                                <TableRow key={link.id}>
                                    <TableCell>
                                        {Icon && <Icon className="h-6 w-6" />}
                                    </TableCell>
                                    <TableCell className="font-medium">{link.name}</TableCell>
                                    <TableCell>{link.url}</TableCell>
                                    <TableCell className="text-right">
                                        <DropdownMenu>
                                            <DropdownMenuTrigger asChild>
                                                <Button variant="ghost" size="icon">
                                                    <MoreVertical className="h-4 w-4" />
                                                </Button>
                                            </DropdownMenuTrigger>
                                            <DropdownMenuContent align="end">
                                                <DropdownMenuItem disabled>
                                                    <Pencil className="mr-2 h-4 w-4" />
                                                    <span>Edit</span>
                                                </DropdownMenuItem>
                                                <DropdownMenuItem className="text-destructive" disabled>
                                                    <Trash2 className="mr-2 h-4 w-4" />
                                                    <span>Delete</span>
                                                </DropdownMenuItem>
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
