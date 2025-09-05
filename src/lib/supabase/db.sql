-- Create the table for pages
CREATE TABLE pages (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    parent_slug TEXT,
    meta_title TEXT,
    meta_description TEXT,
    nav_order INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the table for sections
CREATE TABLE sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER REFERENCES pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    content JSONB,
    content_structure JSONB,
    "order" INTEGER,
    visible BOOLEAN DEFAULT TRUE
);

-- Create table for stories
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
    video_gallery JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create table for products
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

-- Create table for portfolio
CREATE TABLE portfolio (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    content TEXT,
    main_image TEXT,
    gallery TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the table for sales persons
CREATE TABLE sales_persons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE,
    contact_number TEXT,
    profile_image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the table for leads
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

-- Create table for quotes
CREATE TABLE quotes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    floorplan TEXT,
    purpose TEXT,
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create table for appointments
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    appointment_date DATE NOT NULL,
    time_slot TEXT NOT NULL,
    floorplan TEXT,
    purpose TEXT,
    services TEXT[],
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create table for social links
CREATE TABLE social_links (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    url TEXT NOT NULL,
    icon TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- Insert initial data
INSERT INTO pages (title, slug, parent_slug, meta_title, meta_description, nav_order) VALUES
('Home', 'home', NULL, 'Shriram Interio Digital', 'Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors.', 1),
('About Us', 'about', NULL, 'About Shriram Interio', 'Learn about our journey, mission, and the team behind our designs.', 2),
('Customer Stories', 'customer-stories', NULL, 'Customer Stories', 'See how we have transformed homes and lives.', 3),
('How It Works', 'how-it-works', NULL, 'How It Works', 'Our seamless process from consultation to project completion.', 5),
('Services', 'services', NULL, 'Our Services', 'Explore our range of interior design services.', 6),
('Portfolio', 'portfolio', NULL, 'Our Portfolio', 'Browse our portfolio of completed projects.', 7),
('Clients', 'clients', NULL, 'Our Clients', 'See what our clients have to say about us.', 4),
('Appointment', 'appointment', NULL, 'Book an Appointment', 'Schedule a consultation with our design experts.', 9),
('Contact', 'contact', NULL, 'Contact Us', 'Get in touch with us for any inquiries.', 10),
('Products', 'products', NULL, 'Our Products', 'Explore our range of high-quality interior products.', 8);


-- Home Page Sections
WITH home_page AS (SELECT id FROM pages WHERE slug = 'home')
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure)
VALUES
((SELECT id FROM home_page), 'hero', 'Hero', 1, TRUE,
  '{"slides": [{"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg"}, {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-2.jpg"}, {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-3.jpg"}], "title": "Designing Dreams, Crafting Realities", "videoUrl": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-video.mp4", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors.", "buttonText": "Explore Our Services"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "videoUrl": {"type": "text", "label": "Background Video URL"}, "slides": {"type": "repeater", "label": "Image Slides", "fields": {"image": {"type": "image", "label": "Slide Image"}}}}'
),
((SELECT id FROM home_page), 'welcome', 'Welcome Section', 2, TRUE,
  '{"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/welcome-image.jpg", "title": "Welcome to Shriram Interio", "paragraph1": "SHRIRAM INTERIO is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul.", "paragraph2": "Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."}',
  '{"title": {"type": "text", "label": "Title"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "image": {"type": "image", "label": "Image"}}'
),
((SELECT id FROM home_page), 'about_company', 'About Company', 3, TRUE,
  '{"text": "Is Pune''s leading Interior designer for modular kitchens, wardrobes and full home interiors. Our team of professional designers and decorators are dedicated to creating spaces that are not only beautiful but also functional, comfortable, and a true reflection of your personality.", "title": "About Company"}',
  '{"title": {"type": "text", "label": "Title"}, "text": {"type": "textarea", "label": "Text"}}'
),
((SELECT id FROM home_page), 'why_us', 'Why Us', 4, TRUE,
  '{"items": [{"title": "Expert Design Team", "description": "Our team of professional designers and decorators are dedicated to creating spaces that are not only beautiful but also functional and comfortable."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of design choices to suit every taste and budget, from modern and minimalist to classic and traditional."}, {"title": "Affordable Design Fees", "description": "We believe that great design should be accessible to everyone. That''s why we offer competitive design fees without compromising on quality."}, {"title": "On-Time Project Delivery", "description": "We understand the importance of timely project completion. Our team works diligently to ensure that your project is delivered on schedule."}], "title": "Why Shriram Interio?", "subtitle": "The region''s leading interior design company for modular kitchens, wardrobes and full home interiors."}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM home_page), 'work_gallery', 'Work Gallery', 5, TRUE,
  '{"items": [{"hint": "modern kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen.jpg", "title": "Modern Kitchen", "gallery_images": [{"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg"},{"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg"}]}, {"hint": "living room", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/living-room.jpg", "title": "Spacious Living Room", "gallery_images": []}, {"hint": "cozy bedroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bedroom.jpg", "title": "Cozy Bedroom", "gallery_images": []}, {"hint": "elegant dining", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/dining.jpg", "title": "Elegant Dining Area", "gallery_images": []}], "title": "Our Work Gallery", "subtitle": "A Glimpse into Our World of Design"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Gallery Items", "fields": {"title": {"type": "text", "label": "Title"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}, "gallery_images": {"type": "repeater", "label": "Gallery Images", "fields": {"image": {"type": "image", "label": "Image"}}}}}}'
),
((SELECT id FROM home_page), 'comfort_design', 'Comfort Design', 6, TRUE,
  '{"items": [{"title": "Live 3D Designs", "description": "Experience your dream home with our live 3D designing, making your vision a reality before your eyes."}, {"title": "Contactless Experience", "description": "Design your interiors from the comfort and safety of your home with our seamless contactless services."}, {"title": "Instant Pricing", "description": "Get transparent, all-inclusive quotes for your project instantly, ensuring no hidden costs or surprises."}, {"title": "Expertise & Passion", "description": "Our team combines passion with expertise to deliver innovative and personalized interior designs."}], "title": "Designing at Your Comfort", "subtitle": "Our Expertise, Your Convenience"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM home_page), 'what_we_do', 'What We Do', 7, TRUE,
  '{"title": "What We Do", "subtitle": "Exploring Our Popular Designs", "trendingItems": [{"name": "Modern TV Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/tv-unit-1.jpg", "hint": "modern tv unit"}, {"name": "Classic Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "hint": "classic wardrobe"}, {"name": "L-Shaped Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "hint": "l-shaped kitchen"}, {"name": "Contemporary Sofa", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/sofa-1.jpg", "hint": "contemporary sofa"}], "bestSellingKitchens": [{"name": "U-Shaped Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "hint": "modular kitchen"}, {"name": "Parallel Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "hint": "parallel kitchen"}, {"name": "Island Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-4.jpg", "hint": "island kitchen"}, {"name": "Straight Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-5.jpg", "hint": "straight kitchen"}], "bestSellingWardrobes": [{"name": "Sliding Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "hint": "sliding wardrobe"}, {"name": "Hinged Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-3.jpg", "hint": "hinged wardrobe"}, {"name": "Walk-in Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-4.jpg", "hint": "walk-in wardrobe"}, {"name": "Mirrored Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-5.jpg", "hint": "mirrored wardrobe"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "trendingItems": {"type": "repeater", "label": "Trending Items", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}, "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}, "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM home_page), 'testimonials', 'Testimonials', 8, TRUE,
  '{"items": [{"name": "Ravi Kumar", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg", "review": "Shriram Interio turned our house into a home. Their attention to detail and creative flair are unmatched. We couldn''t be happier!"}, {"name": "Priya Sharma", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg", "review": "The team was professional, and the project was completed on time and within budget. Highly recommended!"}], "title": "What Our Clients Say", "subtitle": "Stories of Transformed Spaces and Satisfied Smiles", "buttonText": "View All Testimonials"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "items": {"type": "repeater", "label": "Items", "fields": {"name": {"type": "text", "label": "Name"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"}}}}'
),
((SELECT id FROM home_page), 'faq', 'FAQ', 9, TRUE,
  '{"items": [{"answer": "We specialize in modular kitchens, wardrobes, and full home interiors, including living rooms, bedrooms, and dining areas. We also offer custom furniture design.", "question": "What services do you offer?"}, {"answer": "Our process begins with a free consultation to understand your needs. We then create a 3D design, finalize materials, and execute the project with our expert team, ensuring quality and timeliness.", "question": "How does the design process work?"}, {"answer": "Project timelines vary depending on the scope. A standard modular kitchen may take 4-6 weeks, while a full home interior could take 8-12 weeks from design approval to completion.", "question": "How long will my project take?"}], "title": "Frequently Asked Questions", "subtitle": "Your Questions, Answered"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "FAQ Items", "fields": {"question": {"type": "text", "label": "Question"}, "answer": {"type": "textarea", "label": "Answer"}}}}'
),
((SELECT id FROM home_page), 'partners', 'Partners', 10, TRUE,
  '{"items": [{"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-1.png"}, {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-2.png"}, {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-3.png"}, {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-4.png"}, {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/partner-5.png"}], "title": "Our Trusted Partners", "subtitle": "ASSOCIATE WITH"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Partners", "fields": {"name": {"type": "text", "label": "Name"}, "logoSrc": {"type": "image", "label": "Logo"}}}}'
);

-- About Page Sections
WITH about_page AS (SELECT id FROM pages WHERE slug = 'about')
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure)
VALUES
((SELECT id FROM about_page), 'hero', 'Hero', 1, TRUE,
  '{"title": "About Shriram Interio", "subtitle": "Crafting beautiful and functional spaces since 2016", "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-hero.jpg"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'
),
((SELECT id FROM about_page), 'story', 'Our Story', 2, TRUE,
  '{"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/our-story.jpg", "heading": "Our Story", "subheading": "The Journey of Shriram Interio", "paragraph1": "SHRIRAM INTERIO is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul.", "paragraph2": "Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project.", "paragraph3": "Over the years, we''ve evolved, but our commitment to excellence remains unwavering.", "paragraph4": "We believe that a well-designed space has the power to enhance your quality of life, and we are committed to making this a reality for each of our clients."}',
  '{"heading": {"type": "text", "label": "Heading"}, "subheading": {"type": "text", "label": "Subheading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
),
((SELECT id FROM about_page), 'journey', 'Our Journey', 3, TRUE,
 '{"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/our-journey.jpg", "heading": "Our Journey", "paragraph1": "Our story is one of growth, learning, and an unyielding passion for design. From our humble beginnings to becoming a trusted name in the industry, every project has been a milestone, shaping us into who we are today.", "paragraph2": "We''ve had the privilege of working on a diverse range of projects, each with its unique challenges and opportunities. This has not only honed our skills but also deepened our understanding of what it takes to create truly exceptional interiors.", "paragraph3": "Our portfolio is a testament to our journey, showcasing our versatility and our ability to adapt to different styles and preferences.", "paragraph4": "We are proud of what we''ve achieved, and we look forward to continuing our journey, creating beautiful and functional spaces for our clients."}',
 '{"heading": {"type": "text", "label": "Heading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
),
((SELECT id FROM about_page), 'values', 'Our Values', 4, TRUE,
  '{"items": [{"title": "Expert Design Team", "description": "Our team of professional designers and decorators are dedicated to creating spaces that are not only beautiful but also functional and comfortable."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of design choices to suit every taste and budget, from modern and minimalist to classic and traditional."}, {"title": "Affordable Design Fees", "description": "We believe that great design should be accessible to everyone. That''s why we offer competitive design fees without compromising on quality."}, {"title": "On-Time Project Delivery", "description": "We understand the importance of timely project completion. Our team works diligently to ensure that your project is delivered on schedule."}], "title": "Our Core Values", "subtitle": "The principles that guide our work and define our culture."}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM about_page), 'mission_vision', 'Mission and Vision', 5, TRUE,
  '{"missionText": "Our mission is to create beautiful and functional spaces that enhance the quality of life for our clients. We are committed to delivering exceptional design solutions that are tailored to their unique needs and preferences.", "missionTitle": "Our Mission", "visionText": "Our vision is to be the leading interior design firm in the region, known for our creativity, innovation, and commitment to excellence. We aim to set new standards in design and customer satisfaction.", "visionTitle": "Our Vision"}',
  '{"visionTitle": {"type": "text", "label": "Vision Title"}, "visionText": {"type": "textarea", "label": "Vision Text"}, "missionTitle": {"type": "text", "label": "Mission Title"}, "missionText": {"type": "textarea", "label": "Mission Text"}}'
),
((SELECT id FROM about_page), 'team', 'Meet the Team', 6, TRUE,
  '{"members": [{"bio": "With over 15 years of experience, John is the creative force behind our most iconic designs. His passion for modern aesthetics and sustainable materials is evident in every project.", "name": "John Doe", "role": "Lead Designer", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg"}, {"bio": "Jane manages our projects from start to finish, ensuring everything runs smoothly and on schedule. Her attention to detail is second to none.", "name": "Jane Smith", "role": "Project Manager", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg"}, {"bio": "Mike is our expert in material sourcing and vendor relations, ensuring we use only the highest quality materials for your home.", "name": "Mike Johnson", "role": "Materials Specialist", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-3.jpg"}], "title": "Meet Our Team", "subtitle": "The creative minds behind our successful projects."}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "members": {"type": "repeater", "label": "Team Members", "fields": {"name": {"type": "text", "label": "Name"}, "role": {"type": "text", "label": "Role"}, "bio": {"type": "textarea", "label": "Bio"}, "image": {"type": "image", "label": "Image"}}}}'
);

