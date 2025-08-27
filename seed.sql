
-- Enable RLS
ALTER TABLE pages ENABLE ROW LEVEL SECURITY;
ALTER TABLE sections ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Allow public read access to pages" ON pages FOR SELECT USING (true);
CREATE POLICY "Allow public read access to sections" ON sections FOR SELECT USING (true);
CREATE POLICY "Allow public read access to stories" ON stories FOR SELECT USING (true);
CREATE POLICY "Allow public read access on public bucket" ON storage.objects FOR SELECT USING (bucket_id = 'public');
CREATE POLICY "Allow insert access on public bucket" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'public');


-- Create Storage bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('public', 'public', true)
ON CONFLICT (id) DO NOTHING;

-- Seed pages
INSERT INTO pages (id, slug, title, meta_title, meta_description) VALUES
(1, 'home', 'Home', 'Shriram Interio Digital | Modular Kitchen & Home Interior Design Pune', 'Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Get a free quote for your dream home renovation.'),
(2, 'about', 'About Us', 'About Shriram Interio | Our Story, Mission & Team', 'Learn about Shriram Interio''s journey, our design philosophy, and the expert team dedicated to creating beautiful and functional living spaces in Pune.'),
(3, 'customer-stories', 'Customer Stories', 'Customer Stories & Project Showcases | Shriram Interio', 'Explore detailed stories of our completed projects. See before-and-after galleries and read about our clients'' experiences with our interior design services.'),
(4, 'clients', 'Clients', 'Our Valued Clients | Testimonials & Reviews', 'See what our clients have to say about their experience with Shriram Interio. Read testimonials and watch video reviews from satisfied homeowners in Pune.'),
(5, 'services', 'Services', 'Our Interior Design Services | Shriram Interio Pune', 'Discover our comprehensive range of interior design services, from modular kitchens and wardrobes to full home interiors and exterior design.'),
(6, 'portfolio', 'Portfolio', 'Interior Design Portfolio | Shriram Interio Projects', 'Browse our portfolio of stunning interior design projects in Pune. Get inspired by our work on kitchens, living areas, bedrooms, and more.'),
(7, 'how-it-works', 'How It Works', 'Our Design Process | From Consultation to Completion', 'Learn about our simple, transparent 5-step process for bringing your interior design dreams to life, from initial consultation to final handover.'),
(8, 'contact', 'Contact', 'Contact Us | Get in Touch with Shriram Interio', 'Contact Shriram Interio for a free consultation. Find our address, phone number, and email to start your home interior project in Pune.'),
(9, 'products', 'Products', 'Our Products', 'Discover our wide range of products for your home interior needs.'),
(10, 'product-kitchen', 'product-kitchen', 'Modular Kitchens', 'Explore our modular kitchen designs.'),
(11, 'product-wardrobe', 'product-wardrobe', 'Wardrobes', 'Discover our custom wardrobe solutions.'),
(12, 'product-living-room', 'product-living-room', 'Living Room Furniture', 'Furnish your living space with our stylish designs.'),
(13, 'product-bedroom', 'product-bedroom', 'Bedroom Furniture', 'Create your dream bedroom with our furniture.'),
(14, 'product-bathroom', 'product-bathroom', 'Bathroom Fittings', 'High-quality fittings for modern bathrooms.'),
(15, 'product-home-office', 'product-home-office', 'Home Office Setup', 'Create a productive and stylish home office.'),
(16, 'product-space-saving-furniture', 'product-space-saving-furniture', 'Space-Saving Furniture', 'Maximize your space with our innovative furniture solutions.')
ON CONFLICT (id) DO UPDATE SET
slug = EXCLUDED.slug,
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;


