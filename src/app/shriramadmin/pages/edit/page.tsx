
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
import { createClient } from '@/lib/supabase/client';

function EditPageImpl() {
    const { toast } = useToast();
    const searchParams = useSearchParams();
    const pageSlug = searchParams.get('page') || 'home';
    
    const [pageData, setPageData] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [sections, setSections] = useState<any[]>([]);

    const fetchPageData = async () => {
        setLoading(true);
        const supabase = createClient();
        const { data, error } = await supabase
            .from('pages')
            .select('*, sections(*)')
            .eq('slug', pageSlug)
            .single();

        if (error || !data) {
            console.error('Error fetching page data:', error);
            toast({
                title: "Error",
                description: "Could not load page data. Please try again.",
                variant: 'destructive'
            });
            setPageData(null);
            setSections([]);
        } else {
            setPageData(data);
            setSections(data.sections.sort((a, b) => a.order - b.order));
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchPageData();
    }, [pageSlug, toast]);

    const handleFieldChange = (sectionIndex: number, fieldKey: string, value: any) => {
        const newSections = [...sections];
        newSections[sectionIndex].content[fieldKey] = value;
        setSections(newSections);
    };
    
    const handleRepeaterChange = (sectionIndex: number, fieldKey: string, itemIndex: number, itemFieldKey: string, value: any) => {
        const newSections = [...sections];
        newSections[sectionIndex].content[fieldKey][itemIndex][itemFieldKey] = value;
        setSections(newSections);
    }
    
    const handleVisibilityChange = (sectionIndex: number, checked: boolean) => {
        const newSections = [...sections];
        newSections[sectionIndex].visible = checked;
        setSections(newSections);
    };

    const handleSaveChanges = async (event: React.MouseEvent<HTMLButtonElement>) => {
        event.preventDefault();
        
        const result = await savePageContent(pageSlug, sections);
        
        if (result.success) {
            toast({
                title: "Changes Saved!",
                description: "Your page content has been successfully updated.",
            });
            fetchPageData();
        } else {
             toast({
                title: "Error",
                description: result.error || "There was an error saving the content.",
                variant: 'destructive'
            });
        }
    };
    
    const renderField = (sectionIndex: number, fieldKey: string, field: any) => {
        const id = `section-${sectionIndex}-field-${fieldKey}`;
        const value = sections[sectionIndex].content[fieldKey] || '';

        switch(field.type) {
            case 'text':
                return <Input id={id} value={value} onChange={(e) => handleFieldChange(sectionIndex, fieldKey, e.target.value)} />;
            case 'textarea':
                return <Textarea id={id} value={value} onChange={(e) => handleFieldChange(sectionIndex, fieldKey, e.target.value)} rows={5}/>;
            case 'image':
                 // This part needs a proper implementation for image uploads to Supabase storage.
                 // For now, it's a text input for the URL.
                return (
                    <div className="flex items-center gap-4">
                        <img src={value} alt={field.label} className="w-20 h-20 object-cover rounded-md border" />
                        <Input id={id} value={value} onChange={(e) => handleFieldChange(sectionIndex, fieldKey, e.target.value)} />
                    </div>
                );
            case 'repeater':
                return (
                     <div className="space-y-4 p-4 border rounded-md">
                        {(sections[sectionIndex].content[fieldKey] || []).map((item: any, itemIndex: number) => (
                           <Card key={itemIndex} className="p-4 bg-muted/50">
                             <CardContent className="space-y-4 p-0">
                                {Object.keys(item).map(itemFieldKey => (
                                     <div key={itemFieldKey} className="space-y-2">
                                        <Label htmlFor={`${id}-${itemIndex}-${itemFieldKey}`}>{itemFieldKey.charAt(0).toUpperCase() + itemFieldKey.slice(1)}</Label>
                                        <Input 
                                            id={`${id}-${itemIndex}-${itemFieldKey}`} 
                                            value={item[itemFieldKey]}
                                            onChange={(e) => handleRepeaterChange(sectionIndex, fieldKey, itemIndex, itemFieldKey, e.target.value)}
                                        />
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

    if (!pageData) {
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

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                 <h1 className="text-3xl font-bold">Edit Page: {pageData.title}</h1>
                <div className="flex gap-4">
                    <Button variant="outline" asChild>
                        <Link href={pageSlug === 'home' ? '/' : `/${pageSlug}`} target="_blank">Preview</Link>
                    </Button>
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
                                <Input id="page-title" value={pageData.title} disabled />
                            </div>
                             <div className="space-y-2">
                                <Label htmlFor="page-slug">Slug</Label>
                                <Input id="page-slug" value={pageData.slug} disabled />
                            </div>
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="meta-title">Meta Title</Label>
                            <Input id="meta-title" value={pageData.meta_title || ''} />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="meta-description">Meta Description</Label>
                            <Textarea id="meta-description" value={pageData.meta_description || ''} rows={3} />
                        </div>
                    </CardContent>
                </Card>

                {sections.map((section, index) => (
                    <Card key={section.id}>
                        <CardHeader className="flex flex-row items-center justify-between">
                            <div>
                                <CardTitle>{section.title}</CardTitle>
                                <CardDescription>{section.type} section</CardDescription>
                            </div>
                            <div className="flex items-center gap-2">
                                <Label htmlFor={`section-${index}-visible`} className="text-sm text-muted-foreground">
                                    {section.visible ? <Eye className="h-5 w-5" /> : <EyeOff className="h-5 w-5" />}
                                </Label>
                                <Switch 
                                    id={`section-${index}-visible`}
                                    checked={section.visible}
                                    onCheckedChange={(checked) => handleVisibilityChange(index, checked)}
                                />
                            </div>
                        </CardHeader>
                        <CardContent className="space-y-6">
                            {Object.entries(section.content_structure || {}).map(([key, field]: [string, any]) => (
                                <div key={key} className="space-y-2">
                                    <Label htmlFor={`section-${index}-field-${key}`}>{field.label}</Label>
                                    {renderField(index, key, field)}
                                </div>
                            ))}
                        </CardContent>
                    </Card>
                ))}
            </div>
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
