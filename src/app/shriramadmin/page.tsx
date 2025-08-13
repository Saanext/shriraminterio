import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { FilePlus, LayoutDashboard, ListVideo, Newspaper, Quote } from 'lucide-react';

const adminFeatures = [
    { title: 'Pages Management', description: 'Create, update, and delete pages.', icon: <Newspaper /> },
    { title: 'Project Management', description: 'Add and update project details.', icon: <LayoutDashboard /> },
    { title: 'Video Management', description: 'Add video links to pages.', icon: <ListVideo /> },
    { title: 'Content Editing', description: 'Full control to edit all page content.', icon: <FilePlus /> },
    { title: 'Home Page Management', description: 'Add and edit home page sections.', icon: <Newspaper /> },
    { title: 'Get Quote Form Management', description: 'Manage form fields and view submissions.', icon: <Quote /> },
];

export default function AdminDashboardPage() {
    return (
        <div>
            <h1 className="text-3xl font-bold mb-8">Admin Dashboard</h1>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {adminFeatures.map((feature, index) => (
                    <Card key={index}>
                        <CardHeader className="flex flex-row items-center gap-4">
                            <div className="text-primary">{feature.icon}</div>
                            <CardTitle>{feature.title}</CardTitle>
                        </CardHeader>
                        <CardContent>
                            <p className="text-muted-foreground">{feature.description}</p>
                        </CardContent>
                    </Card>
                ))}
            </div>
        </div>
    );
}
