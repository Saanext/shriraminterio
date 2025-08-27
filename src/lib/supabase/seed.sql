-- Drop tables if they exist to start fresh
DROP TABLE IF EXISTS "sections";
DROP TABLE IF EXISTS "stories";
DROP TABLE IF EXISTS "pages";

-- Create Pages Table
CREATE TABLE pages (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    meta_title TEXT,
    meta_description TEXT
);

-- Create Sections Table
CREATE TABLE sections (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    page_id BIGINT REFERENCES pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    "order" INT NOT NULL,
    visible BOOLEAN DEFAULT true,
    content JSONB,
    content_structure JSONB,
    UNIQUE(page_id, type)
);

-- Create Stories Table
CREATE TABLE stories (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    date TEXT NOT NULL,
    author TEXT NOT NULL,
    authorAvatar TEXT,
    image TEXT NOT NULL,
    dataAiHint TEXT,
    excerpt TEXT,
    content TEXT,
    quote TEXT,
    clientImage TEXT,
    location TEXT,
    project TEXT,
    size TEXT,
    gallery JSONB
);

-- Create Storage Bucket for Public Assets
INSERT INTO storage.buckets (id, name, public)
VALUES ('public', 'public', true)
ON CONFLICT (id) DO NOTHING;

-- Set up access policies for the public bucket
-- Allow public read access
CREATE POLICY "Public read access" ON storage.objects
FOR SELECT USING (bucket_id = 'public');

-- Allow authenticated users to upload, update, and delete
CREATE POLICY "Authenticated users can manage own files" ON storage.objects
FOR ALL USING (auth.role() = 'authenticated') WITH CHECK (auth.role() = 'authenticated');


-- Insert Pages Data
INSERT INTO pages (slug, title, meta_title, meta_description) VALUES
('home', 'Home', 'Shriram Interio | Pune''s Top Interior Designers', 'Shriram Interio offers the best interior design services in Pune. We specialize in modular kitchens, wardrobes, and complete home interiors.'),
('about', 'About Us', 'About Shriram Interio | Our Story & Team', 'Learn about Shriram Interio, our journey since 2016, our mission, vision, and the talented team of designers who make it all happen.'),
('customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio', 'Read inspiring stories from our happy clients. See how we transformed their homes and lives with our interior design expertise.'),
('clients', 'Clients', 'Our Valued Clients | Testimonials & Reviews', 'See what our clients have to say about their experience with Shriram Interio. Read testimonials and watch video reviews from satisfied homeowners in Pune.'),
('services', 'Services', 'Our Services | Interior Design Solutions', 'Explore our comprehensive interior design services, including modular kitchens, wardrobe solutions, full home interiors, and more.'),
('portfolio', 'Portfolio', 'Our Portfolio | Shriram Interio Design Gallery', 'Browse our portfolio of completed projects. Get inspired by our stunning interior designs for kitchens, bedrooms, living rooms, and more.'),
('how-it-works', 'How It Works', 'Our Process | From Concept to Completion', 'Learn about our streamlined interior design process. From initial consultation to final handover, we make your dream home a reality.'),
('products', 'Products', 'Our Products | High-Quality Interior Solutions', 'Discover our range of high-quality interior design products, including modular kitchens, custom wardrobes, furniture, and more.'),
('contact', 'Contact Us', 'Contact Shriram Interio | Get in Touch', 'Contact us for a free consultation. Visit our office, call us, or fill out our online form to start your interior design journey.'),
('product-kitchen', 'product-kitchen', 'Modular Kitchens', 'Modular Kitchens by Shriram Interio.'),
('product-wardrobe', 'product-wardrobe', 'Wardrobes', 'Wardrobes by Shriram Interio.'),
('product-living-room', 'product-living-room', 'Living Room Furniture', 'Living Room Furniture by Shriram Interio.'),
('product-bedroom', 'product-bedroom', 'Bedroom Furniture', 'Bedroom Furniture by Shriram Interio.'),
('product-bathroom', 'product-bathroom', 'Bathroom Interiors', 'Bathroom Interiors by Shriram Interio.'),
('product-home-office', 'product-home-office', 'Home Office Furniture', 'Home Office Furniture by Shriram Interio.'),
('product-space-saving-furniture', 'product-space-saving-furniture', 'Space-Saving Furniture', 'Space-Saving Furniture by Shriram Interio.')
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    meta_title = EXCLUDED.meta_title,
    meta_description = EXCLUDED.meta_description;