-- Seed sections for all pages
-- HOME PAGE
INSERT INTO sections (page_id, type, title, content, content_structure, "order", visible) VALUES
((SELECT id FROM pages WHERE slug = 'home'), 'hero', 'Hero', $$
{
    "title": "Modern Interior Design Studio",
    "subtitle": "We create stunning and functional modular kitchens, wardrobes, and full home interiors in Pune. Let us bring your vision to life.",
    "buttonText": "Explore Our Services",
    "videoUrl": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-video.mp4",
    "slides": [
        { "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg" },
        { "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-2.jpg" },
        { "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-3.jpg" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "buttonText": { "type": "text", "label": "Button Text" },
    "videoUrl": { "type": "text", "label": "Background Video URL" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'home'), 'welcome', 'Welcome', $$
{
    "paragraph1": "At Shriram Interio, we believe that great design has the power to transform not just spaces, but lives. We are a passionate team of creative designers and skilled craftsmen dedicated to creating stunning modular kitchens, wardrobes, and full home interiors that are both beautiful and highly functional.",
    "paragraph2": "Based in Pune, we have been turning our clients'' dreams into reality since 2016. Our journey is fueled by a commitment to quality, innovation, and a personalized approach that ensures every project is a true reflection of the people who live there.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/welcome.jpg"
}
$$, $$
{
    "paragraph1": { "type": "textarea", "label": "Paragraph 1" },
    "paragraph2": { "type": "textarea", "label": "Paragraph 2" },
    "image": { "type": "image", "label": "Image" }
}
$$, 2, true),
((SELECT id FROM pages WHERE slug = 'home'), 'about_company', 'About Company', $$
{
    "title": "Inspiring & Functional Design",
    "text": "is dedicated to creating stunning modular kitchens, wardrobes, and full home interiors that are both beautiful and highly functional. We believe that great design has the power to transform not just spaces, but lives. Our team''s dedication and passion shine through in every detail."
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "text": { "type": "textarea", "label": "Text" }
}
$$, 3, true),
((SELECT id FROM pages WHERE slug = 'home'), 'why_us', 'Why Us', $$
{
    "title": "Why Shriram Interio?",
    "subtitle": "Your dream home is just a step away. Here’s why we are the right choice for you.",
    "items": [
        { "title": "Expert Design Team", "description": "Our team of experienced designers works with you to bring your vision to life." },
        { "title": "Variety of Design Choices", "description": "Choose from a wide range of styles, materials, and finishes to suit your taste." },
        { "title": "Affordable Design Fees", "description": "We offer competitive pricing without compromising on quality or service." },
        { "title": "On-Time Project Delivery", "description": "We value your time and ensure timely completion of all our projects." }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 4, true),
((SELECT id FROM pages WHERE slug = 'home'), 'work_gallery', 'Work Gallery', $$
{
    "title": "Our Work Gallery",
    "subtitle": "Explore our portfolio of beautifully designed and executed projects.",
    "items": [
        { "title": "Modern Living Room", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "hint": "living room" },
        { "title": "Elegant Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "hint": "elegant kitchen" },
        { "title": "Cozy Bedroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-3.jpg", "hint": "cozy bedroom" },
        { "title": "Stylish Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-4.jpg", "hint": "stylish wardrobe" },
        { "title": "Functional Study Area", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-5.jpg", "hint": "study area" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 5, true),
((SELECT id FROM pages WHERE slug = 'home'), 'comfort_design', 'Comfort Design', $$
{
    "title": "Design at Your Comfort",
    "subtitle": "We make the design process easy and accessible for you.",
    "items": [
        { "title": "Live 3D Designs", "description": "Visualize your space with our live 3D rendering technology." },
        { "title": "Contactless Experience", "description": "From design to delivery, experience a completely contactless process." },
        { "title": "Instant Pricing", "description": "Get transparent and instant pricing for your project with no hidden costs." },
        { "title": "Expertise & Passion", "description": "Our team''s dedication and passion shine through in every detail." }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 6, true),
((SELECT id FROM pages WHERE slug = 'home'), 'what_we_do', 'What We Do', $$
{
    "title": "What We Do",
    "subtitle": "Discover our range of products and find what suits your style.",
    "trendingItems": [
        { "name": "L-Shaped Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-1.jpg", "hint": "l-shaped kitchen" },
        { "name": "Sliding Door Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-2.jpg", "hint": "sliding wardrobe" },
        { "name": "Minimalist TV Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-3.jpg", "hint": "tv unit" },
        { "name": "Modern Crockery Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-4.jpg", "hint": "crockery unit" }
    ],
    "bestSellingKitchens": [
        { "name": "U-Shaped Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "hint": "u-shaped kitchen" },
        { "name": "Island Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "hint": "island kitchen" },
        { "name": "Parallel Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "hint": "parallel kitchen" },
        { "name": "Straight Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-4.png", "hint": "straight kitchen" }
    ],
    "bestSellingWardrobes": [
        { "name": "Hinged Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "hint": "hinged wardrobe" },
        { "name": "Walk-in Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "hint": "walk-in wardrobe" },
        { "name": "Wardrobe with Mirror", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-3.jpg", "hint": "mirrored wardrobe" },
        { "name": "Freestanding Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-4.jpg", "hint": "freestanding wardrobe" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" }
}
$$, 7, true),
((SELECT id FROM pages WHERE slug = 'home'), 'testimonials', 'Testimonials', $$
{
    "title": "Happy Clients",
    "subtitle": "Don''t just take our word for it. Here’s what our clients have to say.",
    "buttonText": "View All Testimonials",
    "items": [
        { "name": "Rohan Sharma", "review": "Shriram Interio transformed our home! The team was professional, creative, and delivered beyond our expectations. Highly recommended!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg" },
        { "name": "Priya Mehta", "review": "The modular kitchen is a dream come true. Flawless execution and premium quality materials. The design process was so smooth.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg" },
        { "name": "Amit Deshpande", "review": "Excellent service from start to finish. They understood our needs perfectly and created a space that is both beautiful and functional.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "buttonText": { "type": "text", "label": "Button Text" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 8, true),
((SELECT id FROM pages WHERE slug = 'home'), 'faq', 'FAQ', $$
{
    "title": "Frequently Asked Questions",
    "subtitle": "Have questions? We have answers.",
    "items": [
        { "question": "What is the typical timeline for a project?", "answer": "A typical project, like a modular kitchen or wardrobe, takes about 4-6 weeks from design approval to installation. Full home interiors can take 8-12 weeks depending on the scope." },
        { "question": "Do you provide a warranty?", "answer": "Yes, we provide a 5-year warranty on all our modular products against any manufacturing defects. We also offer after-sales support to ensure your satisfaction." },
        { "question": "Can I see the materials before finalizing?", "answer": "Absolutely! We have a wide range of material samples at our showroom. We encourage you to visit and experience the quality and finish of our products firsthand." },
        { "question": "What are the payment terms?", "answer": "We typically have a phased payment plan. It starts with a booking amount, followed by payments at different stages of the project like design finalization, production, and post-installation." }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 9, true),
((SELECT id FROM pages WHERE slug = 'home'), 'partners', 'Partners', $$
{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY YOU CAN TRUST",
    "items": [
        { "name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png" },
        { "name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png" },
        { "name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png" },
        { "name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png" },
        { "name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 10, true),

-- ABOUT US PAGE
((SELECT id FROM pages WHERE slug = 'about'), 'hero', 'Hero', $$
{
  "title": "About Shriram Interio",
  "subtitle": "Crafting beautiful spaces since 2016",
  "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-hero.jpg"
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "backgroundImage": { "type": "image", "label": "Background Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'about'), 'story', 'Story', $$
{
  "heading": "Our Story",
  "subheading": "A Journey of Passion and Design",
  "paragraph1": "SHRIRAM INTERIO began in 2016 with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. What started as a small, passionate team has grown into a leading interior design firm in Pune, known for our commitment to excellence.",
  "paragraph2": "Our journey is one of continuous learning and adaptation. We stay at the forefront of design trends, materials, and technology to ensure we are always offering our clients the very best. We believe every space has a story to tell, and our mission is to help you write it.",
  "paragraph3": "From humble beginnings, we have completed hundreds of projects, each one a testament to our dedication and craftsmanship. Our portfolio is a diverse collection of dreams we have helped realize.",
  "paragraph4": "We are more than just designers; we are creators of experience, dedicated to making your dream home a tangible reality.",
  "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-story.jpg"
}
$$, $$
{
  "heading": { "type": "text", "label": "Heading" },
  "subheading": { "type": "text", "label": "Subheading" },
  "paragraph1": { "type": "textarea", "label": "Paragraph 1" },
  "paragraph2": { "type": "textarea", "label": "Paragraph 2" },
  "paragraph3": { "type": "textarea", "label": "Paragraph 3" },
  "paragraph4": { "type": "textarea", "label": "Paragraph 4" },
  "image": { "type": "image", "label": "Image" }
}
$$, 2, true),
((SELECT id FROM pages WHERE slug = 'about'), 'journey', 'Journey', $$
{
    "heading": "Our Journey",
    "paragraph1": "Our journey has been one of growth, learning, and unwavering commitment to our clients. We have navigated the evolving landscape of interior design, embracing new technologies and sustainable practices to deliver spaces that are not only beautiful but also responsible.",
    "paragraph2": "Each project has been a stepping stone, teaching us invaluable lessons and helping us refine our process. The challenges we''ve faced have only strengthened our resolve to deliver perfection.",
    "paragraph3": "We are proud of the relationships we have built with our clients, partners, and vendors. These partnerships are the bedrock of our success and continue to inspire us.",
    "paragraph4": "Looking ahead, we are excited to continue pushing the boundaries of design and creating spaces that inspire and delight for years to come.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-journey.jpg"
}
$$, $$
{
    "heading": { "type": "text", "label": "Heading" },
    "paragraph1": { "type": "textarea", "label": "Paragraph 1" },
    "paragraph2": { "type": "textarea", "label": "Paragraph 2" },
    "paragraph3": { "type": "textarea", "label": "Paragraph 3" },
    "paragraph4": { "type": "textarea", "label": "Paragraph 4" },
    "image": { "type": "image", "label": "Image" }
}
$$, 3, true),
((SELECT id FROM pages WHERE slug = 'about'), 'values', 'Values', $$
{
    "title": "Our Core Values",
    "subtitle": "The principles that guide us in everything we do.",
    "items": [
        { "title": "Expert Design Team", "description": "Our team of experienced designers works with you to bring your vision to life." },
        { "title": "Variety of Design Choices", "description": "Choose from a wide range of styles, materials, and finishes to suit your taste." },
        { "title": "Affordable Design Fees", "description": "We offer competitive pricing without compromising on quality or service." },
        { "title": "On-Time Project Delivery", "description": "We value your time and ensure timely completion of all our projects." }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 4, true),
((SELECT id FROM pages WHERE slug = 'about'), 'mission_vision', 'Mission & Vision', $$
{
  "missionTitle": "Our Mission",
  "missionText": "To create exceptional living spaces through innovative design, superior craftsmanship, and a client-centric approach. We aim to exceed expectations and build lasting relationships based on trust and satisfaction.",
  "visionTitle": "Our Vision",
  "visionText": "To be Pune''s most trusted and sought-after interior design firm, known for our creativity, quality, and commitment to transforming houses into dream homes."
}
$$, $$
{
  "missionTitle": { "type": "text", "label": "Mission Title" },
  "missionText": { "type": "textarea", "label": "Mission Text" },
  "visionTitle": { "type": "text", "label": "Vision Title" },
  "visionText": { "type": "textarea", "label": "Vision Text" }
}
$$, 5, true),
((SELECT id FROM pages WHERE slug = 'about'), 'team', 'Team', $$
{
  "title": "Meet the Team",
  "subtitle": "The creative minds behind Shriram Interio.",
  "members": [
    { "name": "Shriram P.", "role": "Founder & Lead Designer", "bio": "With over a decade of experience, Shriram leads the team with a passion for creating unique and functional spaces.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg" },
    { "name": "Anjali K.", "role": "Project Manager", "bio": "Anjali ensures that every project is executed flawlessly, on time, and within budget, with meticulous attention to detail.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg" },
    { "name": "Vikram S.", "role": "Head of Operations", "bio": "Vikram oversees the entire operations, from material procurement to final installation, ensuring quality at every step.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-3.jpg" }
  ]
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "members": { "type": "repeater", "label": "Team Members" }
}
$$, 6, true),

-- CUSTOMER STORIES PAGE
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'header', 'Header', $$
{
    "title": "Customer Stories",
    "subtitle": "Discover the real-life stories behind our designs. See how we''ve transformed spaces and lives through creativity and collaboration."
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'featured_story', 'Featured Story', $$
{
    "buttonText": "Read Full Story"
}
$$, $$
{
    "buttonText": { "type": "text", "label": "Button Text" }
}
$$, 2, true),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'more_stories', 'More Stories', $$
{
    "title": "More Client Stories"
}
$$, $$
{
    "title": { "type": "text", "label": "Title" }
}
$$, 3, true),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'work_gallery', 'Work Gallery', $$
{
    "title": "Our Work Gallery",
    "subtitle": "Explore our portfolio of beautifully designed and executed projects.",
    "items": [
        { "title": "Modern Living Room", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "hint": "living room" },
        { "title": "Elegant Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "hint": "elegant kitchen" },
        { "title": "Cozy Bedroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-3.jpg", "hint": "cozy bedroom" },
        { "title": "Stylish Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-4.jpg", "hint": "stylish wardrobe" },
        { "title": "Functional Study Area", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-5.jpg", "hint": "study area" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 4, true),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'partners', 'Partners', $$
{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY YOU CAN TRUST",
    "items": [
        { "name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png" },
        { "name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png" },
        { "name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png" },
        { "name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png" },
        { "name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 5, true),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'faq', 'FAQ', $$
{
    "title": "Frequently Asked Questions",
    "subtitle": "Have questions? We have answers.",
    "items": [
        { "question": "What is the typical timeline for a project?", "answer": "A typical project, like a modular kitchen or wardrobe, takes about 4-6 weeks from design approval to installation. Full home interiors can take 8-12 weeks depending on the scope." },
        { "question": "Do you provide a warranty?", "answer": "Yes, we provide a 5-year warranty on all our modular products against any manufacturing defects. We also offer after-sales support to ensure your satisfaction." },
        { "question": "Can I see the materials before finalizing?", "answer": "Absolutely! We have a wide range of material samples at our showroom. We encourage you to visit and experience the quality and finish of our products firsthand." },
        { "question": "What are the payment terms?", "answer": "We typically have a phased payment plan. It starts with a booking amount, followed by payments at different stages of the project like design finalization, production, and post-installation." }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 6, true),

-- CLIENTS PAGE
((SELECT id FROM pages WHERE slug = 'clients'), 'featured_testimonial', 'Featured Testimonial', $$
{
  "name": "Sameer Joshi",
  "location": "Baner, Pune",
  "project": "Full Home Interior",
  "size": "3 BHK",
  "quote": "An absolute pleasure to work with from start to finish.",
  "review": "The team at Shriram Interio took our vague ideas and turned them into a stunning reality. Their attention to detail, commitment to quality, and transparent communication made the entire process stress-free. Our home feels like a personalized sanctuary now. We couldn''t be happier with the outcome and wholeheartedly recommend their services to anyone looking for top-notch interior design.",
  "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-featured.jpg"
}
$$, $$
{
  "name": { "type": "text", "label": "Client Name" },
  "location": { "type": "text", "label": "Location" },
  "project": { "type": "text", "label": "Project Type" },
  "size": { "type": "text", "label": "Property Size" },
  "quote": { "type": "textarea", "label": "Highlight Quote" },
  "review": { "type": "textarea", "label": "Full Review" },
  "image": { "type": "image", "label": "Client Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'clients'), 'video_testimonials', 'Video Testimonials', $$
{
  "title": "Hear From Our Clients",
  "subtitle": "Watch our clients share their experiences working with Shriram Interio.",
  "videos": [
    {
      "name": "The Mehta Family",
      "location": "Koregaon Park, Pune",
      "review": "Our kitchen is now the heart of our home, thanks to the amazing team!",
      "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-thumb-1.jpg",
      "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "dataAiHint": "happy family kitchen"
    },
    {
      "name": "Anika and Rohan",
      "location": "Hinjewadi, Pune",
      "review": "The wardrobe design maximized our space and looks so elegant.",
      "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-thumb-2.jpg",
      "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "dataAiHint": "couple bedroom"
    },
    {
      "name": "Mr. Deshpande",
      "location": "Aundh, Pune",
      "review": "A truly professional and seamless experience for our full home interior.",
      "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-thumb-3.jpg",
      "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      "dataAiHint": "man living room"
    }
  ]
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "videos": { "type": "repeater", "label": "Videos" }
}
$$, 2, true),
((SELECT id FROM pages WHERE slug = 'clients'), 'text_testimonials', 'Text Testimonials', $$
{
  "title": "What Our Clients Are Saying",
  "subtitle": "Honest feedback from homeowners we''ve had the pleasure to work with.",
  "testimonials": [
    {
      "review": "The quality of materials and the finishing is top-notch. Our home feels so luxurious now.",
      "name": "Sneha Patil",
      "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg",
      "avatar": "SP"
    },
    {
      "review": "I was impressed with their design process. The 3D views helped me visualize everything perfectly.",
      "name": "Rajesh Kumar",
      "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-4.jpg",
      "avatar": "RK"
    },
    {
      "review": "On-time delivery as promised! A rare quality. The installation team was professional and efficient.",
      "name": "Deepa Iyer",
      "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-5.jpg",
      "avatar": "DI"
    },
     {
      "review": "They have a great variety of design choices. I found the perfect style that matched my personality.",
      "name": "Aditya Singh",
      "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-6.jpg",
      "avatar": "AS"
    },
     {
      "review": "The team is very responsive and accommodating. They listened to all my ideas and incorporated them beautifully.",
      "name": "Fatima Khan",
      "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg",
      "avatar": "FK"
    },
     {
      "review": "Value for money! The quality you get for the price is unbeatable in the Pune market. Highly satisfied.",
      "name": "Vikram Rathod",
      "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg",
      "avatar": "VR"
    }
  ]
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "testimonials": { "type": "repeater", "label": "Testimonials" }
}
$$, 3, true),

-- SERVICES PAGE
((SELECT id FROM pages WHERE slug = 'services'), 'header', 'Header', $$
{
  "title": "Our Services",
  "subtitle": "Comprehensive design solutions tailored to your lifestyle and budget."
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'services'), 'our_services', 'Our Services', $$
{
  "services": [
    { "title": "Modular Kitchen Design", "description": "Creating functional and beautiful kitchens that are the heart of the home." },
    { "title": "Wardrobe & Storage Solutions", "description": "Customized wardrobes and storage units to maximize space and style." },
    { "title": "Bedroom Interiors", "description": "Designing serene and personal sanctuaries for rest and relaxation." },
    { "title": "Living Area Design", "description": "Crafting welcoming and stylish living spaces for family and guests." },
    { "title": "Exterior Design Services", "description": "Enhancing curb appeal with our expert exterior design solutions." },
    { "title": "Full Home Interiors", "description": "A complete, end-to-end design service for your entire home." }
  ]
}
$$, $$
{
  "services": { "type": "repeater", "label": "Services" }
}
$$, 2, true),
((SELECT id FROM pages WHERE slug = 'services'), 'detailed_services', 'Detailed Services', $$
{
  "services": [
    { "title": "Modular Kitchens", "href": "/products/kitchen", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-card.jpg", "dataAiHint": "modular kitchen" },
    { "title": "Wardrobes", "href": "/products/wardrobe", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-card.jpg", "dataAiHint": "bedroom wardrobe" },
    { "title": "Living Room Interiors", "href": "/products/living-room", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/living-room-card.jpg", "dataAiHint": "modern living room" }
  ]
}
$$, $$
{
  "services": { "type": "repeater", "label": "Services" }
}
$$, 3, true),

-- PORTFOLIO PAGE
((SELECT id FROM pages WHERE slug = 'portfolio'), 'projects_gallery', 'Projects Gallery', $$
{
  "projects": [
    { "id": 1, "title": "Modern Minimalist Living", "category": "Living Areas", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-1.jpg", "dataAiHint": "minimalist living room" },
    { "id": 2, "title": "Elegant U-Shaped Kitchen", "category": "Kitchens", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-2.jpg", "dataAiHint": "u-shaped kitchen" },
    { "id": 3, "title": "Sleek Sliding Wardrobe", "category": "Wardrobes", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-3.jpg", "dataAiHint": "sliding wardrobe" },
    { "id": 4, "title": "Cozy & Compact Bedroom", "category": "Bedrooms", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-4.jpg", "dataAiHint": "compact bedroom" },
    { "id": 5, "title": "Vibrant Family Room", "category": "Living Areas", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-5.jpg", "dataAiHint": "family living room" },
    { "id": 6, "title": "High-Gloss Parallel Kitchen", "category": "Kitchens", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-6.jpg", "dataAiHint": "glossy kitchen" }
  ]
}
$$, $$
{
  "projects": { "type": "repeater", "label": "Projects" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'portfolio'), 'partners', 'Partners', $$
{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY YOU CAN TRUST",
    "items": [
        { "name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png" },
        { "name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png" },
        { "name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png" },
        { "name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png" },
        { "name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png" }
    ]
}
$$, $$
{
    "title": { "type": "text", "label": "Title" },
    "subtitle": { "type": "textarea", "label": "Subtitle" },
    "items": { "type": "repeater", "label": "Items" }
}
$$, 2, true),

-- HOW IT WORKS PAGE
((SELECT id FROM pages WHERE slug = 'how-it-works'), 'hero', 'Hero', $$
{
  "title": "Our Process",
  "subtitle": "A simple, transparent, and collaborative journey to your dream home.",
  "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/process-hero.jpg"
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "backgroundImage": { "type": "image", "label": "Background Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'how-it-works'), 'process', 'Process', $$
{
  "title": "How It Works",
  "subtitle": "Your dream home is just 5 simple steps away.",
  "steps": [
    { "icon": "Handshake", "title": "Consultation", "description": "We start with a free consultation to understand your needs, style, and budget. We listen to your ideas and provide our expert input." },
    { "icon": "PencilRuler", "title": "Design & 3D Visualization", "description": "Our designers create a customized plan with 2D layouts and realistic 3D views, so you can see exactly how your space will look." },
    { "icon": "MessageSquareQuote", "title": "Material Selection & Quotation", "description": "We help you choose the best materials and finishes. You''ll receive a detailed, transparent quotation with no hidden costs." },
    { "icon": "Truck", "title": "Production & Delivery", "description": "Once approved, your custom interiors are manufactured at our state-of-the-art facility and delivered to your doorstep." },
    { "icon": "ShieldCheck", "title": "Installation & Handover", "description": "Our professional team handles the installation with precision. We conduct a final quality check and hand over your brand new interiors, complete with a warranty." }
  ]
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "steps": { "type": "repeater", "label": "Process Steps" }
}
$$, 2, true),
((SELECT id FROM pages WHERE slug = 'how-it-works'), 'why_us', 'Why Us', $$
{
  "title": "Why Our Process Works",
  "subtitle": "We have refined our process to be efficient, transparent, and client-focused.",
  "benefits": [
    { "icon": "ThumbsUp", "title": "Client-Centric", "description": "Your needs and vision are at the core of everything we do. We collaborate closely with you at every stage." },
    { "icon": "Wallet", "title": "Transparent Pricing", "description": "No surprises. We provide detailed quotes and ensure you know what you''re paying for from the very beginning." },
    { "icon": "Smile", "title": "Hassle-Free Experience", "description": "We manage the entire project, from design to execution, ensuring a smooth and stress-free journey for you." }
  ]
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "benefits": { "type": "repeater", "label": "Benefits" }
}
$$, 3, true),
((SELECT id FROM pages WHERE slug = 'how-it-works'), 'get_started', 'Get Started', $$
{
  "title": "Ready to Start Your Project?",
  "subtitle": "Let''s create a space you''ll love. Schedule a free consultation with our design experts today.",
  "buttonText": "Book Free Consultation"
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" },
  "buttonText": { "type": "text", "label": "Button Text" }
}
$$, 4, true),

-- PRODUCTS PAGE
((SELECT id FROM pages WHERE slug = 'products'), 'header', 'Header', $$
{
  "title": "Our Products",
  "subtitle": "Explore our curated range of high-quality home interior products."
}
$$, $$
{
  "title": { "type": "text", "label": "Title" },
  "subtitle": { "type": "textarea", "label": "Subtitle" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'products'), 'product_list', 'Product List', $$
{
  "products": [
    { "name": "Modular Kitchens", "href": "/products/kitchen", "description": "Ergonomic designs, premium finishes, and smart storage.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-kitchen.jpg", "dataAiHint": "modular kitchen" },
    { "name": "Wardrobes", "href": "/products/wardrobe", "description": "Customized storage solutions that blend style and functionality.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-wardrobe.jpg", "dataAiHint": "modern wardrobe" },
    { "name": "Living Room", "href": "/products/living-room", "description": "Stylish and comfortable furniture for your living space.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-living.jpg", "dataAiHint": "living room" },
    { "name": "Bedroom", "href": "/products/bedroom", "description": "Create a serene and personal retreat with our bedroom furniture.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-bedroom.jpg", "dataAiHint": "cozy bedroom" },
    { "name": "Bathroom", "href": "/products/bathroom", "description": "Modern fittings and vanities for a refreshing bathroom space.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-bathroom.jpg", "dataAiHint": "modern bathroom" },
    { "name": "Home Office", "href": "/products/home-office", "description": "Productive and stylish workspaces tailored for your home.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-office.jpg", "dataAiHint": "home office" },
    { "name": "Space Saving Furniture", "href": "/products/space-saving-furniture", "description": "Innovative solutions to maximize space in compact homes.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-space-saving.jpg", "dataAiHint": "space saving furniture" }
  ]
}
$$, $$
{
  "products": { "type": "repeater", "label": "Products" }
}
$$, 2, true),
-- Individual Product Pages
((SELECT id FROM pages WHERE slug = 'product-living-room'), 'product_details', 'Product Details', $$
{
    "title": "Living Room Furniture",
    "description": "Create a living room that is both inviting and stylish with our range of furniture. From comfortable sofas to elegant TV units, we offer everything you need to make your living space the heart of your home. Our designs focus on combining aesthetics with practicality, ensuring your living room is perfect for both relaxation and entertaining.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-living.jpg"
}
$$, $$
{
    "title": { "type": "text", "label": "Product Title" },
    "description": { "type": "textarea", "label": "Product Description" },
    "image": { "type": "image", "label": "Product Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'product-bedroom'), 'product_details', 'Product Details', $$
{
    "title": "Bedroom Furniture",
    "description": "Transform your bedroom into a personal sanctuary with our collection of beds, side tables, and dressers. We focus on creating a tranquil and comfortable atmosphere, with furniture that is both beautiful and built to last. Choose from a variety of styles to match your personal taste and create the bedroom of your dreams.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-bedroom.jpg"
}
$$, $$
{
    "title": { "type": "text", "label": "Product Title" },
    "description": { "type": "textarea", "label": "Product Description" },
    "image": { "type": "image", "label": "Product Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'product-bathroom'), 'product_details', 'Product Details', $$
{
    "title": "Bathroom Fittings & Vanities",
    "description": "Upgrade your bathroom with our modern and durable fittings and vanities. We offer a range of products that combine sleek design with functionality, helping you create a refreshing and organized bathroom space. Our high-quality materials ensure longevity and ease of maintenance.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-bathroom.jpg"
}
$$, $$
{
    "title": { "type": "text", "label": "Product Title" },
    "description": { "type": "textarea", "label": "Product Description" },
    "image": { "type": "image", "label": "Product Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'product-home-office'), 'product_details', 'Product Details', $$
{
    "title": "Home Office Furniture",
    "description": "Design a home office that inspires productivity and comfort. Our range of desks, chairs, and storage solutions are designed to create an ergonomic and stylish workspace. Whether you have a dedicated room or a small corner, we have solutions to fit your needs.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-office.jpg"
}
$$, $$
{
    "title": { "type": "text", "label": "Product Title" },
    "description": { "type": "textarea", "label": "Product Description" },
    "image": { "type": "image", "label": "Product Image" }
}
$$, 1, true),
((SELECT id FROM pages WHERE slug = 'product-space-saving-furniture'), 'product_details', 'Product Details', $$
{
    "title": "Space-Saving Furniture",
    "description": "Make the most of every square foot with our innovative space-saving furniture. Ideal for modern apartments and compact homes, our collection includes wall-mounted desks, foldable dining tables, and sofa-cum-beds. Enjoy a clutter-free and functional living space without compromising on style.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-space-saving.jpg"
}
$$, $$
{
    "title": { "type": "text", "label": "Product Title" },
    "description": { "type": "textarea", "label": "Product Description" },
    "image": { "type": "image", "label": "Product Image" }
}
$$, 1, true),

-- NO EDITABLE CONTENT FOR CONTACT PAGE, IT IS STATIC
((SELECT id FROM pages WHERE slug = 'contact'), 'static_content', 'Static Content', '{}'::jsonb, '{}'::jsonb, 1, true)

ON CONFLICT (page_id, type) DO UPDATE SET
title = EXCLUDED.title,
content = EXCLUDED.content,
content_structure = EXCLUDED.content_structure,
"order" = EXCLUDED."order",
visible = EXCLUDED.visible;

-- Seed stories
INSERT INTO stories (id, slug, title, category, date, author, authorAvatar, excerpt, image, dataAiHint, content, clientImage, location, project, size, quote, gallery) VALUES
(1, 'modern-kitchen-makeover-pune', 'Modern Kitchen Makeover in Pune', 'Kitchens', 'June 15, 2024', 'Priya Mehta', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg', 'See how we transformed a cramped kitchen into a spacious, modern culinary haven for the Mehta family in Koregaon Park.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-main.jpg', 'modern kitchen', 'The Mehta family wanted a kitchen that was not only beautiful but also highly functional for their daily cooking needs. We completely redesigned the layout, incorporating an L-shaped counter, smart storage solutions, and high-end finishes. The result is a bright, airy, and efficient kitchen that has become the heart of their home.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg', 'Koregaon Park, Pune', 'Modular Kitchen', '250 sqft', 'Our kitchen is now our favorite part of the house!', '[
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-1.jpg", "alt": "Kitchen before renovation", "dataAiHint": "old kitchen"},
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-2.jpg", "alt": "Kitchen after renovation", "dataAiHint": "new kitchen"},
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-3.jpg", "alt": "Smart storage solution", "dataAiHint": "kitchen storage"}
]'),
(2, 'luxury-living-room-design', 'Luxury Living Room for the Sharma Family', 'Living Areas', 'May 28, 2024', 'Rohan Sharma', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg', 'A complete overhaul of a living area in Baner, creating a luxurious and welcoming space for relaxation and entertainment.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-main.jpg', 'luxury living room', 'The Sharmas wanted a living room that exuded elegance and comfort. Our design included a custom entertainment unit, plush seating, and sophisticated lighting. We used a neutral color palette with bold accents to create a timeless and inviting atmosphere. The project was completed with bespoke furniture and curated decor pieces.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg', 'Baner, Pune', 'Living Room Interior', '400 sqft', 'The team delivered a space that perfectly reflects our style.', '[
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-1.jpg", "alt": "Living room before", "dataAiHint": "outdated living room"},
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-2.jpg", "alt": "Living room after", "dataAiHint": "modern living room"},
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-3.jpg", "alt": "Custom entertainment unit", "dataAiHint": "tv unit design"}
]'),
(3, 'compact-bedroom-wardrobe-solution', 'Smart Wardrobe Solution for a Compact Bedroom', 'Wardrobes', 'June 05, 2024', 'Anika and Rohan', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-4.jpg', 'Maximizing storage in a compact bedroom in Hinjewadi with a custom-designed sliding wardrobe and study unit.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-3-main.jpg', 'bedroom wardrobe', 'For this project, the challenge was to create ample storage without making the room feel cramped. We designed a floor-to-ceiling sliding wardrobe with a reflective finish to create an illusion of space. An integrated study nook was also incorporated, making the room multi-functional. The client was thrilled with the smart and stylish solution.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-4.jpg', 'Hinjewadi, Pune', 'Wardrobe & Study Unit', '150 sqft', 'They made our small room feel so much bigger and more functional!', '[
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-3-gallery-1.jpg", "alt": "Bedroom before", "dataAiHint": "small bedroom"},
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-3-gallery-2.jpg", "alt": "Bedroom after with wardrobe", "dataAiHint": "bedroom sliding wardrobe"},
  {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-3-gallery-3.jpg", "alt": "Integrated study unit", "dataAiHint": "study nook"}
]')
ON CONFLICT (id) DO UPDATE SET
slug = EXCLUDED.slug,
title = EXCLUDED.title,
category = EXCLUDED.category,
date = EXCLUDED.date,
author = EXCLUDED.author,
authorAvatar = EXCLUDED.authorAvatar,
excerpt = EXCLUDED.excerpt,
image = EXCLUDED.image,
dataAiHint = EXCLUDED.dataAiHint,
content = EXCLUDED.content,
clientImage = EXCLUDED.clientImage,
location = EXCLUDED.location,
project = EXCLUDED.project,
size = EXCLUDED.size,
quote = EXCLUDED.quote,
gallery = EXCLUDED.gallery;
