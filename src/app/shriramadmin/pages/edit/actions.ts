
'use server';

import fs from 'fs';
import path from 'path';
import { getPageStructure } from '@/lib/page-content';
import { revalidatePath } from 'next/cache';
import { set, get, toPath } from 'lodash';

// Helper function to parse nested form data keys
function parseKey(key: string): (string | number)[] {
    return key.split('-').flatMap(part => {
        const asNumber = parseInt(part, 10);
        if (!isNaN(asNumber)) {
            const pathParts = toPath(part);
            if (pathParts.length > 1) {
                return pathParts;
            }
            return asNumber;
        }
        return part;
    });
}

export async function savePageContent(pageSlug: string, data: Record<string, any>) {
    try {
        const pageKey = pageSlug.replace(/-/g, '_') || 'home';
        
        const currentStructure = getPageStructure();
        const pageContent = currentStructure[pageKey];

        if (!pageContent) {
            throw new Error(`No content structure found for page: ${pageSlug}`);
        }

        const newData: Record<string, any> = {};

        // Reconstruct the object from the flat form data
        for (const [key, value] of Object.entries(data)) {
            const path = parseKey(key);
            set(newData, path, value);
        }

        // Deep merge the new data into the existing structure
        const formKeys = new Set(Object.keys(data));
        const mergeAndUpdate = (target: any, source: any, currentPath: string[] = []) => {
            if (typeof target !== 'object' || target === null || typeof source !== 'object' || source === null) {
                return;
            }

            Object.keys(source).forEach(key => {
                const newPath = [...currentPath, key];
                const newPathString = newPath.join('-');

                if (target[key] !== undefined && typeof target[key] === 'object' && target[key] !== null && !Array.isArray(target[key])) {
                     // Recursively merge for nested objects (like 'fields')
                    if (source[key] !== undefined) {
                        mergeAndUpdate(target[key], source[key], newPath);
                    }
                } else if (Array.isArray(target[key]) && Array.isArray(source[key])) {
                     // Handle repeaters (arrays of objects)
                    target[key] = source[key].map((item: any, index: number) => {
                        const newArrayItem: any = {};
                         Object.keys(item).forEach(itemKey => {
                             newArrayItem[itemKey] = item[itemKey];
                        });
                        return { ...(target[key][index] || {}), ...newArrayItem };
                    });
                } else {
                     // Direct value update
                    if (source[key] !== undefined) {
                        if (key === 'visible') {
                            // Correctly handle boolean for visibility switch
                             target[key] = formKeys.has(newPathString);
                        } else {
                            target[key] = source[key];
                        }
                    }
                }
            });
             // Handle unchecked switches for sections
            if (currentPath.length > 0 && currentPath[0] === 'sections' && target.visible !== undefined && !formKeys.has([...currentPath, 'visible'].join('-'))) {
                 target.visible = false;
            }
        };
        
        mergeAndUpdate(pageContent, newData);
        
        const dataFilePath = path.join(process.cwd(), 'src', 'lib', 'page-structure.json');
        fs.writeFileSync(dataFilePath, JSON.stringify(currentStructure, null, 2));

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
