
import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

type LeadStatus = 'new' | 'in progress' | 'qualified' | 'not qualified';

const statusStyles: { [key in LeadStatus]: string } = {
    'new': 'bg-blue-500 hover:bg-blue-600 text-white',
    'in progress': 'bg-yellow-500 hover:bg-yellow-600 text-white',
    'qualified': 'bg-green-500 hover:bg-green-600 text-white',
    'not qualified': 'bg-red-500 hover:bg-red-600 text-white',
};

export function LeadStatusBadge({ status }: { status: LeadStatus }) {
    return (
        <Badge className={cn("border-transparent capitalize", statusStyles[status] || 'bg-gray-500 text-white')}>
            {status}
        </Badge>
    );
}
