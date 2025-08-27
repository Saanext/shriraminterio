
'use server';

import { createClient } from '@/lib/supabase/server';
import { revalidatePath } from 'next/cache';
import { z } from 'zod';

const pageSchema = z.object({
  title: z.string(),
  slug: z.string(),
  template: z.string(),
});

const templates = {
  generic: {
    sections: [
      {
        type: 'hero',
        title: 'Hero Section',
        content: { title: 'Generic Page Title', subtitle: 'A subtitle for your generic page', backgroundImage: 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg' },
        content_structure: { title: { type: 'text', label: 'Title' }, subtitle: { type: 'text', label: 'Subtitle' }, backgroundImage: { type: 'image', label: 'Background Image' } },
        order: 1,
        visible: true,
      },
    ],
  },
  product: {
    sections: [
      {
        type: 'product_details',
        title: 'Product Details',
        content: { title: 'New Product', description: 'Description for the new product.', image: 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-placeholder.png' },
        content_structure: { title: { type: 'text', label: 'Product Name' }, description: { type: 'textarea', label: 'Product Description' }, image: { type: 'image', label: 'Product Image' } },
        order: 1,
        visible: true,
      },
    ],
  },
};

export async function createPage(values: z.infer<typeof pageSchema>) {
  const supabase = createClient();
  const slugParts = values.slug.split('/');
  const finalSlug = slugParts.pop();
  const parentSlug = slugParts.join('/') || null;

  // 1. Check if slug already exists
  const { data: existingPage, error: fetchError } = await supabase
    .from('pages')
    .select('slug')
    .eq('slug', finalSlug)
    .eq('parent_slug', parentSlug)
    .single();

  if (existingPage) {
    return { success: false, error: 'A page with this slug already exists at this level.' };
  }

  // 2. Insert the new page
  const { data: newPage, error: insertPageError } = await supabase
    .from('pages')
    .insert({
      title: values.title,
      slug: finalSlug,
      meta_title: values.title,
      meta_description: `Learn more about ${values.title}`,
      parent_slug: values.template === 'product' ? 'products' : parentSlug
    })
    .select('id')
    .single();

  if (insertPageError) {
    console.error('Error creating page:', insertPageError);
    return { success: false, error: 'Failed to create the page.' };
  }

  // 3. Insert sections based on template
  const templateKey = values.template as keyof typeof templates;
  const template = templates[templateKey];

  if (!template) {
    return { success: false, error: 'Invalid template selected.' };
  }
  
  const sectionsToInsert = template.sections.map(section => ({
      ...section,
      page_id: newPage.id,
  }));

  const { error: insertSectionsError } = await supabase.from('sections').insert(sectionsToInsert);

  if (insertSectionsError) {
    console.error('Error inserting sections:', insertSectionsError);
    // Optionally, delete the created page for consistency
    await supabase.from('pages').delete().eq('id', newPage.id);
    return { success: false, error: 'Failed to create page sections.' };
  }
  
  // 4. Revalidate paths
  revalidatePath('/shriramadmin/pages');
  revalidatePath(`/${values.slug}`);
  revalidatePath('/', 'layout'); // Revalidate header nav

  return { success: true, error: null };
}
