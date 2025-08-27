
-- Drop existing tables in reverse order of dependency to avoid foreign key constraints
DROP TABLE IF EXISTS public.sections;
DROP TABLE IF EXISTS public.stories;
DROP TABLE IF EXISTS public.pages;

-- Create the pages table
CREATE TABLE public.pages (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug text NOT NULL UNIQUE,
    title text NOT NULL,
    meta_title text,
    meta_description text
);

-- Create the sections table
CREATE TABLE public.sections (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    page_id bigint REFERENCES public.pages(id) ON DELETE CASCADE,
    title text NOT NULL,
    type text NOT NULL,
    "order" integer NOT NULL,
    content jsonb,
    content_structure jsonb,
    visible boolean DEFAULT true
);

-- Create the stories table
CREATE TABLE public.stories (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug text NOT NULL UNIQUE,
    title text,
    excerpt text,
    image text,
    "dataAiHint" text,
    category text,
    author text,
    "authorAvatar" text,
    date text,
    clientImage text,
    location text,
    project text,
    size text,
    quote text,
    content text,
    gallery jsonb
);

-- Seed data for pages
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('home', 'Home', 'Shriram Interio Digital | Pune''s Premier Interior Designers', 'Discover modular kitchens, wardrobes, and full home interiors from Pune''s leading design company. Quality craftsmanship and timely delivery.'),
('about', 'About Us', 'About Shriram Interio | Our Story and Values', 'Learn about Shriram Interio''s journey, our expert team, and our commitment to creating beautiful and functional living spaces.'),
('clients', 'Clients', 'Client Testimonials | Shriram Interio', 'Read reviews and watch testimonials from our happy clients across Pune.'),
('customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio Design Projects', 'Explore detailed stories and galleries from our completed interior design projects.'),
('products', 'Products', 'Our Interior Design Products | Kitchens, Wardrobes & More', 'Browse our wide range of products, including modular kitchens, custom wardrobes, and space-saving furniture.'),
('how-it-works', 'How It Works', 'Our Design Process | From Concept to Completion', 'Learn about our seamless 6-step interior design process, from initial consultation to final handover.'),
('services', 'Services', 'Our Interior Design Services | Shriram Interio', 'Discover our comprehensive interior design services, including full home interiors, modular kitchens, and exterior design.'),
('portfolio', 'Portfolio', 'Our Portfolio | Shriram Interio Design Gallery', 'View our portfolio of stunning interior design projects, from modern living areas to elegant kitchens.'),
('contact', 'Contact Us', 'Contact Shriram Interio | Get In Touch', 'Contact us for a free consultation. Find our address, phone number, and email.'),
('appointment', 'Appointment', 'Book an Appointment | Shriram Interio', 'Schedule a free consultation with our interior design experts today.'),
('get-a-quote', 'Get a Quote', 'Get a Free Quote | Shriram Interio', 'Fill out our form to get a free, no-obligation quote for your interior design project.');