-- How It Works Page Sections
WITH how_it_works_page AS (SELECT id FROM pages WHERE slug = 'how-it-works')
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure)
VALUES
((SELECT id FROM how_it_works_page), 'hero', 'Hero', 1, TRUE,
 '{"title": "Our Process", "subtitle": "From Concept to Creation: A Seamless Journey to Your Dream Home", "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/how-it-works-hero.jpg"}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'
),
((SELECT id FROM how_it_works_page), 'process', 'Process Steps', 2, TRUE,
 '{"steps": [{"icon": "Handshake", "title": "Consultation", "description": "We start with a detailed consultation to understand your vision, requirements, and budget."}, {"icon": "PencilRuler", "title": "Design & 3D Visualization", "description": "Our team creates a customized design plan with 3D models to help you visualize the final outcome."}, {"icon": "Truck", "title": "Execution & Delivery", "description": "Our skilled craftsmen bring the design to life with precision and high-quality materials, ensuring timely delivery."}, {"icon": "ShieldCheck", "title": "Quality Check", "description": "We conduct thorough quality checks at every stage to ensure the highest standards of workmanship."}, {"icon": "Star", "title": "Handover & Warranty", "description": "We hand over your dream space and provide a comprehensive warranty for your peace of mind."}, {"icon": "MessageSquareQuote", "title": "Post-Installation Support", "description": "Our relationship doesn''t end at handover. We offer post-installation support to ensure your complete satisfaction."}], "title": "Our Working Process", "subtitle": "A Step-by-Step Guide to Your Dream Interior"}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "steps": {"type": "repeater", "label": "Steps", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}, "icon": {"type": "text", "label": "Icon Name"}}}}'
),
((SELECT id FROM how_it_works_page), 'why_us', 'Why Us', 3, TRUE,
 '{"benefits": [{"icon": "ThumbsUp", "title": "Customer-Centric Approach", "description": "We prioritize your needs and preferences, ensuring a personalized and collaborative design experience."}, {"icon": "Wallet", "title": "Transparent Pricing", "description": "We provide detailed and transparent quotes, so you know exactly what you''re paying for without any hidden costs."}, {"icon": "Smile", "title": "Satisfaction Guaranteed", "description": "Our ultimate goal is your happiness. We go the extra mile to ensure you are delighted with your new space."}], "title": "Why Our Process Works", "subtitle": "The benefits of choosing our streamlined and transparent approach."}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "benefits": {"type": "repeater", "label": "Benefits", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}, "icon": {"type": "text", "label": "Icon Name"}}}}'
),
((SELECT id FROM how_it_works_page), 'get_started', 'Get Started', 4, TRUE,
 '{"title": "Ready to Start Your Project?", "subtitle": "Let''s create a space that you''ll love for years to come. Schedule your free consultation today.", "buttonText": "Book a Free Consultation"}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}}'
);

