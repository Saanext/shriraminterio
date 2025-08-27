
import { getPageStructure } from '@/lib/page-content';
import { NextResponse } from 'next/server';

export const dynamic = 'force-dynamic';

export async function GET() {
    try {
        const structure = getPageStructure();
        return NextResponse.json(structure);
    } catch (error: any) {
        return NextResponse.json({ error: 'Failed to load page structure', details: error.message }, { status: 500 });
    }
}