-- Seed data for stories
INSERT INTO public.stories (slug, title, excerpt, image, "dataAiHint", category, author, "authorAvatar", date, clientImage, location, project, size, quote, content, gallery) VALUES
('modern-elegance-in-pune', 'Modern Elegance in Pune', 'A stunning transformation of a 2BHK flat into a modern, elegant living space.', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxtb2Rlcm4lMjBsaXZpbmclMjByb29tfGVufDB8fHx8fDE3NTYyOTEzNjh8MA&ixlib=rb-4.1.0&q=80&w=1080', 'modern living room', 'Living Room', 'The Mehta Family', '/avatar-1.png', '20 June 2024', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2MjkyMDM1fDA&ixlib=rb-4.1.0&q=80&w=1080', 'Koregaon Park, Pune', 'Mehta Residence', '2 BHK', 'Shriram Interio turned our house into a home. Their attention to detail and creative solutions were outstanding.', 'The Mehtas wanted a home that was both stylish and comfortable for their young family. We focused on creating an open, airy living space with multifunctional furniture and a neutral color palette accented with bold, artistic touches. The result is a home that is perfect for both relaxing and entertaining.', '[{"src": "/gallery-mehta-1.jpg", "alt": "Living room overview", "dataAiHint": "living room"}, {"src": "/gallery-mehta-2.jpg", "alt": "Dining area", "dataAiHint": "dining area"}, {"src": "/gallery_mehta-3.jpg", "alt": "Master bedroom", "dataAiHint": "master bedroom"}]'),
('urban-oasis-in-pune', 'An Urban Oasis of Calm in Pune', 'See how we transformed a standard 3BHK into a serene, minimalist haven for the Sharma family.', 'https://images.unsplash.com/photo-1596205252519-294473703534?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxtaW5pbWFsaXN0JTIwbGl2aW5nJTIwcm9vbXxlbnwwfHx8fDE3NTYyOTEzNjh8MA&ixlib=rb-4.1.0&q=80&w=1080', 'minimalist living room', 'Living Room', 'The Sharma Family', '/avatar-2.png', '15 May 2024', 'https://images.unsplash.com/photo-1542346764-8785640134a6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2MjkyMDM1fDA&ixlib=rb-4.1.0&q=80&w=1080', 'Baner, Pune', 'Sharma Residence', '3 BHK', 'The team at Shriram Interio understood our vision perfectly. They created a space that is not only beautiful but also incredibly functional.', 'For the Sharma family, creating a tranquil escape from the bustling city was paramount. Our design focused on clean lines, natural materials, and a clutter-free environment. We incorporated smart storage solutions and a calming color scheme to create a home that feels like a true urban oasis. The U-shaped kitchen became the heart of the home, designed for efficiency and family gatherings.', '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'),
('compact-and-clever-in-hinjewadi', 'Compact and Clever in Hinjewadi', 'This 1BHK apartment was a masterclass in space-saving design, tailored for a young professional.', 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxzbWFsbCUyMGFwYXJ0bWVudCUyMGludGVyaW9yfGVufDB8fHx8fDE3NTYyOTEzNjh8MA&ixlib=rb-4.1.0&q=80&w=1080', 'small apartment', 'Apartment', 'Mr. Verma', '/avatar-3.png', '02 April 2024', 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBtYW58ZW58MHx8fHwxNzU2MjkyMTQ3fDA&ixlib=rb-4.1.0&q=80&w=1080', 'Hinjewadi, Pune', 'Verma Apartment', '1 BHK', 'I never thought my small apartment could look this spacious and feel so luxurious. Every inch is used perfectly.', 'The challenge for Mr. Verma''s apartment was to maximize functionality without sacrificing style. We used a light color palette, mirrored surfaces, and multi-functional furniture to create an illusion of space. The wardrobe was designed with smart internal organizers, and the living area seamlessly doubles as a workspace.', '[{"src": "/gallery-verma-1.jpg", "alt": "Living and workspace", "dataAiHint": "compact living"}, {"src": "/gallery-verma-2.jpg", "alt": "Space-saving wardrobe", "dataAiHint": "sliding wardrobe"}, {"src": "/gallery-verma-3.jpg", "alt": "Modular kitchen", "dataAiHint": "small kitchen"}]')
ON CONFLICT(slug) DO UPDATE SET
title = EXCLUDED.title,
excerpt = EXCLUDED.excerpt,
image = EXCLUDED.image,
"dataAiHint" = EXCLUDED."dataAiHint",
category = EXCLUDED.category,
author = EXCLUDED.author,
"authorAvatar" = EXCLUDED."authorAvatar",
date = EXCLUDED.date,
clientImage = EXCLUDED.clientImage,
location = EXCLUDED.location,
project = EXCLUDED.project,
size = EXCLUDED.size,
quote = EXCLUDED.quote,
content = EXCLUDED.content,
gallery = EXCLUDED.gallery;