-- Services Page Sections
WITH services_page AS (SELECT id FROM pages WHERE slug = 'services')
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure)
VALUES
((SELECT id FROM services_page), 'header', 'Header', 1, TRUE,
 '{"title": "Our Services", "subtitle": "Crafting functional and beautiful spaces tailored to your lifestyle."}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}}'
),
((SELECT id FROM services_page), 'our_services', 'Our Services', 2, TRUE,
 '{"services": [{"title": "Modular Kitchen Design", "description": "We design and build custom modular kitchens that are both stylish and highly functional."}, {"title": "Wardrobe & Storage Solutions", "description": "Maximize your space with our custom-designed wardrobes and smart storage solutions."}, {"title": "Bedroom Interiors", "description": "Create a serene and personal sanctuary with our bespoke bedroom interior designs."}, {"title": "Living Area Design", "description": "Transform your living area into a welcoming space for family and guests."}, {"title": "Exterior Design Services", "description": "Enhance your home''s curb appeal with our expert exterior design services."}, {"title": "Full Home Interiors", "description": "Get a complete home makeover with our end-to-end interior design solutions."}]}',
 '{"services": {"type": "repeater", "label": "Services", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
);

-- Clients Page Sections
WITH clients_page AS (SELECT id FROM pages WHERE slug = 'clients')
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure)
VALUES
((SELECT id FROM clients_page), 'featured_testimonial', 'Featured Testimonial', 1, TRUE,
 '{"name": "Amit Patel", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/featured-client.jpg", "quote": "The best interior design firm I have ever worked with.", "location": "Pune, Maharashtra", "project": "Full Home Interior", "size": "3 BHK", "review": "From the initial consultation to the final handover, the team at Shriram Interio was exceptional. They understood our vision perfectly and delivered a home that exceeded our expectations. The quality of work and attention to detail is remarkable. I would highly recommend them to anyone looking for a seamless and beautiful home transformation."}',
 '{"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "quote": {"type": "textarea", "label": "Quote"}, "location": {"type": "text", "label": "Location"}, "project": {"type": "text", "label": "Project"}, "size": {"type": "text", "label": "Size"}, "review": {"type": "textarea", "label": "Review"}}'
),
((SELECT id FROM clients_page), 'video_testimonials', 'Video Testimonials', 2, TRUE,
 '{"title": "Client Video Stories", "subtitle": "Hear directly from our happy clients about their experience with Shriram Interio.", "videos": [{"name": "The Sharma Family", "location": "Koregaon Park, Pune", "review": "Our kitchen is now the heart of our home, all thanks to the amazing team!", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-thumb-1.jpg", "dataAiHint": "happy family"}, {"name": "Sunita & Raj", "location": "Hinjewadi, Pune", "review": "The wardrobe design is not only beautiful but also incredibly functional.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-thumb-2.jpg", "dataAiHint": "happy couple"}, {"name": "Anjali Deshpande", "location": "Wakad, Pune", "review": "They transformed my small apartment into a spacious and elegant home.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/video-thumb-3.jpg", "dataAiHint": "smiling woman"}]}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "videos": {"type": "repeater", "label": "Videos", "fields": {"name": {"type": "text", "label": "Name"}, "location": {"type": "text", "label": "Location"}, "review": {"type": "textarea", "label": "Review"}, "videoUrl": {"type": "text", "label": "Video URL"}, "imageSrc": {"type": "image", "label": "Thumbnail"}, "dataAiHint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM clients_page), 'text_testimonials', 'Text Testimonials', 3, TRUE,
 '{"title": "Kind Words From Our Clients", "subtitle": "We are proud to have touched so many lives with our designs.", "testimonials": [{"name": "Rohan Joshi", "review": "Their team is incredibly talented and professional. They delivered on time and exceeded our expectations.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg", "avatar": "RJ"}, {"name": "Sneha Reddy", "review": "I love my new modular kitchen! It''s both beautiful and functional. The entire process was smooth.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-4.jpg", "avatar": "SR"}, {"name": "Vikram Singh", "review": "A fantastic experience from start to finish. The designers really listen to your needs.", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-5.jpg", "avatar": "VS"}]}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "testimonials": {"type": "repeater", "label": "Testimonials", "fields": {"name": {"type": "text", "label": "Name"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"}, "avatar": {"type": "text", "label": "Avatar Fallback"}}}}'
);

