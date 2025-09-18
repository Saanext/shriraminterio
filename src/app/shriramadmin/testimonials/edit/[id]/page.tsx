
import { notFound } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { TestimonialEditor } from '@/components/testimonial-editor';

async function getTestimonialData(id: string) {
    const supabase = createClient();
    const testimonialId = parseInt(id, 10);
    if(isNaN(testimonialId)) {
        notFound();
    }
    const { data, error } = await supabase
        .from('testimonials')
        .select('*')
        .eq('id', testimonialId)
        .single();

    if (error || !data) {
        notFound();
    }
    
    return data;
}

export default async function EditTestimonialPage({ params }: { params: { id: string } }) {
    const testimonialData = await getTestimonialData(params.id);

    return (
        <TestimonialEditor initialData={testimonialData} />
    )
}