-- Seed data for sections
-- Note: Replace page_id with the actual id from the pages table if needed, though using a subquery is more robust.
-- For Home Page
INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Hero', 'hero', 1,
  '{"title": "Hero", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Experience quality craftsmanship and timely delivery with our expert team.", "buttonText": "Explore Our Designs", "videoUrl": "https://videos.pexels.com/video-files/8329388/8329388-hd_1920_1080_30fps.mp4", "slides": [{"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "videoUrl": {"type": "text", "label": "Background Video URL"}, "slides": {"type": "repeater", "label": "Image Slides"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Welcome', 'welcome', 2,
  '{"paragraph1": "Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Our journey began with a vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project.", "paragraph2": "We specialize in modular kitchens, wardrobes, and full home interiors, ensuring every corner of your home is both beautiful and functional. Over the years, we''ve evolved, but our commitment to excellence remains unwavering.", "image": "https://images.unsplash.com/photo-1558997519-83ea9252edf8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbnRlcmlvciUyMGRlc2lnbiUyMHN0dWRpb3xlbnwwfHx8fDE3NTYxOTI5MjJ8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "image": {"type": "image", "label": "Image"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'About Company', 'about_company', 3,
  '{"title": "About Company", "text": "A place where design meets inspiration and innovation. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."}',
  '{"title": {"type": "text", "label": "Title"}, "text": {"type": "textarea", "label": "Text"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Why Us', 'why_us', 4,
  '{"title": "Why Us", "subtitle": "Discover the difference that quality, expertise, and passion can make.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Work Gallery', 'work_gallery', 5,
  '{"title": "Work Gallery", "subtitle": "A glimpse into the spaces we''ve transformed.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Comfort Design', 'comfort_design', 6,
  '{"title": "Design at Your Comfort", "subtitle": "Our process is designed to be as convenient and transparent as possible, bringing your dream home to life without the hassle.", "items": [{"title": "Live 3D Designs", "description": "Experience your new home with our live 3D designing sessions. Visualize your space and make changes in real-time."}, {"title": "Contactless Experience", "description": "From design to delivery, we offer a safe and seamless contactless experience for your convenience."}, {"title": "Instant Pricing", "description": "Get transparent and instant pricing for your project with no hidden costs."}, {"title": "Expertise & Passion", "description": "Our team of passionate designers brings a wealth of expertise to every project, ensuring exceptional results."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'What We Do', 'what_we_do', 7,
  '{"title": "What We Do", "subtitle": "From trendy designs to best-selling classics, explore our curated collections.", "trendingItems": [{"name": "Parallel Kitchen", "image": "/trending1.jpg", "hint": "parallel kitchen"}, {"name": "U-Shaped Modular Kitchen", "image": "/trending2.jpg", "hint": "u-shaped kitchen"}, {"name": "L-Shaped Modular Kitchen", "image": "/trending3.jpg", "hint": "l-shaped kitchen"}, {"name": "Sliding Wardrobe", "image": "/trending4.jpg", "hint": "sliding wardrobe"}, {"name": "Hinged Wardrobe", "image": "/trending5.jpg", "hint": "hinged wardrobe"}], "bestSellingKitchens": [{"name": "Classic L-Shape", "image": "/kitchen1.jpg", "hint": "classic l-shaped kitchen"}, {"name": "Modern U-Shape", "image": "/kitchen2.jpg", "hint": "modern u-shaped kitchen"}, {"name": "Island Kitchen", "image": "/kitchn1.jpg", "hint": "island kitchen"}, {"name": "Minimalist Galley", "image": "/kitchengallery.jpg", "hint": "minimalist galley kitchen"}], "bestSellingWardrobes": [{"name": "Sliding Door", "image": "/SlidingWardrobe.jpg", "hint": "sliding wardrobe"}, {"name": "Walk-in Wonder", "image": "/r1.jpg", "hint": "walk-in wardrobe"}, {"name": "Hinged Classic", "image": "/b1.jpg", "hint": "hinged wardrobe"}, {"name": "Mirrored Finish", "image": "/b2.jpg", "hint": "mirrored wardrobe"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "trendingItems": {"type": "repeater", "label": "Trending Items"}, "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens"}, "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Testimonials', 'testimonials', 8,
  '{"title": "Testimonials", "subtitle": "Hear from our happy clients across Pune.", "buttonText": "View All Testimonials", "items": [{"name": "Anjali P.", "review": "Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish.", "image": "/avatar-1.png"}, {"name": "Rohan & Priya S.", "review": "The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations.", "image": "/avatar-2.png"}, {"name": "Meera K.", "review": "Excellent service and stunning wardrobe design. The quality of materials is top-notch, and the installation was seamless.", "image": "/avatar-3.png"}, {"name": "Sameer Joshi", "review": "We opted for the full home interior service and it was the best decision. The final result is a cohesive, beautiful home.", "image": "/avatar-4.png"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'FAQ', 'faq', 9,
  '{"title": "FAQ", "subtitle": "Have questions? We have answers.", "items": [{"question": "What services do you offer?", "answer": "We offer a comprehensive range of interior design services, including modular kitchens, custom wardrobes, full home interiors, living area design, bedroom design, and more. We handle everything from design conception to final installation."}, {"question": "What is your design process?", "answer": "Our process begins with a free consultation to understand your needs. We then move to 3D design and visualization, material selection, manufacturing, and finally, professional installation and handover. We keep you involved at every step."}, {"question": "How much does interior design cost?", "answer": "The cost varies greatly depending on the scope of the project, materials chosen, and the size of the space. We provide transparent pricing and detailed quotes after the initial consultation. We offer solutions for various budget ranges."}, {"question": "How long does a project typically take?", "answer": "A typical project timeline can range from a few weeks for a single room to a few months for a full home interior. After understanding your requirements, we provide a detailed project timeline."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'home';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Partners', 'partners', 10,
  '{"title": "Partners", "subtitle": "MEET OUR PARTNERS", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'home';


