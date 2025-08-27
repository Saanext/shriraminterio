
'use server';

import fs from 'fs';
import path from 'path';
import { getPageStructure } from '@/lib/page-content';
import { revalidatePath } from 'next/cache';
import { set, cloneDeep, isObject } from 'lodash';

// Helper function to parse nested form data keys
function parseKey(key: string): (string | number)[] {
    // This regex is more robust for handling keys like 'sections.0.fields.items.0.title'
    return key.split(/[\.\[\]]+/).filter(Boolean);
}

export async function savePageContent(pageSlug: string, data: Record<string, any>) {
    try {
        const pageKey = pageSlug.replace(/-/g, '_') || 'home';
        
        const currentStructure = getPageStructure();
        // Use cloneDeep to avoid modifying the cached version of the structure
        const pageContent = cloneDeep(currentStructure[pageKey]);

        if (!pageContent) {
            throw new Error(`No content structure found for page: ${pageSlug}`);
        }

        const newData: Record<string, any> = {};

        // Reconstruct the object from the flat form data
        for (const [key, value] of Object.entries(data)) {
            // Handle file inputs: skip empty file inputs
            if (key.endsWith('.file') && (value as File).size === 0) continue;
            
            // The name from the form field is already the path we need.
            const path = parseKey(key);
            set(newData, path, value);
        }

        // Deep merge the new data into the existing structure
        const mergeAndUpdate = (target: any, source: any) => {
            if (!target || !source) return;
            Object.keys(source).forEach(key => {
                if (isObject(source[key]) && !Array.isArray(source[key]) && isObject(target[key])) {
                    mergeAndUpdate(target[key], source[key]);
                } else if(target) {
                    target[key] = source[key];
                }
            });
        };
        
        // Merge meta fields
        if (newData.meta) {
           mergeAndUpdate(pageContent, newData.meta);
        }

        // Merge section fields
        if (newData.sections) {
            pageContent.sections.forEach((section: any, index: number) => {
                const newSectionData = newData.sections[index];
                if (newSectionData) {
                    // Update visibility
                    section.visible = newSectionData.visible === 'on';

                    if (section.fields && newSectionData.fields) {
                        mergeAndUpdate(section.fields, newSectionData.fields);
                    }
                }
            });
        }
        
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
