
'use client'

import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { useState } from "react";

const googleFonts = [
    "Roboto", "Open Sans", "Lato", "Montserrat", "Oswald", "Raleway", "Merriweather", "PT Sans", "Playfair Display", "Nunito"
];

export default function AppearancePage() {
    const { toast } = useToast();
    const [headlineFont, setHeadlineFont] = useState("Playfair_Display");
    const [bodyFont, setBodyFont] = useState("Comfortaa");
    const [baseSize, setBaseSize] = useState(16);

    const handleSaveChanges = () => {
        // In a real application, this would save to a database or a config file.
        // Here, we'll just show a toast notification.
        console.log({
            headlineFont,
            bodyFont,
            baseSize
        });
        toast({
            title: "Changes Saved!",
            description: "Your appearance settings have been updated.",
        });
    };

    return (
        <div>
            <div className="flex justify-between items-center mb-8">
                <h1 className="text-3xl font-bold">Appearance</h1>
                <Button onClick={handleSaveChanges}>Save Changes</Button>
            </div>

            <Card>
                <CardHeader>
                    <CardTitle>Theme Customization</CardTitle>
                    <CardDescription>Customize the look and feel of your website.</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div className="space-y-2">
                            <Label htmlFor="headline-font">Headline Font</Label>
                            <Select value={headlineFont} onValueChange={setHeadlineFont}>
                                <SelectTrigger id="headline-font">
                                    <SelectValue placeholder="Select a font" />
                                </SelectTrigger>
                                <SelectContent>
                                    {googleFonts.map(font => (
                                        <SelectItem key={font} value={font.replace(/ /g, '_')}>{font}</SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                        <div className="space-y-2">
                            <Label htmlFor="body-font">Body Font</Label>
                            <Select value={bodyFont} onValueChange={setBodyFont}>
                                <SelectTrigger id="body-font">
                                    <SelectValue placeholder="Select a font" />
                                </SelectTrigger>
                                <SelectContent>
                                    {googleFonts.map(font => (
                                        <SelectItem key={font} value={font.replace(/ /g, '_')}>{font}</SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                    </div>
                    <div className="space-y-2">
                        <Label htmlFor="base-size">Base Font Size (px)</Label>
                        <Input 
                            id="base-size" 
                            type="number" 
                            value={baseSize}
                            onChange={(e) => setBaseSize(Number(e.target.value))}
                            className="max-w-xs"
                        />
                         <p className="text-sm text-muted-foreground">
                            This will be the base font size for the body text. Headings will be scaled relative to this value.
                        </p>
                    </div>
                    <div className="space-y-4 pt-4">
                        <h3 className="text-lg font-medium">Preview</h3>
                        <div className="p-6 border rounded-lg space-y-4">
                            <h1 style={{ fontFamily: headlineFont.replace(/_/g, ' '), fontSize: `${baseSize * 2}px` }} className="font-bold">This is a Headline (H1)</h1>
                            <h2 style={{ fontFamily: headlineFont.replace(/_/g, ' '), fontSize: `${baseSize * 1.5}px` }} className="font-bold">This is a Sub-headline (H2)</h2>
                            <p style={{ fontFamily: bodyFont.replace(/_/g, ' '), fontSize: `${baseSize}px` }}>
                                This is some body text. It uses the selected body font and base size. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in dui mauris. Vivamus hendrerit arcu sed erat molestie vehicula. Sed auctor neque eu tellus rhoncus ut eleifend nibh porttitor.
                            </p>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
