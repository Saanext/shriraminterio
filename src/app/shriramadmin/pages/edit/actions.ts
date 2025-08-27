
'use server';

import fs from 'fs';
import path from 'path';
import { getPageStructure } from '@/lib/page-content';
import { revalidatePath } from 'next/cache';
import { set, get } from 'lodash';

export async function savePageContent(pageSlug: string, data: Record<string, any>) {
    try {
        const pageKey = pageSlug.replace(/-/g, '_') || 'home';
        
        const currentStructure = getPageStructure();
        
        // Use lodash.set for deep assignment
        for (const [key, value] of Object.entries(data)) {
            const path = key.replace(/-/g, '.');
             // Handle switch (checkbox) values
            if (value === 'on') {
                 set(currentStructure[pageKey], path, true);
            } else {
                 set(currentStructure[pageKey], path, value);
            }
        }
        
        // Clean up switch values that are not present in form data (unchecked)
        const formKeys = new Set(Object.keys(data));
        const cleanAndSet = (obj: any, currentPath: string[] = []) => {
            if (typeof obj !== 'object' || obj === null) return;

            Object.keys(obj).forEach(key => {
                 const newPath = [...currentPath, key];
                 if (key === 'visible' && typeof obj[key] === 'boolean') {
                    const formKey = newPath.join('-');
                     if (!formKeys.has(formKey)) {
                        obj[key] = false;
                    }
                 } else {
                    cleanAndSet(obj[key], newPath);
                 }
            });
        };
        cleanAndSet(get(currentStructure[pageKey], 'sections'));


        const dataFilePath = path.join(process.cwd(), 'src', 'lib', 'page-structure.json');
        fs.writeFileSync(dataFilePath, JSON.stringify(currentStructure, null, 2));

        // Revalidate the path to show changes
        const revalidationSlug = pageSlug ? `/${pageSlug}`: '/';
        revalidatePath(revalidationSlug, 'page');
        revalidatePath('/about'); // revalidate all pages for now

        return { success: true };
    } catch (error: any) {
        console.error("Error saving page content:", error);
        return { success: false, error: error.message };
    }
}