-- For About Page
INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Hero', 'hero', 1,
  '{"title": "About Shriram Interio", "subtitle": "Crafting Stories, Designing Dreams", "backgroundImage": "https://images.unsplash.com/photo-1556742533-c5b51a44136a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbiUyMG9mZmljZXxlbnwwfHx8fDE3NTYyODY0OTB8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'
FROM public.pages WHERE slug = 'about';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Our Story', 'story', 2,
  '{"heading": "Our Story", "subheading": "FROM A PASSIONATE VISION TO A DESIGN POWERHOUSE", "paragraph1": "SHRIRAM INTERIO began in 2016 with a simple yet powerful idea: that a well-designed space can truly enhance the quality of life. Our founders, a team of passionate designers and skilled craftsmen, saw a need for a client-focused interior design firm in Pune that valued both aesthetics and functionality in equal measure.", "paragraph2": "We started small, with a handful of residential projects, pouring our hearts into every detail. Our commitment to quality, transparency, and personalized service quickly earned us a reputation for excellence. Word-of-mouth referrals became our biggest strength, as happy clients shared their stories of transformation.", "paragraph3": "From those humble beginnings, we have grown into a full-service design studio, expanding our expertise from modular kitchens and wardrobes to comprehensive, end-to-end home interior solutions.", "paragraph4": "Today, SHRIRAM INTERIO stands as a testament to the power of good design. While our team and portfolio have grown, our core values remain the same: to listen, to create, and to deliver spaces that our clients are proud to call home.", "image": "https://images.unsplash.com/photo-1572021335469-31706a17aaef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYyODY2NTd8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"heading": {"type": "text", "label": "Heading"}, "subheading": {"type": "text", "label": "Subheading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
FROM public.pages WHERE slug = 'about';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Our Journey', 'journey', 3,
  '{"heading": "Our Journey", "paragraph1": "Our journey has been one of continuous learning and growth. We''ve navigated the evolving trends of interior design, always staying true to our principle of creating timeless, not just trendy, spaces. We have embraced new technologies, like our live 3D design sessions, to make the design process more accessible and transparent for our clients.", "paragraph2": "We''ve forged strong partnerships with the best material suppliers and brands in the industry, ensuring that every component of our designs meets the highest standards of quality and durability. Our manufacturing facility is equipped with state-of-the-art machinery, allowing us to execute our designs with precision.", "paragraph3": "But our journey is more than just about business growth; it''s about the relationships we''ve built. It’s about the joy we see on our clients'' faces when they walk into their newly designed homes for the first time.", "paragraph4": "As we look to the future, we are excited to continue pushing the boundaries of design, exploring new materials, and creating even more beautiful and functional spaces for our clients in Pune and beyond.", "image": "https://images.unsplash.com/photo-1517048676732-d65bc937f952?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYyODY2NTd8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
  '{"heading": {"type": "text", "label": "Heading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
