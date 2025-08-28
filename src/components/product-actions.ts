
'use server'

import { createClient } from '@/lib/supabase/server'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const productSchema = z.object({
  id: z.number().optional().nullable(),
  name: z.string().min(1),
  slug: z.string().min(1),
  short_description: z.string().min(1),
  long_description: z.string().min(1),
  main_image: z.string().url(),
  features: z.array(z.string()).optional(),
  gallery: z.array(z.string()).optional(),
  amazon_link: z.string().url().optional().or(z.literal('')),
});


export async function saveProduct(data: z.infer<typeof productSchema>) {
  const supabase = createClient()
  
  const { id, ...productData } = data;
  
  try {
    if (id) {
      // Update existing product
      const { error } = await supabase.from('products').update(productData).eq('id', id);
      if (error) throw error;
    } else {
      // Create new product
      const { error } = await supabase.from('products').insert(productData);
      if (error) throw error;
    }

    // Revalidate paths
    revalidatePath('/products');
    revalidatePath(`/products/${productData.slug}`);
    revalidatePath('/shriramadmin/products');
    
    return { success: true, error: null };
  } catch (error: any) {
    console.error('Error saving product:', error);
    return { success: false, error: error.message };
  }
}

export async function deleteProduct(productId: number) {
    const supabase = createClient();
    try {
        const { error } = await supabase.from('products').delete().eq('id', productId);
        if (error) throw error;

        revalidatePath('/shriramadmin/products');
        revalidatePath('/products');

        return { success: true, error: null };
    } catch (error: any) {
        console.error('Error deleting product:', error);
        return { success: false, error: error.message };
    }
}
