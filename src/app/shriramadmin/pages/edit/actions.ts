
'use server';

import fs from 'fs';
import path from 'path';
import { getPageStructure } from '@/lib/page-content';
import { revalidatePath } from 'next/cache';
import { set, get, toPath, cloneDeep } from 'lodash';

// Helper function to parse nested form data keys
function parseKey(key: string): (string | number)[] {
    return toPath(key);
}

export async function savePageContent(pageSlug: string, data: Record<string, any>) {
    try {
        const pageKey = pageSlug.replace(/-/g, '_') || 'home';
        
        const currentStructure = getPageStructure();
        
        const pageContent = cloneDeep(currentStructure[pageKey]);

        if (!pageContent) {
            throw new Error(`No content structure found for page: ${pageSlug}`);
        }

        const newData: Record<string, any> = {};
        const visibilityFlags: Record<string, boolean> = {};

        // Reconstruct the object from the flat form data
        for (const [key, value] of Object.entries(data)) {
            if (key.endsWith('-visible')) {
                const path = parseKey(key);
                visibilityFlags[path.slice(0, -1).join('.')] = true;
            } else {
                const path = parseKey(key);
                set(newData, path, value);
            }
        }
        
        // Deep merge the new data into the existing structure
        const mergeAndUpdate = (target: any, source: any) => {
            for (const key in source) {
                if (source[key] instanceof Object && key in target) {
                    mergeAndUpdate(target[key], source[key]);
                } else {
                    target[key] = source[key];
                }
            }
        };

        mergeAndUpdate(pageContent, newData);
        
        // Update visibility
        pageContent.sections.forEach((section: any, index: number) => {
            const sectionPath = `sections.${index}`;
            if (visibilityFlags[sectionPath]) {
                section.visible = true;
            } else {
                // Check if any field within the section was submitted. If not, the switch was off.
                const wasSubmitted = Object.keys(data).some(d => d.startsWith(`sections-${index}-`));
                 if (section.visible !== undefined && wasSubmitted) {
                    section.visible = false;
                 }
            }
        });
        
        const newStructure = { ...currentStructure, [pageKey]: pageContent };
        
        const dataFilePath = path.join(process.cwd(), 'src', 'lib', 'page-structure.json');
        fs.writeFileSync(dataFilePath, JSON.stringify(newStructure, null, 2));

        // Revalidate the path to show changes
        const revalidationSlug = pageSlug ? `/${pageSlug}`: '/';
        revalidatePath(revalidationSlug, 'page');
        revalidatePath('/shriramadmin/pages/edit', 'page');
        revalidatePath('/', 'layout'); // Revalidate all pages


        return { success: true };
    } catch (error: any) {
        console.error("Error saving page content:", error);
        return { success: false, error: error.message };
    }
}