FROM public.pages WHERE slug = 'about';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Our Values', 'values', 4,
  '{"title": "Our Values", "subtitle": "The principles that guide our work.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'about';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Mission and Vision', 'mission_vision', 5,
  '{"missionTitle": "Our Mission", "missionText": "To create beautiful, functional, and personalized interior spaces that enhance the lives of our clients, delivered with a commitment to quality, transparency, and exceptional service.", "visionTitle": "Our Vision", "visionText": "To be Pune''s most trusted and sought-after interior design firm, known for our innovative designs, craftsmanship, and unwavering dedication to client satisfaction."}',
  '{"missionTitle": {"type": "text", "label": "Mission Title"}, "missionText": {"type": "textarea", "label": "Mission Text"}, "visionTitle": {"type": "text", "label": "Vision Title"}, "visionText": {"type": "textarea", "label": "Vision Text"}}'
FROM public.pages WHERE slug = 'about';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Meet the Team', 'team', 6,
  '{"title": "Meet the Team", "subtitle": "The creative minds behind your beautiful home.", "members": [{"name": "Mr. Shriram", "role": "Founder & Lead Designer", "bio": "With over a decade of experience, Mr. Shriram is the visionary force behind the company, passionate about creating unique and functional spaces.", "image": "https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbmRpYW4lMjBtYW58ZW58MHx8fHwxNzU2MjkyMTQ3fDA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Priya Deshpande", "role": "Head of Design", "bio": "Priya brings a wealth of creativity and a keen eye for detail to every project, ensuring each design is both beautiful and practical.", "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjB3b21hbnxlbnwwfHx8fDE3NTYyOTIyMTh8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Rajesh Kumar", "role": "Project Manager", "bio": "Rajesh ensures that every project runs smoothly from start to finish, coordinating with teams to deliver on time and to the highest standard.", "image": "https://images.unsplash.com/photo-1615109398623-88346a601842?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBtYW4lMjBzbWlsaW5nfGVufDB8fHx8fDE3NTYyOTIyNTZ8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "members": {"type": "repeater", "label": "Team Members"}}'
FROM public.pages WHERE slug = 'about';

-- For Customer Stories page
INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Header', 'header', 1,
  '{"title": "Customer Stories", "subtitle": "Discover the real-life stories behind our designs. See how we''ve collaborated with clients to turn their houses into homes they love."}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}}'
FROM public.pages WHERE slug = 'customer-stories';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Featured Story', 'featured_story', 2,
  '{"buttonText": "Read Their Story"}',
  '{"buttonText": {"type": "text", "label": "Button Text"}}'
FROM public.pages WHERE slug = 'customer-stories';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'More Stories', 'more_stories', 3,
  '{"title": "More Client Stories", "stories": [{"slug": "modern-elegance-in-pune", "image": "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxtb2Rlcm4lMjBsaXZpbmclMjByb29tfGVufDB8fHx8fDE3NTYyOTEzNjh8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "modern living room", "category": "Living Room", "title": "Modern Elegance in Pune", "excerpt": "A stunning transformation of a 2BHK flat into a modern, elegant living space.", "author": "The Mehta Family", "authorAvatar": "/avatar-1.png", "date": "20 June 2024"}, {"slug": "urban-oasis-in-pune", "image": "https://images.unsplash.com/photo-1596205252519-294473703534?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxtaW5pbWFsaXN0JTIwbGl2aW5nJTIwcm9vbXxlbnwwfHx8fDE3NTYyOTEzNjh8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "minimalist living room", "category": "Living Room", "title": "An Urban Oasis of Calm in Pune", "excerpt": "See how we transformed a standard 3BHK into a serene, minimalist haven for the Sharma family.", "author": "The Sharma Family", "authorAvatar": "/avatar-2.png", "date": "15 May 2024"}, {"slug": "compact-and-clever-in-hinjewadi", "image": "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxzbWFsbCUyMGFwYXJ0bWVudCUyMGludGVyaW9yfGVufDB8fHx8fDE3NTYyOTEzNjh8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "small apartment", "category": "Apartment", "title": "Compact and Clever in Hinjewadi", "excerpt": "This 1BHK apartment was a masterclass in space-saving design, tailored for a young professional.", "author": "Mr. Verma", "authorAvatar": "/avatar-3.png", "date": "02 April 2024"}]}',
  '{"title": {"type": "text", "label": "Title"}, "stories": {"type": "repeater", "label": "Stories"}}'
FROM public.pages WHERE slug = 'customer-stories';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Work Gallery', 'work_gallery', 4,
  '{"title": "Work Gallery", "subtitle": "A glimpse into the spaces we''ve transformed.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'customer-stories';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'Partners', 'partners', 5,
  '{"title": "Partners", "subtitle": "TRUSTED BY THE BEST", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'customer-stories';

INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT id, 'FAQ', 'faq', 6,
  '{"title": "Frequently Asked Questions", "subtitle": "Your questions, answered.", "items": [{"question": "Can I see past projects you have completed?", "answer": "Absolutely! Our portfolio and customer stories sections showcase a wide variety of our completed projects. We believe our work speaks for itself."}, {"question": "How do you ensure the quality of materials?", "answer": "We have strong partnerships with leading brands and suppliers in the industry. All materials undergo a rigorous quality check to ensure they meet our high standards for durability and aesthetics."}, {"question": "What if I have my own design ideas?", "answer": "We love collaborating with our clients! Your ideas are the foundation of the design process. Our experts will work with you to refine your concepts and bring them to life in the most effective way."}, {"question": "Do you provide a warranty?", "answer": "Yes, we provide a one-year warranty on our workmanship and the materials used. Your peace of mind is our priority."}]}',
  '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items"}}'
FROM public.pages WHERE slug = 'customer-stories';


-- Add ON CONFLICT for sections to avoid duplicate entries on re-run
INSERT INTO public.sections (page_id, title, type, "order", content, content_structure)
SELECT p.id, s.title, s.type, s.order_val, s.content::jsonb, s.content_structure::jsonb
FROM (
  SELECT 'home' as slug, 'Hero' as title, 'hero' as type, 1 as order_val, '{"title": "Hero", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Experience quality craftsmanship and timely delivery with our expert team.", "buttonText": "Explore Our Designs", "videoUrl": "https://videos.pexels.com/video-files/8329388/8329388-hd_1920_1080_30fps.mp4", "slides": [{"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}' as content, '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "videoUrl": {"type": "text", "label": "Background Video URL"}, "slides": {"type": "repeater", "label": "Image Slides"}}' as content_structure
  -- You can add more UNION ALL statements for other sections here if needed
) AS s
JOIN public.pages p ON p.slug = s.slug
ON CONFLICT (page_id, type) DO UPDATE SET
  title = EXCLUDED.title,
  "order" = EXCLUDED."order",
  content = EXCLUDED.content,
  content_structure = EXCLUDED.content_structure;


-- Set ownership and permissions
-- This is a placeholder; adjust roles and permissions as needed for your setup.
ALTER TABLE public.pages OWNER TO postgres;
ALTER TABLE public.sections OWNER TO postgres;
ALTER TABLE public.stories OWNER TO postgres;

-- Assuming a role `anon` and `authenticated` exists from Supabase defaults.
-- Allow public read access to all tables.
GRANT SELECT ON TABLE public.pages TO anon, authenticated;
GRANT SELECT ON TABLE public.sections TO anon, authenticated;
GRANT SELECT ON TABLE public.stories TO anon, authenticated;

-- Allow logged-in users to perform all actions.
-- This is a permissive setup for the admin panel to work.
-- For production, you would want more restrictive policies.
GRANT INSERT, UPDATE, DELETE ON TABLE public.pages TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.sections TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.stories TO authenticated;

-- Enable Row Level Security
ALTER TABLE public.pages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stories ENABLE ROW LEVEL SECURITY;

-- Create policies for public access (SELECT)
CREATE POLICY "Enable read access for all users" ON public.pages FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON public.sections FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON public.stories FOR SELECT USING (true);

-- Create policies for authenticated users (admin actions)
-- In a real app, you might check for a specific role, e.g., auth.uid() = 'your-admin-user-id'
CREATE POLICY "Enable insert for authenticated users" ON public.pages FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Enable update for authenticated users" ON public.pages FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Enable delete for authenticated users" ON public.pages FOR DELETE TO authenticated USING (true);

CREATE POLICY "Enable insert for authenticated users" ON public.sections FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Enable update for authenticated users" ON public.sections FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Enable delete for authenticated users" ON public.sections FOR DELETE TO authenticated USING (true);

CREATE POLICY "Enable insert for authenticated users" ON public.stories FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Enable update for authenticated users" ON public.stories FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Enable delete for authenticated users" ON public.stories FOR DELETE TO authenticated USING (true);

-- Grant usage on sequence to allow authenticated users to insert
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO authenticated;