-- Insert Sections Data
-- Note: page_id is a subquery to get the id from the pages table based on the slug.
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
-- Home Page Sections
((SELECT id from pages where slug = 'home'), 'hero', 'Hero Section', 1, true, '{
    "title": "Crafting Your Dream Home, One Detail at a Time",
    "subtitle": "Discover Pune''s finest interior design solutions, from stunning modular kitchens to elegant full-home interiors. Let us bring your vision to life.",
    "buttonText": "Explore Our Designs",
    "videoUrl": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-video.mp4",
    "slides": [
        {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg"},
        {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-2.jpg"},
        {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-3.jpg"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"},
    "videoUrl": {"type": "text", "label": "Background Video URL"},
    "slides": {"type": "repeater", "label": "Image Slides", "fields": {
        "image": {"type": "image", "label": "Slide Image"}
    }}
}'),
((SELECT id from pages where slug = 'home'), 'welcome', 'Welcome Section', 2, true, '{
    "paragraph1": "At Shriram Interio, we believe that a home is more than just a place to live; it''s a reflection of who you are. Our mission is to translate your personality and dreams into beautifully designed, functional spaces that you''ll love for years to come.",
    "paragraph2": "With a passion for creativity and an unwavering commitment to quality, our team of experienced designers works closely with you to understand your needs and aspirations. We blend artistry with practicality to deliver personalized interior solutions that exceed expectations.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/welcome.jpg"
}', '{
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "image": {"type": "image", "label": "Image"}
}'),
((SELECT id from pages where slug = 'home'), 'about_company', 'About Company Section', 3, true, '{
    "title": "Your Vision, Our Expertise",
    "text": "Your trusted partner in transforming spaces into personalized sanctuaries of style and comfort. Based in Pune, we are a premier interior design firm specializing in creating bespoke environments that reflect your unique taste and lifestyle. Our philosophy is simple: to craft interiors that are not only visually stunning but also deeply functional and enduring."
}', '{
    "title": {"type": "text", "label": "Title"},
    "text": {"type": "textarea", "label": "Text"}
}'),
((SELECT id from pages where slug = 'home'), 'why_us', 'Why Us Section', 4, true, '{
    "title": "Why Shriram Interio?",
    "subtitle": "Your home is a sanctuary, and we''re dedicated to making it perfect.",
    "items": [
        {"title": "Expert Design Team", "description": "Our team of skilled designers brings creativity and expertise to every project."},
        {"title": "Variety of Design Choices", "description": "We offer a wide range of design options to suit your unique style and preferences."},
        {"title": "Affordable Design Fees", "description": "Get premium design services at competitive prices, ensuring value for your investment."},
        {"title": "On-Time Project Delivery", "description": "We adhere to strict timelines to ensure your project is completed without delays."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Items", "fields": {
        "title": {"type": "text", "label": "Item Title"},
        "description": {"type": "textarea", "label": "Item Description"}
    }}
}'),
((SELECT id from pages where slug = 'home'), 'work_gallery', 'Work Gallery Section', 5, true, '{
    "title": "Our Work Gallery",
    "subtitle": "Explore our portfolio of stunning interior designs.",
    "items": [
        {"title": "L-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "hint": "modular kitchen"},
        {"title": "U-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "hint": "u-shaped kitchen"},
        {"title": "Straight Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-3.jpg", "hint": "straight kitchen"},
        {"title": "Island Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-4.jpg", "hint": "island kitchen"},
        {"title": "Parallel Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-5.jpg", "hint": "parallel kitchen"},
        {"title": "G-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-6.jpg", "hint": "g-shaped kitchen"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Gallery Items", "fields": {
        "title": {"type": "text", "label": "Item Title"},
        "image": {"type": "image", "label": "Item Image"},
        "hint": {"type": "text", "label": "AI Hint"}
    }}
}'),
((SELECT id from pages where slug = 'home'), 'comfort_design', 'Comfort Design Section', 6, true, '{
    "title": "Design at Your Comfort",
    "subtitle": "We bring your vision to life with a seamless and transparent process.",
    "items": [
        {"title": "Live 3D Designs", "description": "Visualize your space with our cutting-edge 3D design technology."},
        {"title": "Contactless Experience", "description": "From consultation to project management, we offer a safe, remote experience."},
        {"title": "Instant Pricing", "description": "Get transparent and upfront pricing with no hidden costs."},
        {"title": "Expertise & Passion", "description": "Our team''s dedication and passion shine through in every detail."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Items", "fields": {
        "title": {"type": "text", "label": "Item Title"},
        "description": {"type": "textarea", "label": "Item Description"}
    }}
}'),
((SELECT id from pages where slug = 'home'), 'what_we_do', 'What We Do Section', 7, true, '{
    "title": "What We Do",
    "subtitle": "Discover our range of interior design solutions.",
    "trendingItems": [
        {"name": "Trending Modular Kitchens", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-1.jpg", "hint": "modern kitchen"},
        {"name": "Trending Living Rooms", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-2.jpg", "hint": "stylish living room"},
        {"name": "Trending Wardrobes", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-3.jpg", "hint": "sleek wardrobe"},
        {"name": "Trending Bedrooms", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-4.jpg", "hint": "cozy bedroom"}
    ],
    "bestSellingKitchens": [
        {"name": "L-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-kitchen-1.jpg", "hint": "l-shaped kitchen"},
        {"name": "U-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-kitchen-2.jpg", "hint": "u-shaped kitchen"},
        {"name": "Straight Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-kitchen-3.jpg", "hint": "straight kitchen"},
        {"name": "Island Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-kitchen-4.jpg", "hint": "island kitchen"}
    ],
    "bestSellingWardrobes": [
        {"name": "Sliding Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-wardrobe-1.jpg", "hint": "sliding wardrobe"},
        {"name": "Hinged Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-wardrobe-2.jpg", "hint": "hinged wardrobe"},
        {"name": "Walk-in Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-wardrobe-3.jpg", "hint": "walk-in wardrobe"},
        {"name": "Fitted Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bestselling-wardrobe-4.jpg", "hint": "fitted wardrobe"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "trendingItems": {"type": "repeater", "label": "Trending Items", "fields": {"name": {"type": "text"}, "image": {"type": "image"}, "hint": {"type": "text"}}},
    "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens", "fields": {"name": {"type": "text"}, "image": {"type": "image"}, "hint": {"type": "text"}}},
    "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes", "fields": {"name": {"type": "text"}, "image": {"type": "image"}, "hint": {"type": "text"}}}
}'),
((SELECT id from pages where slug = 'home'), 'testimonials', 'Testimonials Section', 8, true, '{
    "title": "Client Testimonials",
    "subtitle": "Hear what our happy clients have to say about their experience with Shriram Interio.",
    "buttonText": "View More",
    "items": [
        {"name": "Sunita Patil", "review": "Working with Shriram Interio was a fantastic experience. They understood our vision perfectly and delivered beyond our expectations. Our home feels brand new!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg"},
        {"name": "Amit Kumar", "review": "The team was professional, creative, and efficient. They transformed our cramped kitchen into a spacious, modern culinary haven. Highly recommended!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg"},
        {"name": "Rina Deshmukh", "review": "From design to execution, the process was seamless. Shriram Interio''s attention to detail is impeccable. We are in love with our new living room.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"},
    "items": {"type": "repeater", "label": "Testimonials", "fields": {
        "name": {"type": "text", "label": "Client Name"},
        "review": {"type": "textarea", "label": "Review"},
        "image": {"type": "image", "label": "Client Image"}
    }}
}'),
((SELECT id from pages where slug = 'home'), 'faq', 'FAQ Section', 9, true, '{
    "title": "Frequently Asked Questions",
    "subtitle": "Have questions? We have answers. Here are some of the most common queries we receive.",
    "items": [
        {"question": "What is the typical timeline for a project?", "answer": "A typical project timeline ranges from 4 to 8 weeks, depending on the scope and complexity. We provide a detailed schedule at the start of every project."},
        {"question": "Do you offer a warranty?", "answer": "Yes, we offer a comprehensive warranty on our materials and workmanship. The duration and terms vary by product, and we provide all details upfront."},
        {"question": "Can I see the design before work begins?", "answer": "Absolutely! We provide detailed 3D renderings of your space, allowing you to visualize the final outcome and make any desired changes before we begin execution."},
        {"question": "What is your payment process?", "answer": "We have a transparent, milestone-based payment process. Typically, it involves an advance payment to start the project, with subsequent payments tied to the completion of specific stages."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "FAQ Items", "fields": {
        "question": {"type": "text", "label": "Question"},
        "answer": {"type": "textarea", "label": "Answer"}
    }}
}'),
((SELECT id from pages where slug = 'home'), 'partners', 'Partners Section', 10, true, '{
    "title": "Our Trusted Partners",
    "subtitle": "ASSOCIATED BRANDS",
    "items": [
        {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png"},
        {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png"},
        {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png"},
        {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png"},
        {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Partners", "fields": {
        "name": {"type": "text", "label": "Partner Name"},
        "logoSrc": {"type": "image", "label": "Logo Image"}
    }}
}'),
-- About Page Sections
((SELECT id from pages where slug = 'about'), 'hero', 'Hero Section', 1, true, '{
    "title": "About Shriram Interio",
    "subtitle": "Innovating spaces, inspiring lives since 2016.",
    "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-hero.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "backgroundImage": {"type": "image", "label": "Background Image"}
}'),
((SELECT id from pages where slug = 'about'), 'story', 'Our Story Section', 2, true, '{
    "heading": "Our Story",
    "subheading": "DESIGNING WITH PASSION & PURPOSE",
    "paragraph1": "SHRIRAM INTERIO began with a simple yet powerful idea: that great design has the power to transform lives. Founded in 2016, our journey started with a small team of passionate designers who shared a common vision—to create spaces that were not just beautiful, but also deeply personal and functional.",
    "paragraph2": "We believe that a home is more than just a structure; it''s a sanctuary, a place of comfort, and a canvas for self-expression. Our design philosophy is rooted in understanding the unique stories and aspirations of our clients, and translating them into tangible, livable art.",
    "paragraph3": "Over the years, we have grown, but our core values remain the same. We are committed to creativity, craftsmanship, and client satisfaction. Every project is an opportunity to innovate, to challenge ourselves, and to bring a new vision to life.",
    "paragraph4": "Our approach is collaborative. We work hand-in-hand with our clients, listening to their needs, understanding their lifestyle, and ensuring that every detail is a true reflection of their personality. It''s this dedication that has earned us a reputation for excellence and a portfolio of happy homeowners.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-story.jpg"
}', '{
    "heading": {"type": "text", "label": "Heading"},
    "subheading": {"type": "text", "label": "Subheading"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
    "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
    "image": {"type": "image", "label": "Image"}
}'),
((SELECT id from pages where slug = 'about'), 'journey', 'Our Journey Section', 3, true, '{
    "heading": "Our Journey",
    "paragraph1": "Our journey has been one of continuous learning and evolution. We stay at the forefront of design trends, materials, and technology to bring our clients the very best in interior design. From our first project to our latest creation, we have poured our hearts and souls into every space we touch.",
    "paragraph2": "We have had the privilege of working on a diverse range of projects, from cozy apartments to sprawling villas, each with its own unique challenges and rewards. This experience has honed our skills and deepened our understanding of what makes a house a home.",
    "paragraph3": "At SHRIRAM INTERIO, we are more than just designers; we are storytellers. We craft narratives through color, texture, and light, creating environments that are not only aesthetically pleasing but also emotionally resonant.",
    "paragraph4": "As we look to the future, we are excited to continue pushing the boundaries of design, to explore new ideas, and to create spaces that inspire and delight. We invite you to be a part of our story and to let us help you write the next chapter of yours.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-journey.jpg"
}', '{
    "heading": {"type": "text", "label": "Heading"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
    "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
    "image": {"type": "image", "label": "Image"}
}'),
((SELECT id from pages where slug = 'about'), 'values', 'Our Values Section', 4, true, '{
    "title": "What We Do",
    "subtitle": "Our Core Values",
    "items": [
        {"title": "Expert Design Team", "description": "Our team of skilled designers brings creativity and expertise to every project."},
        {"title": "Variety of Design Choices", "description": "We offer a wide range of design options to suit your unique style and preferences."},
        {"title": "Affordable Design Fees", "description": "Get premium design services at competitive prices, ensuring value for your investment."},
        {"title": "On-Time Project Delivery", "description": "We adhere to strict timelines to ensure your project is completed without delays."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Value Items", "fields": {
        "title": {"type": "text"},
        "description": {"type": "textarea"}
    }}
}'),
((SELECT id from pages where slug = 'about'), 'mission_vision', 'Mission and Vision Section', 5, true, '{
    "visionTitle": "Our Vision",
    "visionText": "To be the most sought-after interior design firm in Pune, known for our innovative designs, exceptional quality, and unwavering commitment to client satisfaction.",
    "missionTitle": "Our Mission",
    "missionText": "To create beautiful, functional, and personalized living spaces that inspire and enhance the lives of our clients, through a collaborative and transparent design process."
}', '{
    "visionTitle": {"type": "text", "label": "Vision Title"},
    "visionText": {"type": "textarea", "label": "Vision Text"},
    "missionTitle": {"type": "text", "label": "Mission Title"},
    "missionText": {"type": "textarea", "label": "Mission Text"}
}'),
((SELECT id from pages where slug = 'about'), 'team', 'Meet the Team Section', 6, true, '{
    "title": "Meet the Team",
    "subtitle": "The creative minds behind our designs.",
    "members": [
        {"name": "Shriram", "role": "Founder & Lead Designer", "bio": "With a keen eye for detail and a passion for creating beautiful spaces, Shriram leads our team with vision and creativity.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg"},
        {"name": "Priya", "role": "Senior Interior Designer", "bio": "Priya specializes in contemporary and minimalist designs, bringing a fresh and modern perspective to every project.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg"},
        {"name": "Rajesh", "role": "Project Manager", "bio": "Rajesh ensures that every project is executed flawlessly, from concept to completion, with a focus on quality and timeliness.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-3.jpg"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "members": {"type": "repeater", "label": "Team Members", "fields": {
        "name": {"type": "text"},
        "role": {"type": "text"},
        "bio": {"type": "textarea"},
        "image": {"type": "image"}
    }}
}'),
-- Customer Stories Page Sections
((SELECT id from pages where slug = 'customer-stories'), 'header', 'Header Section', 1, true, '{
    "title": "Customer Stories",
    "subtitle": "Discover the real-life stories of how we''ve transformed houses into dream homes. Each project is a unique journey we''re proud to share."
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
((SELECT id from pages where slug = 'customer-stories'), 'featured_story', 'Featured Story Section', 2, true, '{
    "buttonText": "Read Their Story"
}', '{
    "buttonText": {"type": "text", "label": "Button Text"}
}'),
((SELECT id from pages where slug = 'customer-stories'), 'more_stories', 'More Stories Section', 3, true, '{
    "title": "More Inspiring Journeys"
}', '{
    "title": {"type": "text", "label": "Title"}
}'),
((SELECT id from pages where slug = 'customer-stories'), 'work_gallery', 'Work Gallery Section', 4, true, '{
    "title": "Our Work Gallery",
    "subtitle": "Explore our portfolio of stunning interior designs.",
    "items": [
        {"title": "L-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "hint": "modular kitchen"},
        {"title": "U-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "hint": "u-shaped kitchen"},
        {"title": "Straight Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-3.jpg", "hint": "straight kitchen"},
        {"title": "Island Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-4.jpg", "hint": "island kitchen"},
        {"title": "Parallel Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-5.jpg", "hint": "parallel kitchen"},
        {"title": "G-Shape Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-6.jpg", "hint": "g-shaped kitchen"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Gallery Items", "fields": {
        "title": {"type": "text", "label": "Item Title"},
        "image": {"type": "image", "label": "Item Image"},
        "hint": {"type": "text", "label": "AI Hint"}
    }}
}'),
((SELECT id from pages where slug = 'customer-stories'), 'partners', 'Partners Section', 5, true, '{
    "title": "Our Trusted Partners",
    "subtitle": "ASSOCIATED BRANDS",
    "items": [
        {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png"},
        {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png"},
        {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png"},
        {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png"},
        {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Partners", "fields": {
        "name": {"type": "text", "label": "Partner Name"},
        "logoSrc": {"type": "image", "label": "Logo Image"}
    }}
}'),
((SELECT id from pages where slug = 'customer-stories'), 'faq', 'FAQ Section', 6, true, '{
    "title": "Frequently Asked Questions",
    "subtitle": "Have questions? We have answers. Here are some of the most common queries we receive.",
    "items": [
        {"question": "What is the typical timeline for a project?", "answer": "A typical project timeline ranges from 4 to 8 weeks, depending on the scope and complexity. We provide a detailed schedule at the start of every project."},
        {"question": "Do you offer a warranty?", "answer": "Yes, we offer a comprehensive warranty on our materials and workmanship. The duration and terms vary by product, and we provide all details upfront."},
        {"question": "Can I see the design before work begins?", "answer": "Absolutely! We provide detailed 3D renderings of your space, allowing you to visualize the final outcome and make any desired changes before we begin execution."},
        {"question": "What is your payment process?", "answer": "We have a transparent, milestone-based payment process. Typically, it involves an advance payment to start the project, with subsequent payments tied to the completion of specific stages."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "FAQ Items", "fields": {
        "question": {"type": "text", "label": "Question"},
        "answer": {"type": "textarea", "label": "Answer"}
    }}
}'),
-- Clients Page Sections
((SELECT id from pages where slug = 'clients'), 'featured_testimonial', 'Featured Testimonial', 1, true, '{
    "name": "Sameer Joshi",
    "location": "Baner, Pune",
    "project": "Full Home Interior",
    "size": "3 BHK",
    "quote": "The entire process was a dream. The team at Shriram Interio captured our style perfectly.",
    "review": "From the initial 3D designs to the final handover, every step was handled with utmost professionalism. They listened to our needs, suggested innovative ideas, and executed the project flawlessly. Our home feels like a personalized masterpiece. We couldn''t be happier with the result and the wonderful experience.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-featured.jpg"
}', '{
    "name": {"type": "text", "label": "Name"},
    "location": {"type": "text", "label": "Location"},
    "project": {"type": "text", "label": "Project Type"},
    "size": {"type": "text", "label": "Home Size"},
    "quote": {"type": "textarea", "label": "Quote"},
    "review": {"type": "textarea", "label": "Full Review"},
    "image": {"type": "image", "label": "Client Image"}
}'),
((SELECT id from pages where slug = 'clients'), 'video_testimonials', 'Video Testimonials', 2, true, '{
    "title": "Client Stories on Camera",
    "subtitle": "Watch our clients share their experiences.",
    "videos": [
        {
            "name": "Anjali & Rahul",
            "location": "Koregaon Park",
            "review": "Our kitchen is now the heart of our home, thanks to the brilliant design and execution.",
            "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-testimonial-1.jpg",
            "videoUrl": "#",
            "dataAiHint": "happy couple kitchen"
        },
        {
            "name": "The Mehtas",
            "location": "Hinjewadi",
            "review": "They delivered our dream home on time and within budget. A truly professional team.",
            "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-testimonial-2.jpg",
            "videoUrl": "#",
            "dataAiHint": "family living room"
        },
        {
            "name": "Vikram Singh",
            "location": "Viman Nagar",
            "review": "The attention to detail in my wardrobe design is just outstanding. Highly recommended.",
            "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-testimonial-3.jpg",
            "videoUrl": "#",
            "dataAiHint": "man bedroom"
        }
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "videos": {"type": "repeater", "label": "Videos", "fields": {
        "name": {"type": "text"}, "location": {"type": "text"}, "review": {"type": "textarea"}, "imageSrc": {"type": "image"}, "videoUrl": {"type": "text"}, "dataAiHint": {"type": "text"}
    }}
}'),
((SELECT id from pages where slug = 'clients'), 'text_testimonials', 'Text Testimonials', 3, true, '{
    "title": "What Our Clients Say",
    "subtitle": "Words of appreciation from our valued clients.",
    "testimonials": [
        {
            "name": "Aditi Rao",
            "review": "Shriram Interio''s team is incredibly talented and professional. They transformed our space beautifully.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/text-testimonial-1.jpg",
            "avatar": "AR"
        },
        {
            "name": "Karan Malhotra",
            "review": "The quality of work and materials is top-notch. They are the best interior designers in Pune.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/text-testimonial-2.jpg",
            "avatar": "KM"
        },
        {
            "name": "Sneha Reddy",
            "review": "A seamless and enjoyable experience from start to finish. Our home is now our happy place.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/text-testimonial-3.jpg",
            "avatar": "SR"
        }
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "testimonials": {"type": "repeater", "label": "Testimonials", "fields": {
        "name": {"type": "text"}, "review": {"type": "textarea"}, "image": {"type": "image"}, "avatar": {"type": "text"}
    }}
}'),
-- Services Page Sections
((SELECT id from pages where slug = 'services'), 'header', 'Header Section', 1, true, '{
    "title": "Our Services",
    "subtitle": "Crafting beautiful and functional spaces tailored to your lifestyle."
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
((SELECT id from pages where slug = 'services'), 'our_services', 'Our Services List', 2, true, '{
    "services": [
        {"title": "Modular Kitchen Design", "description": "Beautiful and functional kitchens with smart storage solutions."},
        {"title": "Wardrobe & Storage Solutions", "description": "Custom wardrobes and storage units to maximize your space."},
        {"title": "Bedroom Interiors", "description": "Create a serene and stylish sanctuary for rest and relaxation."},
        {"title": "Living Area Design", "description": "Design inviting and comfortable living spaces for your family."},
        {"title": "Exterior Design Services", "description": "Enhance your home''s curb appeal with our expert exterior design."},
        {"title": "Full Home Interiors", "description": "A complete home makeover, from concept to completion."}
    ]
}', '{
    "services": {"type": "repeater", "label": "Service Items", "fields": {
        "title": {"type": "text"}, "description": {"type": "textarea"}
    }}
}'),
((SELECT id from pages where slug = 'services'), 'detailed_services', 'Detailed Services', 3, true, '{
    "services": [
        {
            "title": "Modular Kitchens",
            "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-kitchen.jpg",
            "dataAiHint": "modern kitchen",
            "href": "/products/kitchen"
        },
        {
            "title": "Custom Wardrobes",
            "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-wardrobe.jpg",
            "dataAiHint": "custom wardrobe",
            "href": "/products/wardrobe"
        },
        {
            "title": "Living Rooms",
            "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-livingroom.jpg",
            "dataAiHint": "cozy living room",
            "href": "/products/living-room"
        }
    ]
}', '{
    "services": {"type": "repeater", "label": "Detailed Service Items", "fields": {
        "title": {"type": "text"}, "imageSrc": {"type": "image"}, "dataAiHint": {"type": "text"}, "href": {"type": "text"}
    }}
}'),
-- Portfolio Page Sections
((SELECT id from pages where slug = 'portfolio'), 'projects_gallery', 'Projects Gallery', 1, true, '{
    "projects": [
        {"id": 1, "title": "Modern Kitchen, Baner", "category": "Kitchens", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-kitchen-1.jpg", "dataAiHint": "modern kitchen"},
        {"id": 2, "title": "Luxury Living Room, Koregaon Park", "category": "Living Rooms", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-living-1.jpg", "dataAiHint": "luxury living room"},
        {"id": 3, "title": "Elegant Bedroom, Viman Nagar", "category": "Bedrooms", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-bedroom-1.jpg", "dataAiHint": "elegant bedroom"},
        {"id": 4, "title": "Compact Kitchen, Hinjewadi", "category": "Kitchens", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-kitchen-2.jpg", "dataAiHint": "compact kitchen"},
        {"id": 5, "title": "Chic Wardrobe, Kharadi", "category": "Wardrobes", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-wardrobe-1.jpg", "dataAiHint": "chic wardrobe"},
        {"id": 6, "title": "Contemporary Living Area", "category": "Living Rooms", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-living-2.jpg", "dataAiHint": "contemporary living room"}
    ]
}', '{
    "projects": {"type": "repeater", "label": "Projects", "fields": {
        "id": {"type": "number"}, "title": {"type": "text"}, "category": {"type": "text"}, "imageSrc": {"type": "image"}, "dataAiHint": {"type": "text"}
    }}
}'),
((SELECT id from pages where slug = 'portfolio'), 'partners', 'Partners Section', 2, true, '{
    "title": "Our Trusted Partners",
    "subtitle": "ASSOCIATED BRANDS",
    "visible": true,
    "items": [
        {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png"},
        {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png"},
        {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png"},
        {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png"},
        {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Partners", "fields": {
        "name": {"type": "text"}, "logoSrc": {"type": "image"}
    }}
}'),
-- How It Works Page Sections
((SELECT id from pages where slug = 'how-it-works'), 'hero', 'Hero Section', 1, true, '{
    "title": "Our Seamless Process",
    "subtitle": "From your initial idea to the final reveal, we make the journey to your dream home simple and enjoyable.",
    "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/how-it-works-hero.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "backgroundImage": {"type": "image", "label": "Background Image"}
}'),
((SELECT id from pages where slug = 'how-it-works'), 'process', 'Process Steps Section', 2, true, '{
    "title": "How It Works",
    "subtitle": "Your dream home is just a few steps away.",
    "steps": [
        {"icon": "Handshake", "title": "Consultation", "description": "We start with a free consultation to understand your vision, requirements, and budget."},
        {"icon": "PencilRuler", "title": "Design & Planning", "description": "Our expert designers create detailed 3D models and plans for your approval."},
        {"icon": "Truck", "title": "Execution & Delivery", "description": "Our skilled team brings the design to life with precision and quality craftsmanship."},
        {"icon": "ShieldCheck", "title": "Quality Check", "description": "We conduct thorough quality checks at every stage to ensure the highest standards."},
        {"icon": "Star", "title": "Handover", "description": "We deliver your dream space, ready for you to move in and enjoy."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "steps": {"type": "repeater", "label": "Steps", "fields": {
        "icon": {"type": "text"}, "title": {"type": "text"}, "description": {"type": "textarea"}
    }}
}'),
((SELECT id from pages where slug = 'how-it-works'), 'why_us', 'Why Our Process Works', 3, true, '{
    "title": "Why Our Process Works",
    "subtitle": "We focus on transparency, communication, and quality.",
    "benefits": [
        {"icon": "ThumbsUp", "title": "Client-Centric", "description": "Your needs and preferences are at the heart of our design process."},
        {"icon": "Wallet", "title": "Transparent Pricing", "description": "No hidden costs. We provide detailed quotes and stick to your budget."},
        {"icon": "Smile", "title": "Hassle-Free Experience", "description": "We manage everything from start to finish, so you can relax and watch your vision come to life."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "benefits": {"type": "repeater", "label": "Benefits", "fields": {
        "icon": {"type": "text"}, "title": {"type": "text"}, "description": {"type": "textarea"}
    }}
}'),
((SELECT id from pages where slug = 'how-it-works'), 'get_started', 'Get Started Section', 4, true, '{
    "title": "Ready to Start Your Project?",
    "subtitle": "Let''s create a space that you''ll love.",
    "buttonText": "Book a Free Consultation"
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"}
}'),
-- Products Page Sections
((SELECT id from pages where slug = 'products'), 'header', 'Header Section', 1, true, '{
    "title": "Our Products",
    "subtitle": "Explore our curated collection of high-quality interior solutions."
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
((SELECT id from pages where slug = 'products'), 'product_list', 'Product List', 2, true, '{
    "products": [
        {"name": "Modular Kitchens", "description": "Functional and stylish kitchens tailored to your needs.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-kitchen.jpg", "dataAiHint": "modular kitchen", "href": "/products/kitchen"},
        {"name": "Wardrobes", "description": "Customized wardrobes that maximize storage and style.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-wardrobe.jpg", "dataAiHint": "elegant wardrobe", "href": "/products/wardrobe"},
        {"name": "Living Room Furniture", "description": "Create an inviting space with our living room collection.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-living.jpg", "dataAiHint": "modern living room", "href": "/products/living-room"},
        {"name": "Bedroom Sets", "description": "Design your personal sanctuary with our bedroom furniture.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-bedroom.jpg", "dataAiHint": "cozy bedroom", "href": "/products/bedroom"},
        {"name": "Bathroom Solutions", "description": "Stylish and functional designs for your bathroom.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-bathroom.jpg", "dataAiHint": "sleek bathroom", "href": "/products/bathroom"},
        {"name": "Home Office Furniture", "description": "Create a productive and inspiring workspace at home.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-office.jpg", "dataAiHint": "home office", "href": "/products/home-office"},
        {"name": "Space Saving Furniture", "description": "Smart furniture solutions for modern urban living.", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-space-saving.jpg", "dataAiHint": "compact furniture", "href": "/products/space-saving-furniture"}
    ]
}', '{
    "products": {"type": "repeater", "label": "Products", "fields": {
        "name": {"type": "text"}, "description": {"type": "textarea"}, "imageSrc": {"type": "image"}, "dataAiHint": {"type": "text"}, "href": {"type": "text"}
    }}
}'),
-- Contact Page Sections (This page is mostly static, but we can make parts editable if needed)
((SELECT id from pages where slug = 'contact'), 'contact_details', 'Contact Details', 1, true, '{
    "title": "Contact Us",
    "subtitle": "Get in touch with us for a free consultation."
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
-- Individual Product Pages
((SELECT id from pages where slug = 'product-living-room'), 'product_details', 'Product Details', 1, true, '{
    "title": "Living Room Furniture",
    "description": "Create a living room that is both stylish and comfortable with our curated collection of furniture. From plush sofas to elegant coffee tables, we have everything you need to design a space that reflects your personality and is perfect for relaxing and entertaining.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/living-room-details.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "description": {"type": "textarea", "label": "Description"},
    "image": {"type": "image", "label": "Product Image"}
}'),
((SELECT id from pages where slug = 'product-bedroom'), 'product_details', 'Product Details', 1, true, '{
    "title": "Bedroom Furniture",
    "description": "Transform your bedroom into a personal sanctuary with our range of stylish and comfortable furniture. From elegant bed frames to spacious wardrobes, we offer everything you need to create a serene and restful retreat.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bedroom-details.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "description": {"type": "textarea", "label": "Description"},
    "image": {"type": "image", "label": "Product Image"}
}'),
((SELECT id from pages where slug = 'product-bathroom'), 'product_details', 'Product Details', 1, true, '{
    "title": "Bathroom Interiors",
    "description": "Elevate your bathroom with our stylish and functional interior solutions. We offer a range of options, from modern vanities to smart storage, to create a space that is both beautiful and practical.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bathroom-details.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "description": {"type": "textarea", "label": "Description"},
    "image": {"type": "image", "label": "Product Image"}
}'),
((SELECT id from pages where slug = 'product-home-office'), 'product_details', 'Product Details', 1, true, '{
    "title": "Home Office Furniture",
    "description": "Design a home office that inspires productivity and creativity. Our range of ergonomic chairs, spacious desks, and smart storage solutions will help you create a workspace that is both functional and stylish.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/home-office-details.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "description": {"type": "textarea", "label": "Description"},
    "image": {"type": "image", "label": "Product Image"}
}'),
((SELECT id from pages where slug = 'product-space-saving-furniture'), 'product_details', 'Product Details', 1, true, '{
    "title": "Space-Saving Furniture",
    "description": "Make the most of your living space with our innovative and stylish space-saving furniture. From convertible sofas to wall-mounted desks, our solutions are perfect for modern urban living, offering functionality without compromising on style.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/space-saving-details.jpg"
}', '{
    "title": {"type": "text", "label": "Title"},
    "description": {"type": "textarea", "label": "Description"},
    "image": {"type": "image", "label": "Product Image"}
}')
ON CONFLICT (page_id, type) DO UPDATE SET
    title = EXCLUDED.title,
    "order" = EXCLUDED.order,
    visible = EXCLUDED.visible,
    content = EXCLUDED.content,
    content_structure = EXCLUDED.content_structure;

-- Insert Stories Data
INSERT INTO stories (slug, title, category, date, author, authorAvatar, image, dataAiHint, excerpt, content, quote, clientImage, location, project, size, gallery) VALUES
('a-dream-kitchen-in-baner', 'A Dream Kitchen in Baner', 'Kitchens', 'June 15, 2024', 'Sunita Patil', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-main.jpg', 'modern kitchen', 'See how we transformed a compact kitchen into a spacious and elegant culinary workspace for the Patil family.', '<p>The Patil family wanted a kitchen that was both beautiful and highly functional for their new apartment in Baner. Their primary challenge was the limited space. Our design team focused on creating an L-shaped layout with smart storage solutions, including pull-out cabinets and a tall pantry unit.</p><p>We used a combination of high-gloss white laminates and a warm wood finish to create a sense of openness and warmth. The quartz countertop is both durable and stylish, and the under-cabinet LED lighting adds a touch of modern sophistication. The result is a bright, airy, and incredibly efficient kitchen that the Patils absolutely love.</p>', 'Shriram Interio didn''t just give us a kitchen; they gave us the heart of our home.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-client.jpg', 'Baner, Pune', 'Modular Kitchen', '2 BHK', '[
    {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-1.jpg", "alt": "Kitchen detail", "dataAiHint": "kitchen cabinet"},
    {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-2.jpg", "alt": "Kitchen storage", "dataAiHint": "kitchen storage"},
    {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-3.jpg", "alt": "Kitchen countertop", "dataAiHint": "kitchen countertop"}
]'),
('cozy-living-room-makeover', 'Cozy Living Room Makeover', 'Living Rooms', 'May 28, 2024', 'Amit Kumar', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-main.jpg', 'cozy living room', 'A complete transformation of a living room into a warm and inviting space for family and friends.', '<p>Amit and his family wanted a living room that was comfortable for daily use but also elegant enough for entertaining guests. We started by creating a neutral color palette with pops of color in the accessories. The custom-designed TV unit provides ample storage while maintaining a sleek look.</p><p>The centerpiece is a comfortable sectional sofa, perfect for family movie nights. We added a mix of ambient and accent lighting to create a warm and inviting atmosphere. The final touch was a gallery wall of family photos, making the space truly personal.</p>', 'The team was professional, creative, and delivered our dream living room on time.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-client.jpg', 'Hinjewadi, Pune', 'Living Room Design', '3 BHK', '[
    {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-1.jpg", "alt": "Living room sofa", "dataAiHint": "living room sofa"},
    {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-2.jpg", "alt": "TV unit detail", "dataAiHint": "tv unit"},
    {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-3.jpg", "alt": "Living room decor", "dataAiHint": "living room decor"}
]')
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    category = EXCLUDED.category,
    date = EXCLUDED.date,
    author = EXCLUDED.author,
    authorAvatar = EXCLUDED.authorAvatar,
    image = EXCLUDED.image,
    dataAiHint = EXCLUDED.dataAiHint,
    excerpt = EXCLUDED.excerpt,
    content = EXCLUDED.content,
    quote = EXCLUDED.quote,
    clientImage = EXCLUDED.clientImage,
    location = EXCLUDED.location,
    project = EXCLUDED.project,
    size = EXCLUDED.size,
    gallery = EXCLUDED.gallery;
