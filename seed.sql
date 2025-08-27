
-- Drop existing tables in reverse order of dependency to avoid foreign key constraints errors
DROP TABLE IF EXISTS public.sections;
DROP TABLE IF EXISTS public.stories;
DROP TABLE IF EXISTS public.pages;

-- Create the pages table to store information about each page
CREATE TABLE public.pages (
    id SERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    meta_title TEXT,
    meta_description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the stories table for customer stories
CREATE TABLE public.stories (
    id SERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    category TEXT,
    excerpt TEXT,
    image TEXT,
    "dataAiHint" TEXT,
    author TEXT,
    "authorAvatar" TEXT,
    date TEXT,
    "clientImage" TEXT,
    location TEXT,
    project TEXT,
    size TEXT,
    quote TEXT,
    content TEXT,
    gallery JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the sections table to store content sections for each page
CREATE TABLE public.sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER NOT NULL REFERENCES public.pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    visible BOOLEAN DEFAULT true,
    content JSONB,
    content_structure JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);


-- SEED DATA --

-- Home Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('home', 'Home', 'Shriram Interio Digital', 'Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- About Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('about', 'About Us', 'About Shriram Interio | Pune', 'Learn about our story, mission, and the team that makes us Pune''s leading interior design company.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- Clients Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('clients', 'Clients', 'Our Clients | Shriram Interio', 'See testimonials and case studies from our happy interior design clients in Pune.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- Customer Stories Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio', 'Read inspiring stories from our customers and see how we transformed their homes.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- Seed Sections for Home Page
WITH page AS (SELECT id FROM public.pages WHERE slug = 'home')
INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure) VALUES
((SELECT id FROM page), 'hero', 'Hero Section', 1, true, 
  '{"title": "Hero", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Experience quality craftsmanship and timely delivery with our expert team.", "buttonText": "Explore Our Designs", "videoUrl": "https://videos.pexels.com/video-files/8329388/8329388-hd_1920_1080_30fps.mp4", "slides": [{"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "videoUrl": {"type": "text", "label": "Background Video URL"}, "slides": {"type": "repeater", "label": "Image Slides"}}'
),
((SELECT id FROM page), 'welcome', 'Welcome Section', 2, true, 
  '{"title": "Welcome to Shriram Interio", "paragraph1": "Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Our journey began with a vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project.", "paragraph2": "We specialize in modular kitchens, wardrobes, and full home interiors, ensuring every corner of your home is both beautiful and functional. Over the years, we''ve evolved, but our commitment to excellence remains unwavering.", "image": "https://images.unsplash.com/photo-1558997519-83ea9252edf8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbnRlcmlvciUyMGRlc2lnbiUyMHN0dWRpb3xlbnwwfHx8fDE3NTYxOTI5MjJ8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"title": {"type": "text", "label": "Title"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "image": {"type": "image", "label": "Image URL"}}'
),
((SELECT id FROM page), 'about_company', 'About Company Section', 3, true,
  '{"title": "About Company", "text": "A place where design meets inspiration and innovation. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."}',
  '{"title": {"type": "text", "label": "Title"}, "text": {"type": "textarea", "label": "Text"}}'
),
((SELECT id FROM page), 'why_us', 'Why Us Section', 4, true,
  '{"title": "Why Us", "subtitle": "Discover the difference that quality, expertise, and passion can make.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
),
((SELECT id FROM page), 'work_gallery', 'Work Gallery Section', 5, true,
  '{"title": "Work Gallery", "subtitle": "A glimpse into the spaces we''ve transformed.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Gallery Items"}}'
),
((SELECT id FROM page), 'comfort_design', 'Comfort Design Section', 6, true,
  '{"title": "Design at Your Comfort", "subtitle": "Our process is designed to be as convenient and transparent as possible, bringing your dream home to life without the hassle.", "items": [{"title": "Live 3D Designs", "description": "Experience your new home with our live 3D designing sessions. Visualize your space and make changes in real-time."}, {"title": "Contactless Experience", "description": "From design to delivery, we offer a safe and seamless contactless experience for your convenience."}, {"title": "Instant Pricing", "description": "Get transparent and instant pricing for your project with no hidden costs."}, {"title": "Expertise & Passion", "description": "Our team of passionate designers brings a wealth of expertise to every project, ensuring exceptional results."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
),
((SELECT id FROM page), 'what_we_do', 'What We Do Section', 7, true,
  '{"title": "What We Do", "subtitle": "From trendy designs to best-selling classics, explore our curated collections.", "trendingItems": [{"name": "Parallel Kitchen", "image": "/trending1.jpg", "hint": "parallel kitchen"}, {"name": "U-Shaped Modular Kitchen", "image": "/trending2.jpg", "hint": "u-shaped kitchen"}, {"name": "L-Shaped Modular Kitchen", "image": "/trending3.jpg", "hint": "l-shaped kitchen"}, {"name": "Sliding Wardrobe", "image": "/trending4.jpg", "hint": "sliding wardrobe"}, {"name": "Hinged Wardrobe", "image": "/trending5.jpg", "hint": "hinged wardrobe"}], "bestSellingKitchens": [{"name": "Classic L-Shape", "image": "/kitchen1.jpg", "hint": "classic l-shaped kitchen"}, {"name": "Modern U-Shape", "image": "/kitchen2.jpg", "hint": "modern u-shaped kitchen"}, {"name": "Island Kitchen", "image": "/kitchn1.jpg", "hint": "island kitchen"}, {"name": "Minimalist Galley", "image": "/kitchengallery.jpg", "hint": "minimalist galley kitchen"}], "bestSellingWardrobes": [{"name": "Sliding Door", "image": "/SlidingWardrobe.jpg", "hint": "sliding wardrobe"}, {"name": "Walk-in Wonder", "image": "/r1.jpg", "hint": "walk-in wardrobe"}, {"name": "Hinged Classic", "image": "/b1.jpg", "hint": "hinged wardrobe"}, {"name": "Mirrored Finish", "image": "/b2.jpg", "hint": "mirrored wardrobe"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "trendingItems": {"type": "repeater", "label": "Trending Items"}, "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens"}, "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes"}}'
),
((SELECT id FROM page), 'testimonials', 'Testimonials Section', 8, true,
  '{"title": "Testimonials", "subtitle": "Hear from our happy clients across Pune.", "buttonText": "View All Testimonials", "items": [{"name": "Anjali P.", "review": "Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish.", "image": "/avatar-1.png"}, {"name": "Rohan & Priya S.", "review": "The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations.", "image": "/avatar-2.png"}, {"name": "Meera K.", "review": "Excellent service and stunning wardrobe design. The quality of materials is top-notch, and the installation was seamless.", "image": "/avatar-3.png"}, {"name": "Sameer Joshi", "review": "We opted for the full home interior service and it was the best decision. The final result is a cohesive, beautiful home.", "image": "/avatar-4.png"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "items": {"type": "repeater", "label": "Testimonials"}}'
),
((SELECT id FROM page), 'faq', 'FAQ Section', 9, true,
  '{"title": "FAQ", "subtitle": "Have questions? We have answers.", "items": [{"question": "What services do you offer?", "answer": "We offer a comprehensive range of interior design services, including modular kitchens, custom wardrobes, full home interiors, living area design, bedroom design, and more. We handle everything from design conception to final installation."}, {"question": "What is your design process?", "answer": "Our process begins with a free consultation to understand your needs. We then move to 3D design and visualization, material selection, manufacturing, and finally, professional installation and handover. We keep you involved at every step."}, {"question": "How much does interior design cost?", "answer": "The cost varies greatly depending on the scope of the project, materials chosen, and the size of the space. We provide transparent pricing and detailed quotes after the initial consultation. We offer solutions for various budget ranges."}, {"question": "How long does a project typically take?", "answer": "A typical project timeline can range from a few weeks for a single room to a few months for a full home interior. After understanding your requirements, we provide a detailed project timeline."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "FAQ Items"}}'
),
((SELECT id FROM page), 'partners', 'Partners Section', 10, true,
  '{"title": "Partners", "subtitle": "MEET OUR PARTNERS", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Partners"}}'
)
ON CONFLICT (page_id, type) DO UPDATE SET
title = EXCLUDED.title,
"order" = EXCLUDED.order,
visible = EXCLUDED.visible,
content = EXCLUDED.content,
content_structure = EXCLUDED.content_structure;


-- Seed Sections for About Page
WITH page AS (SELECT id FROM public.pages WHERE slug = 'about')
INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure) VALUES
((SELECT id FROM page), 'hero', 'Hero Section', 1, true,
  '{"title": "About Shriram Interio", "subtitle": "Crafting dreams into reality since 2016.", "backgroundImage": "https://images.unsplash.com/photo-1549490103-50e5d1a8b935?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxhYnN0cmFjdCUyMGJsdWV8ZW58MHx8fHwxNzU2MTk0Mzk4fDA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'
),
((SELECT id FROM page), 'story', 'Our Story', 2, true,
  '{"heading": "Our Story", "subheading": "From a small workshop to Pune''s leading interior design studio.", "paragraph1": "SHRIRAM INTERIO began in 2016 with a simple yet powerful idea: to make high-quality, beautiful interior design accessible to everyone. What started as a small workshop has grown into a leading design studio in Pune, known for our commitment to quality, innovation, and customer satisfaction.", "paragraph2": "Our founders, driven by a passion for design and craftsmanship, laid the foundation of a company that prioritizes customer dreams. We believe that a home is more than just a place; it''s a reflection of one''s personality and a sanctuary for the soul.", "paragraph3": "We''ve built our reputation on the pillars of transparency, reliability, and a relentless pursuit of perfection. Every project is a journey we embark upon with our clients, ensuring their vision is at the heart of everything we do.", "paragraph4": "Today, we are proud to have transformed hundreds of houses into homes, creating spaces that are not only aesthetically pleasing but also deeply personal and functional. Our story is one of growth, passion, and the joy of creating beautiful spaces.", "image": "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvcnN8ZW58MHx8fHwxNzU1NjI0NTg5fDA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"heading": {"type": "text", "label": "Heading"}, "subheading": {"type": "text", "label": "Subheading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image URL"}}'
),
((SELECT id FROM page), 'journey', 'Our Journey', 3, true,
  '{"heading": "Our Journey", "paragraph1": "The journey of Shriram Interio has been one of constant evolution and learning. From our first modular kitchen project to executing full home interiors for large residential complexes, we have embraced every challenge as an opportunity to grow and innovate.", "paragraph2": "We invested in state-of-the-art technology and a skilled team of designers and craftsmen to ensure that our products meet the highest standards of quality. Our factory is equipped with modern machinery that allows for precision and perfection in every piece we create.", "paragraph3": "Our design process has also evolved to be more customer-centric. We introduced 3D visualization and virtual reality tools to help clients experience their future homes before the work even begins. This collaborative approach ensures that the final outcome is perfectly aligned with their expectations.", "paragraph4": "We have forged strong partnerships with leading brands for materials and hardware, ensuring durability and a premium finish in all our projects. Our journey is a testament to our commitment to quality and our dedication to bringing the best of interior design to our clients.", "image": "https://images.unsplash.com/photo-1581578731548-c64695cc6952?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxMHx8ZGVzaWduJTIwdGVhbXxlbnwwfHx8fDE3NTYxOTQ1NDV8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"heading": {"type": "text", "label": "Heading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image URL"}}'
),
((SELECT id FROM page), 'values', 'Our Values', 4, true,
  '{"title": "Our Values", "subtitle": "The principles that guide our work.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Value Items"}}'
),
((SELECT id FROM page), 'mission_vision', 'Mission and Vision', 5, true,
  '{"visionTitle": "Our Vision", "visionText": "To be the most trusted and innovative interior design company in Pune, known for our quality, creativity, and customer-centric approach.", "missionTitle": "Our Mission", "missionText": "To create beautiful, functional, and personalized living spaces that enhance the quality of life for our clients."}',
  '{"visionTitle": {"type": "text", "label": "Vision Title"}, "visionText": {"type": "textarea", "label": "Vision Text"}, "missionTitle": {"type": "text", "label": "Mission Title"}, "missionText": {"type": "textarea", "label": "Mission Text"}}'
),
((SELECT id FROM page), 'team', 'Meet the Team', 6, true,
  '{"title": "Meet the Team", "subtitle": "The creative minds behind your beautiful homes.", "members": [{"name": "Shriram P.", "role": "Founder & CEO", "bio": "With a passion for design and an eye for detail, Shriram leads the team with a vision to create exceptional living spaces.", "image": "https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFuJTIwaW5kaWFufGVufDB8fHx8MTc1NjA0NjY0OHww&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Anita K.", "role": "Lead Designer", "bio": "Anita brings a wealth of experience and creativity to every project, ensuring each design is unique and functional.", "image": "https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Rajesh S.", "role": "Project Manager", "bio": "Rajesh ensures that every project is executed flawlessly, from start to finish, with a focus on quality and timeliness.", "image": "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBwZXJzb258ZW58MHx8fHwxNzU2MTk0ODk1fDA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "members": {"type": "repeater", "label": "Team Members"}}'
)
ON CONFLICT (page_id, type) DO UPDATE SET
title = EXCLUDED.title,
"order" = EXCLUDED.order,
visible = EXCLUDED.visible,
content = EXCLUDED.content,
content_structure = EXCLUDED.content_structure;


-- Seed Customer Stories
INSERT INTO public.stories (slug, title, category, excerpt, image, "dataAiHint", author, "authorAvatar", date, "clientImage", location, project, size, quote, content, gallery) VALUES
('a-dream-home-in-baner', 'A Dream Home in Baner', 'Full Home Interior', 'See how we transformed a 3 BHK apartment in Baner into a modern, functional, and beautiful living space for the Sharma family.', 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080', 'modern living room', 'The Sharma Family', '/avatars/sharma.png', 'June 15, 2024', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwY291cGxlfGVufDB8fHx8MTc1NjE5NTI5OHww&ixlib=rb-4.1.0&q=80&w=1080', 'Baner, Pune', 'Blue Ridge', '3 BHK', 'Shriram Interio understood our vision perfectly and delivered a home that exceeded our expectations. The attention to detail is just amazing!', 'The Sharma family wanted a home that was both modern and warm, with plenty of space for their two children to play. Our design team worked closely with them to create a custom layout that maximized space and light. The living room features a comfortable L-shaped sofa and a custom-built entertainment unit. The kitchen is a modular marvel, with sleek cabinets and smart storage solutions. The master bedroom is a serene retreat, with a king-sized bed and a spacious wardrobe. The children''s room is a fun and vibrant space, with a bunk bed and a study area.', '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'),
('modular-kitchen-makeover', 'Modular Kitchen Makeover', 'Kitchen', 'A complete transformation of a dated kitchen into a stylish and functional modular kitchen for the Mehta family in Kothrud.', 'https://images.unsplash.com/photo-1556911220-e15b29be8c9f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080', 'modular kitchen', 'The Mehta Family', '/avatars/mehta.png', 'May 28, 2024', 'https://images.unsplash.com/photo-1604909062392-7478e4a9e59d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxzbWlsaW5nJTIwY291cGxlfGVufDB8fHx8MTc1NjE5NTI5OHww&ixlib=rb-4.1.0&q=80&w=1080', 'Kothrud, Pune', 'Independent House', 'N/A', 'Our kitchen is now the heart of our home. The team at Shriram Interio was professional, and the quality of work is outstanding.', 'The Mehtas wanted to upgrade their old kitchen to a modern, easy-to-maintain space. We designed a U-shaped modular kitchen with high-gloss laminate finishes and a quartz countertop. The new layout provides ample storage and counter space, making cooking a pleasure. We also incorporated smart features like a pull-out pantry and soft-closing drawers.', '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'),
('wardrobe-wonder-in-hinjewadi', 'Wardrobe Wonder in Hinjewadi', 'Wardrobe', 'Creating a spacious and elegant walk-in wardrobe for a tech professional in Hinjewadi, maximizing storage and style.', 'https://images.unsplash.com/photo-1616047006789-b7af5afb8c20?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx3YXJkcm9iZXxlbnwwfHx8fDE3NTU3MTUzOTF8MA&ixlib=rb-4.1.0&q=80&w=1080', 'walk-in wardrobe', 'Mr. Desai', '/avatars/desai.png', 'April 12, 2024', 'https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFufGVufDB8fHx8MTc1NjA0NjYwNXww&ixlib=rb-4.1.0&q=80&w=1080', 'Hinjewadi, Pune', 'Life Republic', '2 BHK', 'I never thought my small bedroom could have such a spacious wardrobe. The design is brilliant and the quality is top-notch.', 'Mr. Desai needed a storage solution for his extensive collection of clothes and accessories. Our team designed a walk-in wardrobe with a mix of open shelves, drawers, and hanging space. We used a light wood laminate finish to make the space feel bright and airy. The wardrobe also features integrated LED lighting for better visibility.', '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
category = EXCLUDED.category,
excerpt = EXCLUDED.excerpt,
image = EXCLUDED.image,
"dataAiHint" = EXCLUDED."dataAiHint",
author = EXCLUDED.author,
"authorAvatar" = EXCLUDED."authorAvatar",
date = EXCLUDED.date,
"clientImage" = EXCLUDED."clientImage",
location = EXCLUDED.location,
project = EXCLUDED.project,
size = EXCLUDED.size,
quote = EXCLUDED.quote,
content = EXCLUDED.content,
gallery = EXCLUDED.gallery;

-- Seed Sections for Customer Stories Page
WITH page AS (SELECT id FROM public.pages WHERE slug = 'customer-stories')
INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure) VALUES
((SELECT id FROM page), 'header', 'Header', 1, true,
  '{"title": "Our Customer Stories", "subtitle": "Discover how we''ve transformed houses into dream homes, one happy client at a time."}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}}'
),
((SELECT id FROM page), 'featured_story', 'Featured Story', 2, true,
  '{"buttonText": "Read Full Story"}',
  '{"buttonText": {"type": "text", "label": "Button Text"}}'
),
((SELECT id FROM page), 'more_stories', 'More Stories', 3, true,
  '{"title": "More Client Stories", "stories": []}',
  '{"title": {"type": "text", "label": "Title"}, "stories": {"type": "repeater", "label": "Stories"}}'
),
((SELECT id FROM page), 'work_gallery', 'Work Gallery', 4, true,
  '{"title": "Our Work in Pictures", "subtitle": "A gallery of our finest creations, showcasing our commitment to quality and design.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Gallery Items"}}'
),
((SELECT id FROM page), 'partners', 'Partners', 5, true,
  '{"title": "Our Trusted Partners", "subtitle": "QUALITY & TRUST", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Partner Items"}}'
),
((SELECT id FROM page), 'faq', 'FAQ', 6, true,
  '{"title": "Frequently Asked Questions", "subtitle": "Find answers to common questions about our process and services.", "items": [{"question": "How do you ensure the quality of materials?", "answer": "We partner with leading brands and trusted suppliers to source high-quality materials. We also have a rigorous quality control process at every stage of manufacturing and installation."}, {"question": "Can I see the designs before they are finalized?", "answer": "Absolutely! We provide detailed 2D and 3D designs, and even offer live 3D sessions to help you visualize your space and make any changes before we start production."}, {"question": "Do you provide a warranty?", "answer": "Yes, we provide a one-year warranty on our work to ensure your complete satisfaction and peace of mind."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "FAQ Items"}}'
)
ON CONFLICT (page_id, type) DO UPDATE SET
title = EXCLUDED.title,
"order" = EXCLUDED.order,
visible = EXCLUDED.visible,
content = EXCLUDED.content,
content_structure = EXCLUDED.content_structure;
