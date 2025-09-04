-- Drop existing tables in reverse order of dependency to avoid foreign key constraints errors.
DROP TABLE IF EXISTS "leads";
DROP TABLE IF EXISTS "sales_persons";
DROP TABLE IF EXISTS "quotes";
DROP TABLE IF EXISTS "appointments";
DROP TABLE IF EXISTS "social_links";
DROP TABLE IF EXISTS "stories";
DROP TABLE IF EXISTS "products";
DROP TABLE IF EXISTS "portfolio";
DROP TABLE IF EXISTS "sections";
DROP TABLE IF EXISTS "pages";

-- Create Pages Table
CREATE TABLE pages (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT NOT NULL,
    parent_slug TEXT,
    meta_title TEXT,
    meta_description TEXT,
    nav_order INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE (slug, parent_slug)
);

-- Create Sections Table
CREATE TABLE sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER REFERENCES pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    content JSONB,
    content_structure JSONB,
    "order" INTEGER,
    visible BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Stories Table
CREATE TABLE stories (
    id SERIAL PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    image TEXT NOT NULL,
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


-- Create Products Table
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

-- Create Portfolio Table
CREATE TABLE portfolio (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    content TEXT,
    main_image TEXT,
    gallery TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Sales Persons Table
CREATE TABLE sales_persons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE,
    contact_number TEXT,
    profile_image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Leads Table
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

-- Create Quotes Table
CREATE TABLE quotes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    phone TEXT,
    floorplan TEXT,
    purpose TEXT,
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Appointments Table
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
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

-- Create Social Links Table
CREATE TABLE social_links (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    url TEXT NOT NULL,
    icon TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- Insert initial data
DO $$
DECLARE
    -- Page IDs
    home_page_id INT;
    about_page_id INT;
    services_page_id INT;
    how_it_works_page_id INT;
    clients_page_id INT;
    customer_stories_page_id INT;

BEGIN
    -- Insert Pages
    INSERT INTO pages (title, slug, nav_order, meta_title, meta_description) VALUES
    ('Home', 'home', 1, 'Shriram Interio | Pune''s Premier Interior Designers', 'Discover bespoke interior design solutions in Pune with Shriram Interio. We specialize in creating beautiful, functional spaces that reflect your style.'),
    ('About Us', 'about', 2, 'About Shriram Interio | Our Story & Values', 'Learn about Shriram Interio, our journey, our expert team, and our commitment to design excellence and customer satisfaction.'),
    ('Services', 'services', 3, 'Our Interior Design Services | Shriram Interio', 'Explore our comprehensive interior design services, from modular kitchens and wardrobes to full home interiors and commercial spaces.'),
    ('How It Works', 'how-it-works', 4, 'Our Design Process | How Shriram Interio Works', 'Understand our streamlined and transparent interior design process, from initial consultation to final handover.'),
    ('Clients', 'clients', 5, 'Client Testimonials | Shriram Interio', 'Read what our happy clients have to say about their experience with Shriram Interio. See our commitment to quality and service.'),
    ('Customer Stories', 'customer-stories', 6, 'Customer Success Stories | Shriram Interio Projects', 'Explore detailed stories of our completed projects, showcasing our design process and the beautiful transformations we''ve delivered.'),
    ('Contact', 'contact', 7, 'Contact Shriram Interio | Get In Touch', 'Contact us for a free consultation. Find our address, phone number, and email to start your interior design journey.'),
    ('Appointment', 'appointment', 8, 'Book an Appointment | Shriram Interio', 'Schedule a free design consultation with our experts. Let''s discuss your project and bring your vision to life.'),
    ('Portfolio', 'portfolio', 9, 'Our Portfolio | Shriram Interio Design Projects', 'Browse our portfolio of completed interior design projects. Get inspired by our transformations of kitchens, living rooms, and entire homes.'),
    ('Products', 'products', 10, 'Our Products | High-Quality Interior Solutions', 'Discover our range of high-quality products, including modular kitchens, wardrobes, furniture, and more.'),
    ('Tracking', 'tracking', 11, 'Track Your Project | Shriram Interio', 'Stay updated on the progress of your interior design project with our easy-to-use tracking system.')
    RETURNING id INTO home_page_id, about_page_id, services_page_id, how_it_works_page_id, clients_page_id, customer_stories_page_id;

    -- Get Page IDs for other pages
    SELECT id INTO home_page_id FROM pages WHERE slug = 'home';
    SELECT id INTO about_page_id FROM pages WHERE slug = 'about';
    SELECT id INTO services_page_id FROM pages WHERE slug = 'services';
    SELECT id INTO how_it_works_page_id FROM pages WHERE slug = 'how-it-works';
    SELECT id INTO clients_page_id FROM pages WHERE slug = 'clients';
    SELECT id INTO customer_stories_page_id FROM pages WHERE slug = 'customer-stories';
    
    -- Home Page Sections
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (home_page_id, 'hero', 'Hero', 1, true, 
        '{
            "title": "Welcome to the Interior Designing Company",
            "subtitle": "Your Trusted Partner for Modular Kitchen, Wardrobe & Full Home Interior.",
            "buttonText": "Our Services",
            "videoUrl": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/1.mp4",
            "slides": [
                {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg"},
                {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-2.jpg"},
                {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-3.jpg"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "buttonText": {"type": "text", "label": "Button Text"},
            "videoUrl": {"type": "text", "label": "Background Video URL"},
            "slides": {
                "type": "repeater", "label": "Image Slides",
                "fields": {"image": {"type": "image", "label": "Slide Image"}}
            }
        }'
    ),
    (home_page_id, 'welcome', 'Welcome', 2, true,
        '{
            "title": "Welcome to Shriram Interio",
            "paragraph1": "We are a team of passionate designers and craftsmen dedicated to creating spaces that are not only beautiful but also functional. Our goal is to bring your vision to life, ensuring every detail reflects your personality and style. From modular kitchens to complete home interiors, we handle every project with the utmost care and precision.",
            "paragraph2": "We believe in a collaborative approach, working closely with you from concept to completion. Our commitment to quality materials and superior workmanship ensures that your space is built to last. Let us transform your house into a home you''ll love for years to come.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/welcome.jpg"
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
            "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
            "image": {"type": "image", "label": "Image"}
        }'
    ),
    (home_page_id, 'about_company', 'About Company', 3, true,
        '{
            "title": "Shriram Interio",
            "text": "Your trusted partner for modular kitchen, wardrobe & full home interior design. We craft beautiful, functional spaces tailored to your lifestyle."
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "text": {"type": "textarea", "label": "Text"}
        }'
    ),
    (home_page_id, 'why_us', 'Why Us', 4, true,
        '{
            "title": "Why Shriram Interio?",
            "subtitle": "Discover the reasons why we are the preferred choice for homeowners.",
            "items": [
                {"title": "Expert Design Team", "description": "Our team of experienced designers ensures your vision comes to life with precision and creativity."},
                {"title": "Variety of Design Choices", "description": "We offer a wide range of design options to perfectly match your style and preferences."},
                {"title": "Affordable Design Fees", "description": "Get premium design solutions at competitive prices without compromising on quality."},
                {"title": "On-Time Project Delivery", "description": "We are committed to delivering your project on schedule, every single time."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "items": {
                "type": "repeater", "label": "Items",
                "fields": {
                    "title": {"type": "text", "label": "Item Title"},
                    "description": {"type": "textarea", "label": "Item Description"}
                }
            }
        }'
    ),
    (home_page_id, 'work_gallery', 'Work Gallery', 5, true,
        '{
            "title": "Our Work Gallery",
            "subtitle": "A Glimpse into the Spaces We Have Transformed",
            "items": [
                {"title": "Modern Living Room", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/work-1.jpg", "hint": "modern living room"},
                {"title": "Elegant Bedroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/work-2.jpg", "hint": "elegant bedroom"},
                {"title": "Sleek Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/work-3.jpg", "hint": "sleek kitchen"},
                {"title": "Cozy Study Nook", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/work-4.jpg", "hint": "study nook"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "items": {
                "type": "repeater", "label": "Gallery Items",
                "fields": {
                    "title": {"type": "text", "label": "Item Title"},
                    "image": {"type": "image", "label": "Item Image"},
                    "hint": {"type": "text", "label": "AI Hint"}
                }
            }
        }'
    ),
    (home_page_id, 'comfort_design', 'Design at Your Comfort', 6, true,
        '{
            "title": "Design at Your Comfort",
            "subtitle": "We bring our design expertise to you, wherever you are.",
            "items": [
                {"title": "Live 3D Designs", "description": "Experience your future home with live 3D designing sessions."},
                {"title": "Contactless Experience", "description": "Design your home from the comfort and safety of your couch."},
                {"title": "Instant Pricing", "description": "Get transparent and instant pricing for your project."},
                {"title": "Expertise & Passion", "description": "Our team''s passion and expertise ensure your vision is realized."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "items": {
                "type": "repeater", "label": "Items",
                "fields": {
                    "title": {"type": "text", "label": "Item Title"},
                    "description": {"type": "textarea", "label": "Item Description"}
                }
            }
        }'
    ),
    (home_page_id, 'what_we_do', 'What We Do', 7, true,
        '{
            "title": "What We Do",
            "subtitle": "Explore our best-selling and trending designs.",
            "trendingItems": [
                {"name": "Abstract TV Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-1.jpg", "hint": "abstract tv unit"},
                {"name": "Modern Crockery Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-2.jpg", "hint": "modern crockery unit"},
                {"name": "Minimalist Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-3.jpg", "hint": "minimalist wardrobe"},
                {"name": "Luxury Study Table", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/trending-4.jpg", "hint": "luxury study table"}
            ],
            "bestSellingKitchens": [
                {"name": "L-Shaped Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "hint": "L-shaped kitchen"},
                {"name": "U-Shaped Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "hint": "U-shaped kitchen"},
                {"name": "Parallel Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "hint": "parallel kitchen"},
                {"name": "Island Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-4.jpg", "hint": "island kitchen"}
            ],
            "bestSellingWardrobes": [
                {"name": "Sliding Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "hint": "sliding wardrobe"},
                {"name": "Hinged Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "hint": "hinged wardrobe"},
                {"name": "Walk-in Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-3.jpg", "hint": "walk-in wardrobe"},
                {"name": "Wardrobe with Dresser", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-4.jpg", "hint": "wardrobe with dresser"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "trendingItems": {"type": "repeater", "label": "Trending Items", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}},
            "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}},
            "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}
        }'
    ),
    (home_page_id, 'testimonials', 'Testimonials', 8, true,
        '{
            "title": "Happy Clients",
            "subtitle": "Words from our clients that speak volumes about our service.",
            "buttonText": "View All Testimonials",
            "items": [
                {"name": "Amit Sharma", "review": "Shriram Interio completely transformed our home. The team was professional, and the results exceeded our expectations. Highly recommended!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-1.jpg"},
                {"name": "Priya Singh", "review": "The modular kitchen they designed is not only beautiful but incredibly functional. The entire process was smooth and hassle-free.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-2.jpg"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "buttonText": {"type": "text", "label": "Button Text"},
            "items": {
                "type": "repeater", "label": "Testimonials",
                "fields": {
                    "name": {"type": "text", "label": "Client Name"},
                    "review": {"type": "textarea", "label": "Review"},
                    "image": {"type": "image", "label": "Client Image"}
                }
            }
        }'
    ),
    (home_page_id, 'faq', 'FAQ', 9, true,
        '{
            "title": "Frequently Asked Questions",
            "subtitle": "Answers to common questions about our interior design services.",
            "items": [
                {"question": "What is the typical timeline for a project?", "answer": "A typical full home interior project takes about 8-10 weeks from design finalization to handover. However, this can vary based on the scope and complexity of the project."},
                {"question": "Do you offer a warranty?", "answer": "Yes, we offer a comprehensive 5-year warranty on all our modular products and a 1-year warranty on services. We stand by the quality of our work."},
                {"question": "Can I see the design before execution?", "answer": "Absolutely! We provide detailed 3D visualizations of your space so you can see exactly how it will look and make any changes before we begin execution."},
                {"question": "What are the payment terms?", "answer": "We have a flexible payment structure. Typically, it''s 10% to book, 40% at the start of production, and the final 50% before delivery of materials to the site."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "items": {
                "type": "repeater", "label": "FAQ Items",
                "fields": {
                    "question": {"type": "text", "label": "Question"},
                    "answer": {"type": "textarea", "label": "Answer"}
                }
            }
        }'
    ),
    (home_page_id, 'partners', 'Partners', 10, true,
        '{
            "title": "Our Partners",
            "subtitle": "TRUSTED BY THE BEST",
            "items": [
                {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png"},
                {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png"},
                {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png"},
                {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png"},
                {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "items": {
                "type": "repeater", "label": "Partners",
                "fields": {
                    "name": {"type": "text", "label": "Partner Name"},
                    "logoSrc": {"type": "image", "label": "Logo Image"}
                }
            }
        }'
    );

    -- About Us Page Sections
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (about_page_id, 'hero', 'Hero', 1, true,
        '{
            "title": "About Shriram Interio",
            "subtitle": "Designing Spaces, Creating Stories",
            "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-hero.jpg"
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "backgroundImage": {"type": "image", "label": "Background Image"}
        }'
    ),
    (about_page_id, 'story', 'Our Story', 2, true,
        '{
            "heading": "Our Story",
            "subheading": "The Journey of Shriram Interio",
            "paragraph1": "Founded in 2016, Shriram Interio started with a simple mission: to make high-quality interior design accessible to everyone. We saw a gap in the market for a design firm that was transparent, customer-focused, and dedicated to craftsmanship.",
            "paragraph2": "Our founders, a duo of a passionate designer and a skilled craftsman, combined their expertise to build a company that prioritizes both aesthetics and functionality. From our humble beginnings in a small workshop, we have grown into one of Pune''s most trusted interior design firms.",
            "paragraph3": "We started with modular kitchens and wardrobes, mastering the art of creating beautiful and efficient storage solutions. As our reputation for quality and reliability grew, so did our services.",
            "paragraph4": "Today, we offer comprehensive interior design solutions for both residential and commercial spaces, always staying true to our founding principles of quality, integrity, and customer satisfaction.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-story.jpg"
        }',
        '{
            "heading": {"type": "text", "label": "Heading"},
            "subheading": {"type": "text", "label": "Subheading"},
            "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
            "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
            "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
            "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
            "image": {"type": "image", "label": "Image"}
        }'
    ),
    (about_page_id, 'journey', 'Our Journey', 3, true,
        '{
            "heading": "Our Journey",
            "paragraph1": "The journey of Shriram Interio has been one of continuous growth and learning. We''ve embraced new technologies, from advanced 3D modeling to state-of-the-art manufacturing processes, to enhance our design capabilities and production quality.",
            "paragraph2": "Our team has expanded to include some of the brightest talents in the industry, all sharing a common passion for creating exceptional spaces. We have successfully completed over 500 projects, each one a testament to our dedication and expertise.",
            "paragraph3": "We have built strong relationships with our clients, many of whom have returned to us for new projects and recommended us to their friends and family. This trust is the cornerstone of our success.",
            "paragraph4": "As we look to the future, we are excited to continue pushing the boundaries of design, exploring new materials and techniques to create spaces that are not only beautiful but also sustainable and timeless.",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-journey.jpg"
        }',
        '{
            "heading": {"type": "text", "label": "Heading"},
            "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
            "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
            "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
            "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
            "image": {"type": "image", "label": "Image"}
        }'
    ),
    (about_page_id, 'values', 'Our Values', 4, true,
        '{
            "title": "Our Core Values",
            "subtitle": "The principles that guide us in everything we do.",
            "items": [
                {"title": "Expert Design Team", "description": "Our team of experienced designers ensures your vision comes to life with precision and creativity."},
                {"title": "Variety of Design Choices", "description": "We offer a wide range of design options to perfectly match your style and preferences."},
                {"title": "Affordable Design Fees", "description": "Get premium design solutions at competitive prices without compromising on quality."},
                {"title": "On-Time Project Delivery", "description": "We are committed to delivering your project on schedule, every single time."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "items": {
                "type": "repeater", "label": "Value Items",
                "fields": {
                    "title": {"type": "text", "label": "Value Title"},
                    "description": {"type": "textarea", "label": "Value Description"}
                }
            }
        }'
    ),
    (about_page_id, 'mission_vision', 'Mission & Vision', 5, true,
        '{
            "visionTitle": "Our Vision",
            "visionText": "To be the most sought-after interior design firm in Pune, known for our innovative designs, exceptional quality, and unwavering commitment to customer satisfaction.",
            "missionTitle": "Our Mission",
            "missionText": "To create beautiful, functional, and personalized living and working spaces that inspire and enhance the lives of our clients, through a collaborative and transparent design process."
        }',
        '{
            "visionTitle": {"type": "text", "label": "Vision Title"},
            "visionText": {"type": "textarea", "label": "Vision Text"},
            "missionTitle": {"type": "text", "label": "Mission Title"},
            "missionText": {"type": "textarea", "label": "Mission Text"}
        }'
    ),
    (about_page_id, 'team', 'Meet the Team', 6, true,
        '{
            "title": "Meet Our Team",
            "subtitle": "The creative minds behind our success.",
            "members": [
                {"name": "Ramesh Patel", "role": "Founder & Lead Designer", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg", "bio": "With over 15 years of experience, Ramesh leads our design team with a passion for creating innovative and timeless spaces."},
                {"name": "Suresh Gupta", "role": "Co-Founder & Operations Head", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg", "bio": "Suresh ensures that every project is executed flawlessly, from material procurement to final installation, with a keen eye for quality and detail."},
                {"name": "Priya Desai", "role": "Senior Interior Designer", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-3.jpg", "bio": "Priya specializes in residential interiors, creating warm and inviting homes that reflect the unique personalities of their owners."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "text", "label": "Subtitle"},
            "members": {
                "type": "repeater", "label": "Team Members",
                "fields": {
                    "name": {"type": "text", "label": "Name"},
                    "role": {"type": "text", "label": "Role"},
                    "image": {"type": "image", "label": "Image"},
                    "bio": {"type": "textarea", "label": "Bio"}
                }
            }
        }'
    );

    -- Services Page Sections
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (services_page_id, 'header', 'Header', 1, true,
        '{
            "title": "Our Services",
            "subtitle": "Crafting spaces that inspire. Explore our wide range of interior design services tailored to meet your needs."
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"}
        }'
    ),
    (services_page_id, 'our_services', 'Our Services', 2, true,
        '{
            "services": [
                {"title": "Modular Kitchen Design", "description": "We design and build beautiful, functional modular kitchens with smart storage solutions and premium finishes."},
                {"title": "Wardrobe & Storage Solutions", "description": "Customized wardrobes and storage units that maximize space and complement your bedroom''s decor."},
                {"title": "Bedroom Interiors", "description": "Create your personal sanctuary with our complete bedroom interior design services."},
                {"title": "Living Area Design", "description": "From TV units to full living room makeovers, we design spaces for you to relax and entertain in style."},
                {"title": "Exterior Design Services", "description": "Enhance your home''s curb appeal with our expert exterior design and landscaping services."},
                {"title": "Full Home Interiors", "description": "A complete, end-to-end interior design solution for your entire home, from concept to completion."}
            ]
        }',
        '{
            "services": {
                "type": "repeater", "label": "Services",
                "fields": {
                    "title": {"type": "text", "label": "Service Title"},
                    "description": {"type": "textarea", "label": "Service Description"}
                }
            }
        }'
    );

    -- How It Works Page Sections
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (how_it_works_page_id, 'hero', 'Hero', 1, true,
        '{
            "title": "How It Works",
            "subtitle": "Our simple and transparent process to bring your dream home to life.",
            "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/how-it-works-hero.jpg"
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "backgroundImage": {"type": "image", "label": "Background Image"}
        }'
    ),
    (how_it_works_page_id, 'process', 'Our Process', 2, true,
        '{
            "title": "Our 5-Step Design Process",
            "subtitle": "A clear roadmap from your first idea to your finished space.",
            "steps": [
                {"icon": "Handshake", "title": "Consultation & Understanding", "description": "We start by meeting you to understand your needs, preferences, and budget. This is where we lay the foundation for your project."},
                {"icon": "PencilRuler", "title": "Design & Visualization", "description": "Our designers create detailed 2D layouts and 3D models, so you can visualize your space before any work begins."},
                {"icon": "MessageSquareQuote", "title": "Material Selection & Quoting", "description": "We help you choose the perfect materials and finishes, followed by a transparent, itemized quote with no hidden costs."},
                {"icon": "Truck", "title": "Execution & Delivery", "description": "Our skilled craftsmen and project managers bring the design to life, ensuring the highest quality standards and timely completion."},
                {"icon": "Star", "title": "Handover & Support", "description": "We walk you through your new space, hand over the keys, and provide post-completion support to ensure you''re completely satisfied."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "steps": {
                "type": "repeater", "label": "Process Steps",
                "fields": {
                    "icon": {"type": "text", "label": "Icon Name"},
                    "title": {"type": "text", "label": "Step Title"},
                    "description": {"type": "textarea", "label": "Step Description"}
                }
            }
        }'
    ),
    (how_it_works_page_id, 'why_us', 'Why Our Process Works', 3, true,
        '{
            "title": "Why Our Process Works",
            "subtitle": "The benefits of our client-centric approach.",
            "benefits": [
                {"icon": "ThumbsUp", "title": "Client-Centric", "description": "Your needs and vision are at the heart of our process. We listen, collaborate, and adapt to ensure the final space is uniquely yours."},
                {"icon": "Wallet", "title": "Transparent Pricing", "description": "No surprises. Our detailed quotes give you a clear breakdown of all costs, so you can make informed decisions with confidence."},
                {"icon": "Smile", "title": "Assured Quality", "description": "We use only the finest materials and skilled craftsmen, backed by a 5-year warranty, to deliver a home that is built to last."}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "benefits": {
                "type": "repeater", "label": "Benefits",
                "fields": {
                    "icon": {"type": "text", "label": "Icon Name"},
                    "title": {"type": "text", "label": "Benefit Title"},
                    "description": {"type": "textarea", "label": "Benefit Description"}
                }
            }
        }'
    ),
    (how_it_works_page_id, 'get_started', 'Get Started', 4, true,
        '{
            "title": "Ready to Start Your Project?",
            "subtitle": "Let''s create a space you''ll love. Book a free consultation with our design experts today.",
            "buttonText": "Book a Free Consultation"
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "buttonText": {"type": "text", "label": "Button Text"}
        }'
    );

    -- Clients Page Sections
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (clients_page_id, 'featured_testimonial', 'Featured Testimonial', 1, true,
        '{
            "name": "Mr. Vikram Singh",
            "location": "Pune",
            "project": "Full Home Interior",
            "size": "3 BHK",
            "quote": "The team at Shriram Interio turned our house into a dream home.",
            "review": "From the initial design to the final handover, the entire process was seamless and professional. They listened to our needs and delivered a space that is both beautiful and functional. The quality of work is exceptional, and we couldn''t be happier with the outcome. Highly recommended!",
            "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-featured.jpg"
        }',
        '{
            "name": {"type": "text", "label": "Name"},
            "location": {"type": "text", "label": "Location"},
            "project": {"type": "text", "label": "Project Type"},
            "size": {"type": "text", "label": "Project Size"},
            "quote": {"type": "textarea", "label": "Quote"},
            "review": {"type": "textarea", "label": "Review"},
            "image": {"type": "image", "label": "Image"}
        }'
    ),
    (clients_page_id, 'video_testimonials', 'Video Testimonials', 2, true,
        '{
            "title": "Our Clients in Their Own Words",
            "subtitle": "Watch our clients share their experiences with Shriram Interio.",
            "videos": [
                {"name": "The Sharma Family", "location": "Koregaon Park, Pune", "review": "Our kitchen is now the heart of our home, thanks to the amazing team.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg", "dataAiHint": "family kitchen"},
                {"name": "Anjali & Rohan", "location": "Hinjewadi, Pune", "review": "They designed the perfect cozy and modern living room for us.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg", "dataAiHint": "couple living room"},
                {"name": "Mr. Deshpande", "location": "Aundh, Pune", "review": "Professional, punctual, and perfect execution. What more could you ask for?", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg", "dataAiHint": "man home office"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "videos": {
                "type": "repeater", "label": "Videos",
                "fields": {
                    "name": {"type": "text", "label": "Name"},
                    "location": {"type": "text", "label": "Location"},
                    "review": {"type": "textarea", "label": "Review"},
                    "videoUrl": {"type": "text", "label": "Video URL"},
                    "imageSrc": {"type": "image", "label": "Thumbnail Image"},
                    "dataAiHint": {"type": "text", "label": "AI Hint"}
                }
            }
        }'
    ),
    (clients_page_id, 'text_testimonials', 'Text Testimonials', 3, true,
        '{
            "title": "What Our Clients Say",
            "subtitle": "Don''t just take our word for it. Here''s what our clients have to say about their experience.",
            "testimonials": [
                {"name": "Rajesh Kumar", "avatar": "RK", "review": "Exceptional service and design. The team was very cooperative and understood our requirements perfectly. The final output was beyond our expectations.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-1.jpg"},
                {"name": "Sunita Patil", "avatar": "SP", "review": "Shriram Interio did a fantastic job with our wardrobe. It''s spacious, elegant, and fits perfectly with our bedroom''s aesthetic. Great work!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-2.jpg"},
                {"name": "Manoj Joshi", "avatar": "MJ", "review": "The entire process was so smooth and transparent. I was regularly updated on the progress, and the project was completed on time. Highly professional team.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-3.jpg"},
                {"name": "Deepa Nair", "avatar": "DN", "review": "I love my new modular kitchen! It''s so well-planned and has made my cooking experience so much more enjoyable. Thank you, Shriram Interio!", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-4.jpg"},
                {"name": "Anil Agarwal", "avatar": "AA", "review": "The quality of materials used is top-notch. They delivered exactly what was promised. A very reliable and trustworthy company.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-5.jpg"},
                {"name": "Pooja Mehta", "avatar": "PM", "review": "Their 3D designs helped me visualize my home perfectly. The end result was exactly as I had imagined. A wonderful experience overall.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-6.jpg"}
            ]
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"},
            "testimonials": {
                "type": "repeater", "label": "Testimonials",
                "fields": {
                    "name": {"type": "text", "label": "Name"},
                    "avatar": {"type": "text", "label": "Avatar Fallback (Initials)"},
                    "review": {"type": "textarea", "label": "Review"},
                    "image": {"type": "image", "label": "Avatar Image"}
                }
            }
        }'
    );
    
    -- Customer Stories Page Sections
    INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (customer_stories_page_id, 'header', 'Header', 1, true,
        '{
            "title": "Customer Stories",
            "subtitle": "Discover the transformations we''ve created for our clients, from their perspective."
        }',
        '{
            "title": {"type": "text", "label": "Title"},
            "subtitle": {"type": "textarea", "label": "Subtitle"}
        }'
    ),
    (customer_stories_page_id, 'featured_story', 'Featured Story', 2, true,
        '{
            "buttonText": "Read The Full Story"
        }',
        '{
            "buttonText": {"type": "text", "label": "Button Text"}
        }'
    ),
    (customer_stories_page_id, 'more_stories', 'More Stories', 3, true,
        '{
            "title": "More Inspiring Stories"
        }',
        '{
            "title": {"type": "text", "label": "Title"}
        }'
    );

    -- Insert Sample Story
    INSERT INTO stories (slug, title, image, "dataAiHint", category, excerpt, author, "authorAvatar", date, "clientImage", location, project, size, quote, content, gallery, video_gallery) VALUES
    ('modern-apartment-makeover-pune', 'Modern Apartment Makeover in Pune', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1.jpg', 'modern apartment', 'Residential', 'See how we transformed a standard 2BHK apartment in Baner into a modern, functional, and stylish home for a young family.', 'The Kulkarni Family', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-1.jpg', '2023-11-15', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-1.jpg', 'Baner, Pune', 'Full Home Interior', '2 BHK', 'Shriram Interio didn''t just design our house; they understood our lifestyle and created a home that is perfect for us.', 
    '<div><p>The Kulkarni family, a young couple with a toddler, approached us with a common challenge: a standard-issue 2BHK apartment that felt impersonal and lacked efficient storage. Their vision was for a modern, clutter-free home that was child-friendly, easy to maintain, and reflected their vibrant personalities.</p><p>Our design process began with understanding their daily routines, storage needs, and aesthetic preferences. We opted for a neutral color palette with pops of color to create a sense of spaciousness and warmth. Smart, multi-functional furniture and clever storage solutions were key to achieving the clutter-free look they desired.</p><h3>The Transformation</h3><p>The living room was redesigned to be an open, inviting space for family time and entertaining guests. A custom-built TV unit with concealed storage became the focal point, while a comfortable, durable L-shaped sofa provided ample seating. In the kitchen, we installed a sleek, handle-less modular setup with a quartz countertop, optimizing workflow and storage. The master bedroom was transformed into a serene retreat with a custom wardrobe featuring a mix of open and closed storage, and a cozy reading nook by the window. The child''s room was designed to be a playful and adaptable space, with a neutral base and colorful, easy-to-change decor elements.</p><h3>The Result</h3><p>The final result is a home that is not only beautiful but also highly functional and personal. The Kulkarnis now have a space that works for their lifestyle, with dedicated zones for relaxation, work, and play. The project was completed on time and within budget, and the family was thrilled with their new home.</p></div>',
    '[
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "alt": "Living Room", "dataAiHint": "living room"},
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "alt": "Kitchen", "dataAiHint": "modern kitchen"},
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-3.jpg", "alt": "Bedroom", "dataAiHint": "master bedroom"}
    ]',
    '[
        {"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "thumbnail": ""},
        {"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "thumbnail": ""}
    ]'
    );
    
    INSERT INTO stories (slug, title, image, "dataAiHint", category, excerpt, author, "authorAvatar", date, "clientImage", location, project, size, quote, content) VALUES
    ('elegant-3bhk-hinjewadi', 'Elegant 3BHK Transformation in Hinjewadi', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2.jpg', 'elegant apartment', 'Residential', 'A complete overhaul of a 3BHK, focusing on luxury, comfort, and creating distinct zones for a family of four.', 'The Verma Family', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/avatar-2.jpg', '2023-10-20', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-2.jpg', 'Hinjewadi, Pune', 'Full Home Interior', '3 BHK', 'The attention to detail was impeccable. Our home feels like a luxury hotel now, but with the warmth of a family space.',
    '<div><p>The Verma family wanted to upgrade their 3BHK into a space that felt both luxurious and comfortable. Their main requirements were a sophisticated living area for entertaining, a highly functional kitchen, and peaceful, private bedrooms for each family member.</p><p>We used a palette of warm neutrals, rich wood tones, and metallic accents to create an atmosphere of understated elegance. Lighting played a key role, with a mix of ambient, task, and accent lighting used to create different moods. The layout was optimized to create a seamless flow between the living, dining, and kitchen areas, making the space feel larger and more connected.</p></div>'
    );

    -- Insert Sample Products
    INSERT INTO products (name, slug, short_description, long_description, main_image, features, gallery, amazon_link) VALUES
    ('L-Shaped Modular Kitchen', 'l-shaped-modular-kitchen', 'Efficient and versatile, perfect for modern homes.', 'Our L-shaped modular kitchen is designed to maximize corner space, making it a popular choice for both small and large kitchens. It offers an efficient work triangle and ample counter space, creating a seamless cooking experience. Customize it with a variety of finishes and storage options to suit your style.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg', '{"High-quality plywood", "German hardware", "Variety of finishes", "Smart storage solutions"}', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-detail-1.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-detail-2.jpg"}', 'https://www.amazon.in'),
    ('Sliding Door Wardrobe', 'sliding-door-wardrobe', 'Sleek, modern, and space-saving.', 'Ideal for compact rooms, our sliding door wardrobes offer a modern and elegant storage solution without requiring extra space for door swing. With customizable interiors, you can design a wardrobe that perfectly fits your storage needs, from hanging space to drawers and shelves.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg', '{"Space-saving design", "Smooth sliding mechanism", "Customizable interiors", "Mirrored and panel options"}', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-detail-1.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-detail-2.jpg"}', 'https://www.amazon.in');

    -- Insert Sample Portfolio Item
    INSERT INTO portfolio (title, slug, content, main_image, gallery) VALUES
    ('Minimalist Living Room', 'minimalist-living-room', '<div><p>This project focused on creating a calm and serene living space using a minimalist aesthetic. We used a neutral color palette, clean lines, and natural materials like wood and linen to create a sense of tranquility. The custom TV unit provides ample storage while maintaining the uncluttered look. Strategic lighting enhances the architectural details and creates a warm, inviting ambiance in the evenings.</p></div>', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-1.jpg', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-gallery-1.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-gallery-2.jpg"}');

    INSERT INTO portfolio (title, slug, content, main_image, gallery) VALUES
    ('Luxury Bedroom Design', 'luxury-bedroom-design', '<div><p>We designed this master bedroom to be a luxurious retreat. It features a custom upholstered headboard, elegant pendant lights, and a plush area rug. The wardrobe has a high-gloss laminate finish, and the room is painted in a calming shade of blue to promote relaxation.</p></div>', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-2.jpg', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-gallery-3.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-gallery-4.jpg"}');

    -- Insert Sample Sales Person
    INSERT INTO sales_persons (name, slug, contact_number, profile_image_url) VALUES
    ('Amit Patel', 'amit-patel', '9876543210', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/sales-1.jpg');
    
    INSERT INTO sales_persons (name, slug, contact_number, profile_image_url) VALUES
    ('Sunita Sharma', 'sunita-sharma', '9876543211', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/sales-2.jpg');
    
    -- Insert Sample Lead
    INSERT INTO leads (name, email, mobile, services, status, assigned_to_id) VALUES
    ('Ravi Verma', 'ravi.verma@example.com', '9988776655', '{"kitchen-unit", "wardrobe"}', 'in progress', 1);

    -- Insert Social Links
    INSERT INTO social_links (name, slug, url, icon) VALUES
    ('Facebook', 'facebook', 'https://facebook.com', 'Facebook'),
    ('Instagram', 'instagram', 'https://instagram.com', 'Instagram'),
    ('Twitter', 'twitter', 'https://twitter.com', 'Twitter'),
    ('Youtube', 'youtube', 'https://youtube.com', 'Youtube');

END $$;

    