-- Customer Stories Page Sections
WITH customer_stories_page AS (SELECT id FROM pages WHERE slug = 'customer-stories')
INSERT INTO sections (page_id, type, title, "order", visible, content, content_structure)
VALUES
((SELECT id FROM customer_stories_page), 'header', 'Header', 1, TRUE,
 '{"title": "Our Customer Stories", "subtitle": "Discover how we''ve transformed houses into dream homes, one space at a time."}',
 '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}}'
),
((SELECT id FROM customer_stories_page), 'featured_story', 'Featured Story', 2, TRUE,
 '{"buttonText": "Read Full Story"}',
 '{"buttonText": {"type": "text", "label": "Button Text"}}'
),
((SELECT id FROM customer_stories_page), 'more_stories', 'More Stories', 3, TRUE,
 '{"title": "More Inspiring Stories"}',
 '{"title": {"type": "text", "label": "Title"}}'
);

-- Sample Data
INSERT INTO sales_persons (name, contact_number, profile_image_url, slug) VALUES 
('Unassigned', '', 'https://placehold.co/100x100/CCCCCC/FFFFFF/png?text=User', 'unassigned'),
('John Doe', '123-456-7890', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg', 'john-doe'),
('Jane Smith', '098-765-4321', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg', 'jane-smith');

INSERT INTO leads (name, email, mobile, services, message, status, assigned_to_id) VALUES
('Anjali Sharma', 'anjali.sharma@example.com', '9876543210', '{"kitchen-unit", "wardrobe"}', 'Looking for a complete kitchen and wardrobe renovation for my 2BHK.', 'qualified', (SELECT id FROM sales_persons WHERE name = 'John Doe')),
('Rajesh Kumar', 'rajesh.kumar@example.com', '8765432109', '{"tv-unit", "sofa"}', 'Interested in a modern TV unit and a comfortable sofa for my living room.', 'in progress', (SELECT id FROM sales_persons WHERE name = 'Jane Smith')),
('Priya Patel', 'priya.patel@example.com', '7654321098', '{"full-home"}', 'We have just bought a new 3BHK and need full interior design services.', 'new', NULL);

INSERT INTO social_links (name, slug, url, icon) VALUES
('Facebook', 'facebook', 'https://facebook.com', 'Facebook'),
('Instagram', 'instagram', 'https://instagram.com', 'Instagram'),
('Twitter', 'twitter', 'https://twitter.com', 'Twitter'),
('Youtube', 'youtube', 'https://youtube.com', 'Youtube');

INSERT INTO products (name, slug, short_description, long_description, main_image, features, gallery, amazon_link) VALUES
('Modern L-Shaped Kitchen', 'modern-l-shaped-kitchen', 'A sleek and functional L-shaped kitchen perfect for contemporary homes.', 'This kitchen combines glossy finishes with smart storage solutions to create a space that is both beautiful and practical. The L-shape layout is efficient, providing ample counter space and easy movement between work zones. It features high-quality hardware, soft-close cabinets, and integrated LED lighting.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg', '{"High-gloss laminate finish", "Quartz countertop", "Soft-closing drawers", "Built-in appliance compatibility"}', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg"}', 'https://amazon.in'),
('Sliding Door Wardrobe', 'sliding-door-wardrobe', 'Maximize your bedroom space with this elegant sliding door wardrobe.', 'Our sliding door wardrobes are custom-built to fit your space perfectly. With a variety of finishes and internal configurations available, you can create a storage solution that meets your exact needs. The smooth sliding mechanism ensures easy access without requiring extra space for door swing.', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg', '{"Space-saving sliding doors", "Customizable internal layouts", "Variety of finishes", "Durable and smooth mechanism"}', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-3.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-4.jpg"}', '');

INSERT INTO portfolio (title, slug, content, main_image, gallery) VALUES
('Elegant Pune Residence', 'elegant-pune-residence', '<p>A complete home interior project in Pune, featuring a blend of modern and classic design elements. The project included a modular kitchen, living room, and two bedrooms.</p>', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-1.jpg', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-2.jpg", "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-3.jpg"}'),
('Minimalist Apartment Design', 'minimalist-apartment-design', '<p>This project focused on creating a clean, uncluttered living space for a young professional. The design uses a neutral color palette and smart storage solutions to maximize space.</p>', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-4.jpg', '{"https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/portfolio-5.jpg"}');

INSERT INTO stories (slug, title, image, "dataAiHint", category, excerpt, author, "authorAvatar", date, "clientImage", location, project, size, quote, content) VALUES
('modern-dream-home-pune', 'A Modern Dream Home in Pune', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1.jpg', 'modern home exterior', 'Residential', 'See how we transformed a standard 3BHK apartment into a stunning, modern living space for the Sharma family.', 'Priya Sharma', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg', '2023-10-15', 'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg', 'Kharadi, Pune', 'Full Home Interior', '3 BHK, 1400 sqft', 'Shriram Interio didn''t just design our house; they understood our lifestyle and created a home that is perfect for us.', '<h3>The Vision</h3><p>The Sharma family wanted a home that was modern, elegant, and child-friendly. They needed a space that was both beautiful for entertaining and practical for everyday living with two young children.</p><h3>The Transformation</h3><p>Our design team focused on an open-plan layout for the living and dining areas to create a sense of spaciousness. We used a neutral color palette with pops of color to add personality. For the kitchen, we designed a modular setup with durable, easy-to-clean surfaces. The children''s room was designed to be playful and functional, with plenty of storage for toys and books.</p><h3>The Result</h3><p>The final result is a home that is both stylish and comfortable, perfectly reflecting the Sharma family''s personality and lifestyle. They were thrilled with the outcome, and we were proud to have been a part of their journey.</p>');
