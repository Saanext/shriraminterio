
import Image from 'next/image';
import Link from 'next/link';
import { Card, CardContent } from '@/components/ui/card';
import { ArrowRight } from 'lucide-react';
import { createClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';

async function getProducts() {
    const supabase = createClient();
    const { data: products, error } = await supabase.from('products').select('*').order('name');
    if (error) {
        console.error("Error fetching products:", error);
        return [];
    }
    return products;
}

export default async function ProductsPage() {
  const products = await getProducts();

  if (!products) {
    notFound();
  }

  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-bold">Our Products</h1>
          <p className="text-lg text-muted-foreground mt-2">Explore our collection of finely crafted interior solutions.</p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {products.map((product) => (
            <Link href={`/products/${product.slug}`} key={product.id} className="group block">
              <Card className="overflow-hidden transition-all duration-300 hover:shadow-2xl h-full flex flex-col">
                <div className="relative h-64">
                  <Image
                    src={product.main_image}
                    alt={product.name}
                    fill
                    objectFit="cover"
                    className="transition-transform duration-500 group-hover:scale-105"
                    data-ai-hint={product.name.toLowerCase()}
                  />
                </div>
                <CardContent className="p-6 flex flex-col flex-grow">
                  <h2 className="text-2xl font-bold font-headline">{product.name}</h2>
                  <p className="mt-2 text-muted-foreground flex-grow">{product.short_description}</p>
                  <div className="mt-4 flex items-center font-semibold text-primary">
                    View Details <ArrowRight className="ml-2 h-5 w-5 transition-transform duration-300 group-hover:translate-x-1" />
                  </div>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}
