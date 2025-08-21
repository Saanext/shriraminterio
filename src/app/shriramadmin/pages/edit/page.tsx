
'use client';

import { useSearchParams } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { NAV_ITEMS } from '@/lib/constants';
import Link from 'next/link';
import { Textarea } from '@/components/ui/textarea';

export default function EditPage() {
    const searchParams = useSearchParams();
    const pageSlug = searchParams.get('page') || '';
    
    const pageData = NAV_ITEMS.find(p => p.href === `/${pageSlug}`);

    if (!pageData) {
        return (
            <div>
                <h1 className="text-3xl font-bold mb-8">Page Not Found</h1>
                <p>The page you are trying to edit does not exist.</p>
                 <Button asChild variant="outline" className="mt-4">
                    <Link href="/shriramadmin/pages">Back to Pages</Link>
                </Button>
            </div>
        )
    }

    return (
        <div>
            <h1 className="text-3xl font-bold mb-8">Edit Page: {pageData.label}</h1>
            <Card>
                <CardHeader>
                    <CardTitle>Page Details</CardTitle>
                    <CardDescription>Update the page title, slug, and content.</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                    <div className="space-y-2">
                        <Label htmlFor="page-title">Page Title</Label>
                        <Input id="page-title" defaultValue={pageData.label} />
                    </div>
                     <div className="space-y-2">
                        <Label htmlFor="page-slug">Slug</Label>
                        <Input id="page-slug" defaultValue={pageData.href} />
                    </div>
                     <div className="space-y-2">
                        <Label htmlFor="page-content">Content</Label>
                        <Textarea id="page-content" rows={15} defaultValue={`This is the current content for the ${pageData.label} page...`} />
                    </div>
                    <div className="flex justify-end gap-4">
                        <Button asChild variant="outline">
                            <Link href="/shriramadmin/pages">Cancel</Link>
                        </Button>
                        <Button>Save Changes</Button>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
