
'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import Link from 'next/link';
import { Textarea } from '@/components/ui/textarea';
import { Eye, EyeOff, ShieldAlert, Upload, Sparkles, Loader2 } from 'lucide-react';
import { Switch } from '@/components/ui/switch';
import { useToast } from '@/hooks/use-toast';
import { savePageContent } from './actions';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { createClient } from '@/lib/supabase/client';
import Image from 'next/image';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from '@/components/ui/dialog';
import { generateSectionContent } from '@/ai/flows/generate-content-flow';


type PageEditorProps = {
    initialPageData: any;
    pageSlug: string;
}

export function PageEditor({ initialPageData, pageSlug }: PageEditorProps) {
    const { toast } = useToast();
    const supabase = createClient();
    
    const [pageData, setPageData] = useState<any>(initialPageData);
    const [error, setError] = useState<string | null>(null);
    const [sections, setSections] = useState<any[]>(initialPageData?.sections || []);
    const [metaTitle, setMetaTitle] = useState(initialPageData?.meta_title || '');
    const [metaDescription, setMetaDescription] = useState(initialPageData?.meta_description || '');
    const [isUploading, setIsUploading] = useState(false);

    const [isAiDialogOpen, setIsAiDialogOpen] = useState(false);
    const [currentSectionForAI, setCurrentSectionForAI] = useState<number | null>(null);
    const [aiKeywords, setAiKeywords] = useState('');
    const [isGenerating, setIsGenerating] = useState(false);


    useEffect(() => {
        if (!initialPageData) {
            setError("Could not load page data. This could be due to a database connection issue or because Row Level Security (RLS) is enabled and blocking access. Please check your Supabase policies for the 'pages' and 'sections' tables to ensure read access is allowed.");
        } else {
             setPageData(initialPageData);
             setSections(initialPageData.sections);
             setMetaTitle(initialPageData.meta_title || '');
             setMetaDescription(initialPageData.meta_description || '');
        }
    }, [initialPageData]);

    const handleFieldChange = (sectionIndex: number, fieldKey: string, value: any) => {
        const newSections = [...sections];
        newSections[sectionIndex].content[fieldKey] = value;
        setSections(newSections);
    };
    
    const handleRepeaterChange = (sectionIndex: number, repeaterKey: string, itemIndex: number, itemFieldKey: string, value: any) => {
        const newSections = [...sections];
        newSections[sectionIndex].content[repeaterKey][itemIndex][itemFieldKey] = value;
        setSections(newSections);
    };
    
    const handleAddNewRepeaterItem = (sectionIndex: number, fieldKey: string, field: any) => {
        const newSections = [...sections];
        const newItem: { [key: string]: any } = {};
        // Initialize the new item with empty strings for each field defined in the repeater structure
        Object.keys(field.fields).forEach(itemFieldKey => {
            newItem[itemFieldKey] = '';
        });
        
        if (!newSections[sectionIndex].content[fieldKey]) {
            newSections[sectionIndex].content[fieldKey] = [];
        }

        newSections[sectionIndex].content[fieldKey].push(newItem);
        setSections(newSections);
    };
    
    const handleVisibilityChange = (sectionIndex: number, checked: boolean) => {
        const newSections = [...sections];
        newSections[sectionIndex].visible = checked;
        setSections(newSections);
    };

    const handleImageUpload = async (file: File, sectionIndex: number, fieldKey: string, itemIndex?: number, itemFieldKey?: string) => {
        if (!file) return;

        setIsUploading(true);
        const { id, update } = toast({
            title: 'Uploading image...',
            description: 'Please wait while the image is being uploaded.',
        });

        const fileName = `${Date.now()}-${file.name}`;
        const { data, error } = await supabase.storage.from('public').upload(fileName, file);

        setIsUploading(false);
        if (error) {
            update({
                id,
                title: 'Upload failed',
                description: error.message,
                variant: 'destructive',
            });
            return;
        }

        const { data: { publicUrl } } = supabase.storage.from('public').getPublicUrl(fileName);
        
        if (itemIndex !== undefined && itemFieldKey) {
            handleRepeaterChange(sectionIndex, fieldKey, itemIndex, itemFieldKey, publicUrl);
        } else {
            handleFieldChange(sectionIndex, fieldKey, publicUrl);
        }

        update({
            id,
            title: 'Upload successful!',
            description: 'The image has been uploaded and the URL updated.',
        });
    };

    const handleSaveChanges = async (event: React.MouseEvent<HTMLButtonElement>) => {
        event.preventDefault();
        
        const result = await savePageContent(pageData.id, pageSlug, sections, metaTitle, metaDescription);
        
        if (result.success) {
            toast({
                title: "Changes Saved!",
                description: "Your page content has been successfully updated.",
            });
        } else {
             toast({
                title: "Error",
                description: result.error || "There was an error saving the content.",
                variant: 'destructive'
            });
        }
    };

    const openAiModal = (sectionIndex: number) => {
        setCurrentSectionForAI(sectionIndex);
        setIsAiDialogOpen(true);
    };

    const handleGenerateContent = async () => {
        if (currentSectionForAI === null) return;
        
        setIsGenerating(true);
        const section = sections[currentSectionForAI];
        
        try {
            const result = await generateSectionContent({
                context: `Section is '${section.title}' of type '${section.type}' on the '${pageData.title}' page.`,
                currentContent: section.content,
                contentStructure: section.content_structure,
                keywords: aiKeywords,
            });

            if (result.content) {
                const newSections = [...sections];
                newSections[currentSectionForAI].content = result.content;
                setSections(newSections);
                toast({
                    title: "Content Generated!",
                    description: "AI-generated content has been populated in the section.",
                });
            }
            setIsAiDialogOpen(false);
            setAiKeywords('');
        } catch (e: any) {
            console.error(e);
            toast({
                title: "AI Generation Failed",
                description: e.message || "An unknown error occurred.",
                variant: 'destructive'
            });
        } finally {
            setIsGenerating(false);
        }
    };
    
    const renderField = (sectionIndex: number, fieldKey: string, field: any, itemIndex?: number, itemValue?: any, repeaterKey?: string) => {
        const id = `section-${sectionIndex}-field-${fieldKey}` + (itemIndex !== undefined ? `-${itemIndex}` : '');
        const value = itemIndex !== undefined ? itemValue : sections[sectionIndex].content[fieldKey] || '';
        const uploadId = `section-${sectionIndex}-upload-${fieldKey}`+ (itemIndex !== undefined ? `-${itemIndex}` : '');
        const isRepeaterField = itemIndex !== undefined && repeaterKey !== undefined;
        const isUrl = (val: any) => typeof val === 'string' && (val.startsWith('http://') || val.startsWith('https://'));

        switch(field.type) {
            case 'text':
                return <Input id={id} value={value} onChange={(e) => isRepeaterField ? handleRepeaterChange(sectionIndex, repeaterKey, itemIndex!, fieldKey, e.target.value) : handleFieldChange(sectionIndex, fieldKey, e.target.value)} />;
            case 'textarea':
                return <Textarea id={id} value={value} onChange={(e) => isRepeaterField ? handleRepeaterChange(sectionIndex, repeaterKey, itemIndex!, fieldKey, e.target.value) : handleFieldChange(sectionIndex, fieldKey, e.target.value)} rows={5}/>;
            case 'image':
                return (
                    <div className="flex flex-col gap-2">
                        <div className="flex items-center gap-4">
                            {value && isUrl(value) && <Image src={value} alt={field.label} width={80} height={80} className="w-20 h-20 object-cover rounded-md border" />}
                            <Input id={id} value={value} onChange={(e) => isRepeaterField ? handleRepeaterChange(sectionIndex, repeaterKey, itemIndex!, fieldKey, e.target.value) : handleFieldChange(sectionIndex, fieldKey, e.target.value)} className="flex-grow" />
                        </div>
                        <div>
                            <Button asChild variant="outline" size="sm">
                                <Label htmlFor={uploadId} className="cursor-pointer">
                                    <Upload className="mr-2 h-4 w-4" />
                                    Upload Image
                                </Label>
                            </Button>
                            <Input 
                                id={uploadId} 
                                type="file" 
                                className="sr-only" 
                                accept="image/*"
                                onChange={(e) => {
                                    const file = e.target.files?.[0];
                                    if(file) handleImageUpload(file, sectionIndex, repeaterKey || fieldKey, isRepeaterField ? itemIndex : undefined, isRepeaterField ? fieldKey : undefined);
                                }} 
                                disabled={isUploading}
                            />
                        </div>
                    </div>
                );
            case 'repeater':
                return (
                     <div className="space-y-4 p-4 border rounded-md">
                        {(sections[sectionIndex].content[fieldKey] || []).map((item: any, itemIndex: number) => (
                           <Card key={itemIndex} className="p-4 bg-muted/50">
                             <CardHeader><CardTitle>Item {itemIndex + 1}</CardTitle></CardHeader>
                             <CardContent className="space-y-4 p-0 pt-4">
                                {Object.keys(field.fields).map(itemFieldKey => (
                                     <div key={itemFieldKey} className="space-y-2">
                                        <Label htmlFor={`${id}-${itemIndex}-${itemFieldKey}`}>{field.fields[itemFieldKey].label}</Label>
                                        {renderField(sectionIndex, itemFieldKey, field.fields[itemFieldKey], itemIndex, item[itemFieldKey], fieldKey)}
                                    </div>
                                ))}
                             </CardContent>
                           </Card>
                        ))}
                         <Button variant="outline" size="sm" type="button" onClick={() => handleAddNewRepeaterItem(sectionIndex, fieldKey, field)}>
                            Add New
                        </Button>
                    </div>
                );
            default:
                return null;
        }
    }

    if (error) {
        return (
             <Alert variant="destructive">
                <ShieldAlert className="h-4 w-4" />
                <AlertTitle>Database Error</AlertTitle>
                <AlertDescription>
                   {error}
                </AlertDescription>
            </Alert>
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
                            <Input id="meta-title" value={metaTitle} onChange={(e) => setMetaTitle(e.target.value)} />
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="meta-description">Meta Description</Label>
                            <Textarea id="meta-description" value={metaDescription} onChange={(e) => setMetaDescription(e.target.value)} rows={3} />
                        </div>
                    </CardContent>
                </Card>
                {sections.map((section, index) => (
                    <Card key={section.id}>
                        <CardHeader className="flex flex-row items-center justify-between">
                            <div>
                                <CardTitle>{section.title}</CardTitle>
                                <CardDescription>{section.type}</CardDescription>
                            </div>
                            <div className="flex items-center gap-4">
                                <Button variant="outline" size="sm" onClick={() => openAiModal(index)}>
                                    <Sparkles className="mr-2 h-4 w-4" />
                                    AI Generate
                                </Button>
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
            <Dialog open={isAiDialogOpen} onOpenChange={setIsAiDialogOpen}>
                <DialogContent>
                    <DialogHeader>
                        <DialogTitle>Generate Content with AI</DialogTitle>
                        <DialogDescription>
                            Enter some keywords or ideas, and the AI will generate content for this section.
                        </DialogDescription>
                    </DialogHeader>
                    <div className="space-y-4 py-4">
                        <Label htmlFor="ai-keywords">Keywords</Label>
                        <Input 
                            id="ai-keywords"
                            value={aiKeywords}
                            onChange={(e) => setAiKeywords(e.target.value)}
                            placeholder="e.g., modern, minimalist, luxury"
                        />
                    </div>
                    <DialogFooter>
                        <Button variant="ghost" onClick={() => setIsAiDialogOpen(false)} disabled={isGenerating}>Cancel</Button>
                        <Button onClick={handleGenerateContent} disabled={isGenerating}>
                            {isGenerating ? (
                                <>
                                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                    Generating...
                                </>
                            ) : (
                                <>
                                    <Sparkles className="mr-2 h-4 w-4" />
                                    Generate
                                </>
                            )}
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </div>
    );
}
