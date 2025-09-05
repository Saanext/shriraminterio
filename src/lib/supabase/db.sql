
-- Create pages table
CREATE TABLE pages (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT NOT NULL,
    parent_slug TEXT,
    nav_order INTEGER,
    meta_title TEXT,
    meta_description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(slug, parent_slug)
);

-- Create sections table
CREATE TABLE sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER REFERENCES pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    content JSONB,
    content_structure JSONB,
    "order" INTEGER,
    visible BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create stories table
CREATE TABLE stories (
    id SERIAL PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    image TEXT,
    "dataAiHint" TEXT,
    category TEXT,
    excerpt TEXT,
    author TEXT,
    "authorAvatar" TEXT,
    date DATE,
    "clientImage" TEXT,
    location TEXT,
    project TEXT,
    size TEXT,
    quote TEXT,
    content TEXT,
    gallery JSONB,
    video_gallery JSONB
);

-- Create products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    short_description TEXT,
    long_description TEXT,
    main_image TEXT,
    features TEXT[],
    gallery TEXT[],
    amazon_link TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create portfolio table
CREATE TABLE portfolio (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    content TEXT,
    main_image TEXT,
    gallery TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create sales_persons table
CREATE TABLE sales_persons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE,
    contact_number TEXT,
    profile_image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create leads table
CREATE TABLE leads (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    mobile TEXT,
    services TEXT[],
    message TEXT,
    status TEXT NOT NULL DEFAULT 'in progress',
    assigned_to_id INTEGER REFERENCES sales_persons(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create quotes table
CREATE TABLE quotes (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT,
    floorplan TEXT,
    purpose TEXT,
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create appointments table
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT,
    appointment_date DATE,
    time_slot TEXT,
    floorplan TEXT,
    purpose TEXT,
    services TEXT[],
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create social_links table
CREATE TABLE social_links (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    url TEXT NOT NULL,
    icon TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert initial data for pages and sections
DO $$
DECLARE
    home_page_id INT;
    about_page_id INT;
    stories_page_id INT;
    how_it_works_page_id INT;
    services_page_id INT;
    clients_page_id INT;
BEGIN
    -- Home Page
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES ('Home', 'home', 1, 'Shriram Interio Digital', 'Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors.') RETURNING id INTO home_page_id;

    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES 
    (home_page_id, 'hero', 'Hero', 1, true, 
        '{
            "title": "Designing Your Dreams, One Room at a Time",
            "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors.",
            "buttonText": "Explore Our Services",
            "videoUrl": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/pexels-roman-odintsov-4553278%20(2160p).mp4",
            "slides": [
                { "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg" },
                { "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-2.jpg" },
                { "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-3.jpg" }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "buttonText": { "type": "text", "label": "Button Text" },
            "videoUrl": { "type": "text", "label": "Video URL" },
            "slides": {
                "type": "repeater",
                "label": "Image Slides",
                "fields": {
                    "image": { "type": "image", "label": "Image" }
                }
            }
        }'
    ),
    (home_page_id, 'welcome', 'Welcome', 2, true,
        '{
            "title": "Welcome to Shriram Interio",
            "paragraph1": "We are a team of passionate designers and craftsmen dedicated to creating beautiful and functional living spaces. From concept to completion, we work closely with you to bring your vision to life.",
            "paragraph2": "Our commitment to quality, attention to detail, and customer satisfaction sets us apart as a leading interior design firm in Pune.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/welcome.jpg"
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "paragraph1": { "type": "textarea", "label": "Paragraph 1" },
            "paragraph2": { "type": "textarea", "label": "Paragraph 2" },
            "image": { "type": "image", "label": "Image" }
        }'
    ),
    (home_page_id, 'about_company', 'About Company', 3, true,
        '{
            "title": "Over 8 Years of Expertise",
            "text": "we are a Pune-based interior design company with over 8 years of experience. We provide a wide range of services, including modular kitchens, wardrobes, TV units, beds, sofas, and full home interiors."
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "text": { "type": "textarea", "label": "Text" }
        }'
    ),
    (home_page_id, 'why_us', 'Why Us', 4, true,
        '{
            "title": "Why Shriram Interio?",
            "subtitle": "Discover the advantages of choosing us for your interior design needs.",
            "items": [
                { "title": "Expert Design Team", "description": "Our team of skilled designers brings creativity and expertise to every project." },
                { "title": "Variety of Design Choices", "description": "We offer a wide range of design options to suit your personal style and preferences." },
                { "title": "Affordable Design Fees", "description": "Get premium design services at competitive prices, ensuring value for your money." },
                { "title": "On-Time Project Delivery", "description": "We are committed to completing your project on schedule, without compromising on quality." }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "items": {
                "type": "repeater",
                "label": "Items",
                "fields": {
                    "title": { "type": "text", "label": "Title" },
                    "description": { "type": "textarea", "label": "Description" }
                }
            }
        }'
    ),
    (home_page_id, 'work_gallery', 'Work Gallery', 5, true,
        '{
            "title": "Our Work Gallery",
            "subtitle": "Explore our portfolio of stunning interior designs.",
            "items": [
                { "title": "Modern Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen.jpg", "hint": "modern kitchen", "gallery_images": [
                    {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg"},
                    {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg"}
                ]},
                { "title": "Living Room", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/living-room.jpg", "hint": "living room", "gallery_images": [] },
                { "title": "Bedroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bedroom.jpg", "hint": "bedroom", "gallery_images": [] },
                { "title": "Dining Area", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/dining.jpg", "hint": "dining area", "gallery_images": [] }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "items": {
                "type": "repeater",
                "label": "Gallery Items",
                "fields": {
                    "title": { "type": "text", "label": "Title" },
                    "image": { "type": "image", "label": "Image" },
                    "hint": { "type": "text", "label": "AI Hint" },
                    "gallery_images": {
                        "type": "repeater",
                        "label": "Gallery Images",
                        "fields": {
                            "image": { "type": "image", "label": "Image" }
                        }
                    }
                }
            }
        }'
    ),
    (home_page_id, 'comfort_design', 'Comfort Design', 6, true,
        '{
            "title": "Design at Your Comfort",
            "subtitle": "Experience a seamless design process from the comfort of your home.",
            "items": [
                { "title": "Live 3D Designs", "description": "See your space come to life with our interactive 3D design sessions." },
                { "title": "Contactless Experience", "description": "From consultation to project management, we offer a fully remote process." },
                { "title": "Instant Pricing", "description": "Get transparent and upfront pricing for your project with no hidden costs." },
                { "title": "Expertise & Passion", "description": "Our team''s dedication and passion for design ensure exceptional results." }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "items": {
                "type": "repeater",
                "label": "Items",
                "fields": {
                    "title": { "type": "text", "label": "Title" },
                    "description": { "type": "textarea", "label": "Description" }
                }
            }
        }'
    ),
    (home_page_id, 'what_we_do', 'What We Do', 7, true,
        '{
            "title": "What We Do",
            "subtitle": "Browse our popular designs and best-selling products.",
            "trendingItems": [
                { "name": "Modern TV Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/tv-unit.jpg", "hint": "modern tv unit" },
                { "name": "L-Shaped Sofa", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/sofa.jpg", "hint": "l-shaped sofa" },
                { "name": "Queen Size Bed", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bed.jpg", "hint": "queen size bed" },
                { "name": "Modular Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe.jpg", "hint": "modular wardrobe" }
            ],
            "bestSellingKitchens": [
                { "name": "U-Shaped Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "hint": "u-shaped kitchen" },
                { "name": "L-Shaped Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "hint": "l-shaped kitchen" },
                { "name": "Parallel Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "hint": "parallel kitchen" },
                { "name": "Straight Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-4.jpg", "hint": "straight kitchen" }
            ],
            "bestSellingWardrobes": [
                { "name": "Sliding Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "hint": "sliding wardrobe" },
                { "name": "Hinged Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "hint": "hinged wardrobe" },
                { "name": "Walk-in Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-3.jpg", "hint": "walk-in wardrobe" },
                { "name": "Wardrobe with Loft", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-4.jpg", "hint": "wardrobe loft" }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "trendingItems": { "type": "repeater", "label": "Trending Items", "fields": { "name": { "type": "text", "label": "Name" }, "image": { "type": "image", "label": "Image" }, "hint": { "type": "text", "label": "AI Hint" } } },
            "bestSellingKitchens": { "type": "repeater", "label": "Best Selling Kitchens", "fields": { "name": { "type": "text", "label": "Name" }, "image": { "type": "image", "label": "Image" }, "hint": { "type": "text", "label": "AI Hint" } } },
            "bestSellingWardrobes": { "type": "repeater", "label": "Best Selling Wardrobes", "fields": { "name": { "type": "text", "label": "Name" }, "image": { "type": "image", "label": "Image" }, "hint": { "type": "text", "label": "AI Hint" } } }
        }'
    ),
    (home_page_id, 'testimonials', 'Testimonials', 8, true,
        '{
            "title": "What Our Clients Say",
            "subtitle": "Hear from our satisfied customers about their experience with Shriram Interio.",
            "buttonText": "View All Testimonials",
            "items": [
                { "name": "Prakash Kumar", "review": "Shriram Interio transformed our home! The team was professional, and the final result exceeded our expectations. Highly recommended!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg" },
                { "name": "Anjali Mehta", "review": "The attention to detail and quality of work is amazing. Our kitchen is now the highlight of our home. Thank you, Shriram Interio!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg" },
                { "name": "Rohan Desai", "review": "A fantastic experience from start to finish. The designers understood our needs perfectly and delivered a beautiful and functional space.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg" }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "buttonText": { "type": "text", "label": "Button Text" },
            "items": {
                "type": "repeater",
                "label": "Items",
                "fields": {
                    "name": { "type": "text", "label": "Name" },
                    "review": { "type": "textarea", "label": "Review" },
                    "image": { "type": "image", "label": "Image" }
                }
            }
        }'
    ),
    (home_page_id, 'partners', 'Partners', 9, true,
        '{
            "title": "Our Trusted Partners",
            "subtitle": "Associated Brands",
            "items": [
                { "name": "Hettich", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hettich.png" },
                { "name": "Hafele", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hafele.png" },
                { "name": "Ebco", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/ebco.png" },
                { "name": "Rehau", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/rehau.png" },
                { "name": "Greenply", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/greenply.png" }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "items": {
                "type": "repeater",
                "label": "Items",
                "fields": {
                    "name": { "type": "text", "label": "Name" },
                    "logoSrc": { "type": "image", "label": "Logo" }
                }
            }
        }'
    ),
    (home_page_id, 'faq', 'FAQ', 10, true,
        '{
            "title": "Frequently Asked Questions",
            "subtitle": "Find answers to common questions about our services.",
            "items": [
                { "question": "What is the typical timeline for a project?", "answer": "A standard project typically takes 4-6 weeks from design approval to completion, depending on the scope and complexity." },
                { "question": "Do you offer a warranty?", "answer": "Yes, we offer a 5-year warranty on all our modular products and a 1-year warranty on services." },
                { "question": "Can I see my design before execution?", "answer": "Absolutely! We provide detailed 3D designs for your approval before we begin any work." },
                { "question": "What are the payment terms?", "answer": "We require a 50% advance payment to start the project, and the remaining 50% is due upon completion." }
            ]
        }',
        '{
            "title": { "type": "text", "label": "Title" },
            "subtitle": { "type": "text", "label": "Subtitle" },
            "items": {
                "type": "repeater",
                "label": "Items",
                "fields": {
                    "question": { "type": "text", "label": "Question" },
                    "answer": { "type": "textarea", "label": "Answer" }
                }
            }
        }'
    );

    -- About Us Page
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES ('About Us', 'about', 2, 'About Shriram Interio', 'Learn about our journey, mission, and the team behind Shriram Interio.') RETURNING id INTO about_page_id;
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (about_page_id, 'hero', 'Hero', 1, true, '{ "title": "About Shriram Interio", "subtitle": "Crafting beautiful spaces with passion and precision since 2016.", "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-hero.jpg" }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'),
    (about_page_id, 'story', 'Our Story', 2, true, '{ "heading": "Our Story", "subheading": "The journey of a thousand miles begins with a single step.", "paragraph1": "Founded in 2016, Shriram Interio began with a simple mission: to make high-quality interior design accessible to everyone. We started as a small team of passionate designers and craftsmen, united by a love for creating beautiful and functional spaces.", "paragraph2": "Over the years, we have grown into a full-service design studio, but our core values remain the same. We believe in the power of good design to transform lives, and we are committed to delivering excellence in every project we undertake.", "paragraph3": "Our journey has been one of continuous learning and evolution. We stay updated with the latest trends and technologies to provide our clients with innovative and timeless design solutions.", "paragraph4": "From humble beginnings to becoming one of Pune''s most trusted interior design companies, our story is a testament to our dedication, hard work, and the unwavering support of our clients.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-story.jpg" }', '{ "heading": {"type": "text", "label": "Heading"}, "subheading": {"type": "text", "label": "Subheading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'),
    (about_page_id, 'journey', 'Our Journey', 3, true, '{ "heading": "Our Journey", "paragraph1": "The path of Shriram Interio has been marked by creativity, innovation, and a relentless pursuit of excellence. We started with a vision to redefine interior design, and every project has been a step towards that goal.", "paragraph2": "We have had the privilege of working on a diverse range of projects, from cozy apartments to luxurious villas and commercial spaces. Each project has been a unique opportunity to learn, grow, and push the boundaries of design.", "paragraph3": "Our success is built on the foundation of strong relationships with our clients, partners, and team members. We believe in collaboration and transparency, and we work closely with our clients to ensure their vision is brought to life.", "paragraph4": "As we look to the future, we are excited to continue our journey of creating inspiring spaces that enhance the lives of our clients. We are grateful for the trust they have placed in us and look forward to many more years of design excellence.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-journey.jpg" }', '{ "heading": {"type": "text", "label": "Heading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'),
    (about_page_id, 'values', 'Our Values', 4, true, '{ "title": "Our Core Values", "subtitle": "The principles that guide our work and define our culture.", "items": [ { "title": "Expert Design Team", "description": "Our team of skilled designers brings creativity and expertise to every project." }, { "title": "Variety of Design Choices", "description": "We offer a wide range of design options to suit your personal style and preferences." }, { "title": "Affordable Design Fees", "description": "Get premium design services at competitive prices, ensuring value for your money." }, { "title": "On-Time Project Delivery", "description": "We are committed to completing your project on schedule, without compromising on quality." } ] }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": { "title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"} }} }'),
    (about_page_id, 'mission_vision', 'Mission and Vision', 5, true, '{ "visionTitle": "Our Vision", "visionText": "To be the most trusted and innovative interior design company, creating spaces that inspire and delight.", "missionTitle": "Our Mission", "missionText": "To provide exceptional design services and solutions that exceed our clients'' expectations, while fostering a culture of creativity, collaboration, and integrity." }', '{ "visionTitle": {"type": "text", "label": "Vision Title"}, "visionText": {"type": "textarea", "label": "Vision Text"}, "missionTitle": {"type": "text", "label": "Mission Title"}, "missionText": {"type": "textarea", "label": "Mission Text"} }'),
    (about_page_id, 'team', 'Meet the Team', 6, true, '{ "title": "Meet Our Team", "subtitle": "The creative minds behind our successful projects.", "members": [ { "name": "Ravi Sharma", "role": "Lead Designer", "bio": "With over 10 years of experience, Ravi is a master of creating stunning and functional interiors.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg" }, { "name": "Priya Singh", "role": "Project Manager", "bio": "Priya ensures that every project is executed flawlessly, on time, and within budget.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg" }, { "name": "Amit Patel", "role": "Senior Architect", "bio": "Amit''s technical expertise and innovative approach bring our designs to life.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-3.jpg" } ] }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "members": {"type": "repeater", "label": "Members", "fields": { "name": {"type": "text", "label": "Name"}, "role": {"type": "text", "label": "Role"}, "bio": {"type": "textarea", "label": "Bio"}, "image": {"type": "image", "label": "Image"} }} }');


    -- Customer Stories Page
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES ('Customer Stories', 'customer-stories', 3, 'Customer Stories', 'Read inspiring stories from our clients.') RETURNING id INTO stories_page_id;
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (stories_page_id, 'header', 'Header', 1, true, '{ "title": "Customer Stories", "subtitle": "Discover how we''ve transformed homes and lives through design." }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"} }'),
    (stories_page_id, 'featured_story', 'Featured Story', 2, true, '{ "buttonText": "Read Full Story" }', '{ "buttonText": {"type": "text", "label": "Button Text"} }'),
    (stories_page_id, 'more_stories', 'More Stories', 3, true, '{ "title": "More Inspiring Stories" }', '{ "title": {"type": "text", "label": "Title"} }');

    -- How It Works Page
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES ('How It Works', 'how-it-works', 5, 'How It Works', 'Our simple, transparent process for bringing your vision to life.') RETURNING id INTO how_it_works_page_id;
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (how_it_works_page_id, 'hero', 'Hero', 1, true, '{ "title": "Our Process", "subtitle": "A simple, transparent, and collaborative journey to your dream home.", "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/how-it-works-hero.jpg" }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'),
    (how_it_works_page_id, 'process', 'Our Process', 2, true, '{ "title": "Our Design Process", "subtitle": "We follow a structured approach to ensure a seamless experience and exceptional results.", "steps": [ { "icon": "Handshake", "title": "Consultation & Briefing", "description": "We start by understanding your needs, preferences, and budget. This initial meeting helps us lay the foundation for your project." }, { "icon": "PencilRuler", "title": "Design & Visualization", "description": "Our team creates detailed 2D and 3D designs, allowing you to visualize your space before we begin execution." }, { "icon": "Truck", "title": "Execution & Delivery", "description": "Our skilled craftsmen and project managers bring the design to life, ensuring quality and timely completion." }, { "icon": "ShieldCheck", "title": "Handover & Warranty", "description": "We conduct a final quality check and hand over your new space, complete with a comprehensive warranty." } ] }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "steps": {"type": "repeater", "label": "Steps", "fields": { "icon": {"type": "text", "label": "Icon"}, "title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"} }} }'),
    (how_it_works_page_id, 'why_us', 'Why Us', 3, true, '{ "title": "Why Our Process Works", "subtitle": "The benefits of our client-centric approach.", "benefits": [ { "icon": "ThumbsUp", "title": "Client-Centric Approach", "description": "We put you at the heart of our process, ensuring your vision is our top priority." }, { "icon": "Wallet", "title": "Transparent Pricing", "description": "No hidden costs. We provide clear, detailed quotes so you know exactly what to expect." }, { "icon": "Smile", "title": "Hassle-Free Experience", "description": "We manage everything from start to finish, so you can relax and watch your dream home come to life." } ] }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "benefits": {"type": "repeater", "label": "Benefits", "fields": { "icon": {"type": "text", "label": "Icon"}, "title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"} }} }'),
    (how_it_works_page_id, 'get_started', 'Get Started', 4, true, '{ "title": "Ready to Start Your Project?", "subtitle": "Let''s create a space that you''ll love for years to come.", "buttonText": "Book a Free Consultation" }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"} }');

    -- Services Page
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES ('Services', 'services', 6, 'Our Services', 'Explore our comprehensive range of interior design services.') RETURNING id INTO services_page_id;
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (services_page_id, 'header', 'Header', 1, true, '{ "title": "Our Services", "subtitle": "We offer a complete range of interior design solutions to transform your space." }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"} }'),
    (services_page_id, 'our_services', 'Our Services', 2, true, '{ "services": [ { "title": "Modular Kitchen Design", "description": "Customized kitchen solutions that are both beautiful and functional." }, { "title": "Wardrobe & Storage Solutions", "description": "Maximize your space with our stylish and efficient wardrobe designs." }, { "title": "Bedroom Interiors", "description": "Create a serene and personal retreat with our expert bedroom designs." }, { "title": "Living Area Design", "description": "Design a welcoming and comfortable living space for your family and guests." }, { "title": "Exterior Design Services", "description": "Enhance your home''s curb appeal with our professional exterior design services." }, { "title": "Full Home Interiors", "description": "A complete design solution for your entire home, from concept to completion." } ] }', '{ "services": {"type": "repeater", "label": "Services", "fields": { "title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"} }} }');

    -- Clients Page
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES ('Clients', 'clients', 8, 'Our Clients', 'See what our clients are saying about us.') RETURNING id INTO clients_page_id;
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (clients_page_id, 'featured_testimonial', 'Featured Testimonial', 1, true, '{ "name": "Sameer Joshi", "location": "Kothrud, Pune", "project": "3 BHK Interior", "size": "1200 Sq. Ft.", "quote": "The best interior design decision we ever made. The team was professional, the process was seamless, and the result is simply stunning.", "review": "We approached Shriram Interio for our new 3 BHK flat, and we couldn''t be happier. They understood our vision perfectly and delivered a home that is both beautiful and functional. The quality of work and attention to detail is commendable. Highly recommended!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-featured.jpg" }', '{ "name": {"type": "text", "label": "Name"}, "location": {"type": "text", "label": "Location"}, "project": {"type": "text", "label": "Project"}, "size": {"type": "text", "label": "Size"}, "quote": {"type": "textarea", "label": "Quote"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"} }'),
    (clients_page_id, 'video_testimonials', 'Video Testimonials', 2, true, '{ "title": "Client Video Testimonials", "subtitle": "Watch our clients share their experiences.", "videos": [ { "name": "The Sharma Family", "location": "Wakad, Pune", "review": "Our modular kitchen is a dream come true. Thank you, Shriram Interio!", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg", "dataAiHint": "happy family kitchen" }, { "name": "Rina & Alok", "location": "Hinjewadi, Pune", "review": "The wardrobe design is fantastic. So much storage and it looks so elegant.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg", "dataAiHint": "couple bedroom" }, { "name": "Mr. Deshpande", "location": "Baner, Pune", "review": "A very professional team. They completed the project on time and within budget.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg", "dataAiHint": "man living room" } ] }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "videos": {"type": "repeater", "label": "Videos", "fields": { "name": {"type": "text", "label": "Name"}, "location": {"type": "text", "label": "Location"}, "review": {"type": "textarea", "label": "Review"}, "videoUrl": {"type": "text", "label": "Video URL"}, "imageSrc": {"type": "image", "label": "Image"}, "dataAiHint": {"type": "text", "label": "AI Hint"} }} }'),
    (clients_page_id, 'text_testimonials', 'Text Testimonials', 3, true, '{ "title": "What Our Clients Say", "subtitle": "Read more reviews from our happy customers.", "testimonials": [ { "name": "Aditi Rao", "review": "Excellent service and beautiful designs. I love my new living room!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-1.jpg", "avatar": "AR" }, { "name": "Vikram Singh", "review": "The team was very responsive and professional. They delivered exactly what they promised.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-2.jpg", "avatar": "VS" }, { "name": "Neha Gupta", "review": "I''m so happy with my new modular kitchen. It''s functional, stylish, and was completed on time.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-3.jpg", "avatar": "NG" } ] }', '{ "title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "testimonials": {"type": "repeater", "label": "Testimonials", "fields": { "name": {"type": "text", "label": "Name"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"}, "avatar": {"type": "text", "label": "Avatar"} }} }');

    -- Other Pages (without sections for now, can be added later)
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES
    ('Products', 'products', 4, 'Our Products', 'Explore our range of high-quality interior products.'),
    ('Portfolio', 'portfolio', 7, 'Our Portfolio', 'Browse our portfolio of completed projects.'),
    ('Contact', 'contact', 9, 'Contact Us', 'Get in touch with us for a free consultation.'),
    ('Appointment', 'appointment', 10, 'Book an Appointment', 'Schedule a free consultation with our design experts.');

END $$;


-- Insert sample data
INSERT INTO stories (slug, title, image, "dataAiHint", category, excerpt, author, "authorAvatar", date, "clientImage", location, project, size, quote, content, gallery, video_gallery) VALUES
(
    'modern-apartment-transformation-pune',
    'A Modern Apartment Transformation in the Heart of Pune',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1.jpg',
    'modern apartment',
    'Apartment Interior',
    'See how we transformed a standard 2BHK apartment into a stylish and functional modern home for a young family.',
    'The Mehta Family',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-1.jpg',
    '2023-11-15',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg',
    'Koregaon Park, Pune',
    '2BHK Full Interior',
    '950 Sq. Ft.',
    'Shriram Interio turned our house into a home. The design is not only beautiful but also incredibly practical for our family.',
    '<div><p>The Mehta family approached us with a common challenge: a standard 2BHK apartment that felt cramped and lacked personality. Their vision was to create a modern, open, and airy space that would be both a comfortable family home and a stylish space for entertaining guests.</p><p>Our design team, led by Priya, started by reconfiguring the living area layout to create a more open-plan feel. We used a neutral color palette with pops of color to make the space feel larger and brighter. Custom storage solutions were integrated throughout the apartment to maximize space and reduce clutter.</p><p>The result is a stunning transformation that perfectly reflects the family''s style and needs. The apartment now feels spacious, modern, and welcoming - a true testament to the power of thoughtful design.</p></div>',
    '[{"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "alt": "Living room before", "dataAiHint": "living room"}, {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "alt": "Living room after", "dataAiHint": "modern living room"}]',
    '[{"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "thumbnail": ""}]'
);

INSERT INTO products (name, slug, short_description, long_description, main_image, features, gallery, amazon_link) VALUES
(
    'L-Shaped Modular Kitchen',
    'l-shaped-modular-kitchen',
    'A versatile and popular choice for modern homes, maximizing corner space.',
    'Our L-shaped modular kitchen is designed for efficiency and style. It offers ample counter space, smart storage solutions, and a seamless workflow, making it perfect for both small and large kitchens.',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-kitchen.jpg',
    '{"High-quality plywood construction", "Durable laminate finish", "Soft-close hinges and drawers", "Customizable colors and finishes"}',
    '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg"}',
    'https://amazon.in'
);

INSERT INTO portfolio (title, slug, content, main_image, gallery) VALUES
(
    'Elegant Living Room, Baner',
    'elegant-living-room-baner',
    'A luxurious living room design featuring custom furniture, ambient lighting, and a sophisticated color palette. The space is designed for both relaxation and entertainment.',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-1.jpg',
    '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg"}'
);

INSERT INTO sales_persons (name, slug, contact_number, profile_image_url) VALUES
('Suresh Kumar', 'suresh-kumar', '9876543210', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg'),
('Priya Singh', 'priya-singh', '9876543211', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg');

INSERT INTO leads (name, email, mobile, services, message, status, assigned_to_id) VALUES
('Ramesh Patel', 'ramesh@example.com', '9988776655', '{"kitchen-unit", "wardrobe"}', 'Looking for a complete kitchen and wardrobe solution for my new 2BHK flat.', 'in progress', 1),
('Sunita Sharma', 'sunita@example.com', '9988776656', '{"tv-unit"}', 'Need a modern TV unit for my living room.', 'qualified', 2);

INSERT INTO quotes (name, email, phone, floorplan, purpose, message) VALUES
('Amit Verma', 'amit@example.com', '8877665544', '3bhk', 'renovation', 'I want to renovate my entire 3BHK flat. Please provide a quote.');

INSERT INTO appointments (name, email, phone, appointment_date, time_slot, floorplan, purpose, services, message) VALUES
('Geeta Desai', 'geeta@example.com', '7766554433', '2024-08-15', '11:00 AM - 12:00 PM', '2bhk', 'new-home', '{"kitchen-unit", "wardrobe", "tv-unit"}', 'We are looking for a full interior solution for our new 2BHK home.');

INSERT INTO social_links (name, slug, url, icon) VALUES
('Facebook', 'facebook', 'https://facebook.com', 'Facebook'),
('Instagram', 'instagram', 'https://instagram.com', 'Instagram');
