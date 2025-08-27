
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { FilePlus, LayoutDashboard, ListVideo, Newspaper, Quote } from 'lucide-react';

const adminFeatures = [
    { title: 'Pages Management', description: 'Create, update, and delete pages.', icon: <Newspaper className="w-6 h-6" /> },
    { title: 'Project Management', description: 'Add and update project details.', icon: <LayoutDashboard className="w-6 h-6" /> },
    { title: 'Video Management', description: 'Add video links to pages.', icon: <ListVideo className="w-6 h-6" /> },
    { title: 'Content Editing', description: 'Full control to edit all page content.', icon: <FilePlus className="w-6 h-6" /> },
    { title: 'Home Page Management', description: 'Add and edit home page sections.', icon: <Newspaper className="w-6 h-6" /> },
    { title: 'Get Quote Form Management', description: 'Manage form fields and view submissions.', icon: <Quote className="w-6 h-6" /> },
];

export default function AdminDashboardPage() {
    return (
        <div>
            <h1 className="text-3xl font-bold mb-8">Admin Dashboard</h1>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {adminFeatures.map((feature, index) => (
                    <Card key={index}>
                        <CardHeader className="flex flex-row items-start gap-4 space-y-0">
                            <div className="text-primary mt-1">{feature.icon}</div>
                            <div className="flex-1">
                                <CardTitle className="text-xl">{feature.title}</CardTitle>
                                <CardContent className="p-0 mt-2">
                                    <p className="text-muted-foreground">{feature.description}</p>
                                </CardContent>
                            </div>
                        </CardHeader>
                    </Card>
                ))}
            </div>
        </div>
    );
}
