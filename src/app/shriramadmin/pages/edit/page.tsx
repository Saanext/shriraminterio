

'use client';

import { Suspense, useState, useRef, useEffect } from 'react';
import { useSearchParams } from 'next/navigation';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { NAV_ITEMS } from '@/lib/constants';
import Link from 'next/link';
import { Textarea } from '@/components/ui/textarea';
import { Upload, Eye, EyeOff } from 'lucide-react';
import { Switch } from '@/components/ui/switch';
import { useToast } from '@/hooks/use-toast';
import { savePageContent } from './actions';
import { Skeleton } from '@/components/ui/skeleton';

function EditPageImpl() {
    const { toast } = useToast();
    const searchParams = useSearchParams();
    const pageSlug = searchParams.get('page') || '';
    
    const [pageStructure, setPageStructure] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    const fetchStructure = async () => {
      try {
          setLoading(true);
          const response = await fetch('/api/get-page-structure');
          if (!response.ok) {
              throw new Error('Failed to fetch page structure');
          }
          const structure = await response.json();
          setPageStructure(structure);
      } catch (error) {
          console.error(error);
          toast({
              title: "Error",
              description: "Could not load page structure. Please try again.",
              variant: 'destructive'
          });
      } finally {
          setLoading(false);
      }
    }

    useEffect(() => {
      fetchStructure();
    }, [pageSlug, toast]);


    const allNavItems = [...NAV_ITEMS, ...NAV_ITEMS.flatMap(item => item.subItems || [])];
    
    let pageKey = `/${pageSlug}`;
    if (pageSlug.startsWith('products/')) {
        pageKey = `/${pageSlug}`;
    } else if (pageSlug.startsWith('customer-stories/')) {
        pageKey = `/${pageSlug}`;
    }

    const structureKey = pageKey.substring(1).replace(/-/g, '_') || 'home';
    const structure = pageStructure ? (pageStructure as any)[structureKey] : null;
    const pageData = allNavItems.find(p => p.href === pageKey);

    const title = structure?.title || pageData?.label || "Page"
    
    const formRef = useRef<HTMLFormElement>(null);

    const handleSaveChanges = async (event: React.MouseEvent<HTMLButtonElement>) => {
        event.preventDefault();
        
        if (!formRef.current) return;

        const formData = new FormData(formRef.current);
        const data = Object.fromEntries(formData.entries());

        const result = await savePageContent(pageSlug, data);
        
        if (result.success) {
            toast({
                title: "Changes Saved!",
                description: "Your page content has been successfully updated.",
            });
            // Refetch data to show the latest saved content in the form
            fetchStructure();
        } else {
             toast({
                title: "Error",
                description: result.error || "There was an error saving the content.",
                variant: 'destructive'
            });
        }
    };

    if (loading) {
        return (
             <div>
                <div className="flex justify-between items-center mb-8">
                     <Skeleton className="h-9 w-64" />
                    <div className="flex gap-4">
                        <Skeleton className="h-10 w-24" />
                        <Skeleton className="h-10 w-32" />
                    </div>
                </div>
                <div className="space-y-8">
                    <Card>
                        <CardHeader>
                            <Skeleton className="h-6 w-48" />
                            <Skeleton className="h-4 w-80 mt-2" />
                        </CardHeader>
                        <CardContent className="space-y-6">
                            <Skeleton className="h-10 w-full" />
                            <Skeleton className="h-20 w-full" />
                        </CardContent>
                    </Card>
                     <Card>
                        <CardHeader>
                            <Skeleton className="h-6 w-48" />
                            <Skeleton className="h-4 w-80 mt-2" />
                        </CardHeader>
                        <CardContent className="space-y-6">
                            <Skeleton className="h-10 w-full" />
                            <Skeleton className="h-20 w-full" />
                        </CardContent>
                    </Card>
                </div>
            </div>
        )
    }


    if (!structure && !pageData) {
        return (
            <div>
                <h1 className="text-3xl font-bold mb-8">Page Not Found</h1>
                <p>The page you are trying to edit does not exist or has no editable structure.</p>
                 <Button asChild variant="outline" className="mt-4">
                    <Link href="/shriramadmin/pages">Back to Pages</Link>
                </Button>
            </div>
        )
    }
    
    const renderField = (field: any, fieldKey: string, parents: string[] = []) => {
        const id = [...parents, fieldKey].join('-');
        const name = [...parents, fieldKey].join('.');
        
        switch(field.type) {
            case 'text':
                return <Input name={name} id={id} defaultValue={field.value} />;
            case 'textarea':
                return <Textarea name={name} id={id} defaultValue={field.value} rows={5}/>;
            case 'image':
                return (
                    <div className="flex items-center gap-4">
                        <img src={field.value} alt={field.label} className="w-20 h-20 object-cover rounded-md border" />
                        <Input type="hidden" name={`${name}-value`} defaultValue={field.value} />
                         <Input type="file" name={`${name}-file`} id={id} className="max-w-xs"/>
                        <Button variant="outline" type="button">
                            <Upload className="mr-2 h-4 w-4"/>
                            Change Image
                        </Button>
                    </div>
                );
            case 'repeater':
                return (
                     <div className="space-y-4 p-4 border rounded-md">
                        {field.items.map((item: any, itemIndex: number) => (
                           <Card key={itemIndex} className="p-4 bg-muted/50">
                             <CardContent className="space-y-4 p-0">
                                {Object.keys(item).map(itemKey => (
                                     <div key={itemKey} className="space-y-2">
                                        <Label htmlFor={`${id}-${itemIndex}-${itemKey}`}>{itemKey.charAt(0).toUpperCase() + itemKey.slice(1)}</Label>
                                        <Input name={`${name}.${itemIndex}.${itemKey}`} id={`${id}-${itemIndex}-${itemKey}`} defaultValue={item[itemKey]} />
                                    </div>
                                ))}
                             </CardContent>
                           </Card>
                        ))}
                         <Button variant="outline" size="sm" type="button">Add New</Button>
                    </div>
                );
            default:
                return null;
        }
    }

    return (
        <div>
            <form ref={formRef}>
                <div className="flex justify-between items-center mb-8">
                     <h1 className="text-3xl font-bold">Edit Page: {title}</h1>
                    <div className="flex gap-4">
                        <Button variant="outline" type="button">Preview</Button>
                        <Button onClick={handleSaveChanges}>Save Changes</Button>
                    </div>
                </div>

                <div className="space-y-8">
                     <Card>
                        <CardHeader>
                            <CardTitle>Page Settings</CardTitle>
                            <CardDescription>Manage SEO settings and page metadata.</CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-6">
                             <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div className="space-y-2">
                                    <Label htmlFor="page-title">Page Title</Label>
                                    <Input id="page-title" name="meta.title" defaultValue={pageData?.label || title} />
                                </div>
                                 <div className="space-y-2">
                                    <Label htmlFor="page-slug">Slug</Label>
                                    <Input id="page-slug" name="meta.slug" defaultValue={pageData?.href || `/${pageSlug}`} />
                                </div>
                            </div>
                            <div className="space-y-2">
                                <Label htmlFor="meta-title">Meta Title</Label>
                                <Input id="meta-title" name="meta.metaTitle" defaultValue={structure?.metaTitle} />
                            </div>
                            <div className="space-y-2">
                                <Label htmlFor="meta-description">Meta Description</Label>
                                <Textarea id="meta-description" name="meta.metaDescription" defaultValue={structure?.metaDescription} rows={3} />
                            </div>
                        </CardContent>
                    </Card>

                    {structure ? structure.sections.map((section: any, index: number) => (
                        <Card key={index}>
                            <CardHeader className="flex flex-row items-center justify-between">
                                <div>
                                    <CardTitle>{section.title}</CardTitle>
                                    {section.fields && <CardDescription>Edit the content for this section.</CardDescription>}
                                </div>
                                <div className="flex items-center gap-2">
                                    <Label htmlFor={`sections-${index}-visible`} className="text-sm text-muted-foreground">
                                        {section.visible ? <Eye className="h-5 w-5" /> : <EyeOff className="h-5 w-5" />}
                                    </Label>
                                    <Switch name={`sections.${index}.visible`} id={`sections-${index}-visible`} defaultChecked={section.visible} />
                                </div>
                            </CardHeader>
                             {section.fields && (
                                <CardContent className="space-y-6">
                                    {Object.entries(section.fields).map(([key, field]: [string, any]) => (
                                        <div key={key} className="space-y-2">
                                            <Label htmlFor={`sections-${index}-fields-${key}`}>{field.label}</Label>
                                            {renderField(field, key, ['sections', `${index}`, 'fields'])}
                                        </div>
                                    ))}
                                </CardContent>
                             )}
                        </Card>
                    )) : (
                         <Card>
                            <CardHeader>
                                <CardTitle>Page Content</CardTitle>
                                <CardDescription>This page does not have a structured editor yet.</CardDescription>
                            </CardHeader>
                            <CardContent>
                                <Textarea rows={15} placeholder="Raw content can be edited here." />
                            </CardContent>
                        </Card>
                    )}
                </div>
            </form>
        </div>
    );
}

export default function EditPage() {
    return (
        <Suspense fallback={<div>Loading...</div>}>
            <EditPageImpl />
        </Suspense>
    )
}
