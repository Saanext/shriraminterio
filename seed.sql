
-- Drop existing tables to start fresh
DROP TABLE IF EXISTS public.sections;
DROP TABLE IF EXISTS public.stories;
DROP TABLE IF EXISTS public.pages;

-- Create the pages table
CREATE TABLE public.pages (
    id SERIAL PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    meta_title TEXT,
    meta_description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the sections table
CREATE TABLE public.sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER REFERENCES public.pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT,
    "order" INTEGER,
    visible BOOLEAN DEFAULT true,
    content JSONB,
    content_structure JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the stories table for customer stories
CREATE TABLE public.stories (
    id SERIAL PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    excerpt TEXT,
    image TEXT,
    dataAiHint TEXT,
    category TEXT,
    author TEXT,
    authorAvatar TEXT,
    date TEXT,
    clientImage TEXT,
    location TEXT,
    project TEXT,
    size TEXT,
    quote TEXT,
    content TEXT,
    gallery JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert data into the pages table
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('home', 'Home', 'Shriram Interio - Top Interior Designers in Pune', 'Welcome to Shriram Interio, Pune''s leading interior design company. We specialize in modular kitchens, wardrobes, and full home interiors with a focus on quality and customer satisfaction.'),
('about', 'About Us', 'About Shriram Interio | Our Story and Mission', 'Learn about Shriram Interio, our journey since 2016, our mission to transform spaces, and the values that drive our passion for design.'),
('customer-stories', 'Customer Stories', 'Happy Client Stories | Shriram Interio', 'Read inspiring stories from our happy clients. See how we transformed their houses into dream homes with our expert interior design solutions.');

-- Get page IDs
-- Note: This is a simplified way to get IDs for a seed script.
-- In a real application, you might handle this differently.
DO $$
DECLARE
    home_page_id INTEGER;
    about_page_id INTEGER;
    customer_stories_page_id INTEGER;
BEGIN
    SELECT id INTO home_page_id FROM public.pages WHERE slug = 'home';
    SELECT id INTO about_page_id FROM public.pages WHERE slug = 'about';
    SELECT id INTO customer_stories_page_id FROM public.pages WHERE slug = 'customer-stories';

    -- Home Page Sections
    INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (home_page_id, 'hero', 'Hero Section', 1, true, 
    '{"title": "Hero", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Experience quality craftsmanship and timely delivery with our expert team.", "buttonText": "Explore Our Designs", "videoUrl": "https://videos.pexels.com/video-files/8329388/8329388-hd_1920_1080_30fps.mp4", "slides": [{"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "videoUrl": {"type": "text", "label": "Background Video URL"}, "slides": {"type": "repeater", "label": "Image Slides", "fields": {"image": {"type": "image", "label": "Image"}}}}'
    ),
    (home_page_id, 'welcome', 'Welcome Section', 2, true, 
    '{"paragraph1": "Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Our journey began with a vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project.", "paragraph2": "We specialize in modular kitchens, wardrobes, and full home interiors, ensuring every corner of your home is both beautiful and functional. Over the years, we''ve evolved, but our commitment to excellence remains unwavering.", "image": "https://images.unsplash.com/photo-1558997519-83ea9252edf8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbnRlcmlvciUyMGRlc2lnbiUyMHN0dWRpb3xlbnwwfHx8fDE3NTYxOTI5MjJ8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
    '{"paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "image": {"type": "image", "label": "Image"}}'
    ),
    (home_page_id, 'about_company', 'About Company', 3, true, 
    '{"title": "About Company", "text": "A place where design meets inspiration and innovation. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."}',
    '{"title": {"type": "text", "label": "Title"}, "text": {"type": "textarea", "label": "Text"}}'
    ),
    (home_page_id, 'why_us', 'Why Us', 4, true,
    '{"title": "Why Us", "subtitle": "Discover the difference that quality, expertise, and passion can make.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
    ),
    (home_page_id, 'work_gallery', 'Work Gallery', 5, true,
    '{"title": "Work Gallery", "subtitle": "A glimpse into the spaces we''ve transformed.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}}'
    ),
    (home_page_id, 'comfort_design', 'Comfort Design', 6, true,
    '{"title": "Design at Your Comfort", "subtitle": "Our process is designed to be as convenient and transparent as possible, bringing your dream home to life without the hassle.", "items": [{"title": "Live 3D Designs", "description": "Experience your new home with our live 3D designing sessions. Visualize your space and make changes in real-time."}, {"title": "Contactless Experience", "description": "From design to delivery, we offer a safe and seamless contactless experience for your convenience."}, {"title": "Instant Pricing", "description": "Get transparent and instant pricing for your project with no hidden costs."}, {"title": "Expertise & Passion", "description": "Our team of passionate designers brings a wealth of expertise to every project, ensuring exceptional results."}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
    ),
    (home_page_id, 'what_we_do', 'What We Do', 7, true,
    '{"title": "What We Do", "subtitle": "From trendy designs to best-selling classics, explore our curated collections.", "trendingItems": [{"name": "Parallel Kitchen", "image": "/trending1.jpg", "hint": "parallel kitchen"}, {"name": "U-Shaped Modular Kitchen", "image": "/trending2.jpg", "hint": "u-shaped kitchen"}, {"name": "L-Shaped Modular Kitchen", "image": "/trending3.jpg", "hint": "l-shaped kitchen"}, {"name": "Sliding Wardrobe", "image": "/trending4.jpg", "hint": "sliding wardrobe"}, {"name": "Hinged Wardrobe", "image": "/trending5.jpg", "hint": "hinged wardrobe"}], "bestSellingKitchens": [{"name": "Classic L-Shape", "image": "/kitchen1.jpg", "hint": "classic l-shaped kitchen"}, {"name": "Modern U-Shape", "image": "/kitchen2.jpg", "hint": "modern u-shaped kitchen"}, {"name": "Island Kitchen", "image": "/kitchn1.jpg", "hint": "island kitchen"}, {"name": "Minimalist Galley", "image": "/kitchengallery.jpg", "hint": "minimalist galley kitchen"}], "bestSellingWardrobes": [{"name": "Sliding Door", "image": "/SlidingWardrobe.jpg", "hint": "sliding wardrobe"}, {"name": "Walk-in Wonder", "image": "/r1.jpg", "hint": "walk-in wardrobe"}, {"name": "Hinged Classic", "image": "/b1.jpg", "hint": "hinged wardrobe"}, {"name": "Mirrored Finish", "image": "/b2.jpg", "hint": "mirrored wardrobe"}]}',
    '{}'
    ),
    (home_page_id, 'testimonials', 'Testimonials', 8, true,
    '{"title": "Testimonials", "subtitle": "Hear from our happy clients across Pune.", "buttonText": "View All Testimonials", "items": [{"name": "Anjali P.", "review": "Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish.", "image": "/avatar-1.png"}, {"name": "Rohan & Priya S.", "review": "The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations.", "image": "/avatar-2.png"}, {"name": "Meera K.", "review": "Excellent service and stunning wardrobe design. The quality of materials is top-notch, and the installation was seamless.", "image": "/avatar-3.png"}, {"name": "Sameer Joshi", "review": "We opted for the full home interior service and it was the best decision. The final result is a cohesive, beautiful home.", "image": "/avatar-4.png"}]}',
    '{}'
    ),
    (home_page_id, 'faq', 'FAQ', 9, true,
    '{"title": "FAQ", "subtitle": "Have questions? We have answers.", "items": [{"question": "What services do you offer?", "answer": "We offer a comprehensive range of interior design services, including modular kitchens, custom wardrobes, full home interiors, living area design, bedroom design, and more. We handle everything from design conception to final installation."}, {"question": "What is your design process?", "answer": "Our process begins with a free consultation to understand your needs. We then move to 3D design and visualization, material selection, manufacturing, and finally, professional installation and handover. We keep you involved at every step."}, {"question": "How much does interior design cost?", "answer": "The cost varies greatly depending on the scope of the project, materials chosen, and the size of the space. We provide transparent pricing and detailed quotes after the initial consultation. We offer solutions for various budget ranges."}, {"question": "How long does a project typically take?", "answer": "A typical project timeline can range from a few weeks for a single room to a few months for a full home interior. After understanding your requirements, we provide a detailed project timeline."}]}',
    '{}'
    ),
    (home_page_id, 'partners', 'Partners', 10, true,
    '{"title": "Partners", "subtitle": "MEET OUR PARTNERS", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
    '{}'
    );

    -- About Page Sections
    INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (about_page_id, 'hero', 'Hero Section', 1, true,
    '{"title": "About Shriram Interio", "subtitle": "Crafting spaces that inspire and innovate since 2016.", "backgroundImage": "https://images.unsplash.com/photo-1549488344-cbb6c34cf08b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw3fHxpbnRlcmlvciUyMGRlc2lnbiUyMGJhY2tncm91bmR8ZW58MHx8fHwxNzU2MjgyNTMwfDA&ixlib=rb-4.1.0&q=80&w=1080"}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'
    ),
    (about_page_id, 'story', 'Our Story', 2, true,
    '{"heading": "Our Story", "subheading": "The journey from a vision to a leading design studio.", "paragraph1": "SHRIRAM INTERIO was founded in 2016 with a singular vision: to revolutionize interior design by blending creativity, functionality, and a deeply personal touch in every project. We began as a small team of passionate designers who believed that a well-designed space could truly transform lives.", "paragraph2": "From our humble beginnings, we have grown into a full-service design studio, but our core values remain the same. We are committed to understanding the unique needs and aspirations of each client, ensuring that every space we create is a true reflection of their personality and lifestyle.", "paragraph3": "Our journey has been one of continuous learning and evolution. We stay at the forefront of design trends and technological advancements to bring you the best in materials, craftsmanship, and innovation.", "paragraph4": "Today, we are proud to have a portfolio of hundreds of successfully completed projects and a long list of satisfied clients who are a testament to our dedication and passion.", "image": "https://images.unsplash.com/photo-1572021335469-31706a17aaef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYyODI2MTN8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
    '{"heading": {"type": "text", "label": "Heading"}, "subheading": {"type": "text", "label": "Subheading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
    ),
    (about_page_id, 'journey', 'Our Journey', 3, true,
    '{"heading": "Our Journey", "paragraph1": "Our journey has been incredible. We started small, with a big dream. The first few years were all about building trust and showing what we could do. We worked on small projects, putting our hearts into every detail.", "paragraph2": "Word started to spread. People liked our work, and we started getting bigger projects. It was exciting and challenging. We had to grow our team and learn new things. We made sure to always stick to our values of quality and customer satisfaction.", "paragraph3": "Today, we are a well-known name in interior design. We have worked on many homes and offices, each with its own unique story. Our journey has been full of hard work, learning, and success. We are grateful to our clients for trusting us and making us a part of their lives.", "paragraph4": "We look forward to continuing our journey, creating beautiful spaces, and making more people happy. The future is bright, and we are excited to see what it holds for us. We will continue to innovate and bring the best designs to our clients.", "image": "https://images.unsplash.com/photo-1541450805268-4822a3a774ca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxkZXNpZ24lMjBtb29kJTIwYm9hcmR8ZW58MHx8fHwxNzU2MjgzMDM3fDA&ixlib=rb-4.1.0&q=80&w=1080"}',
    '{"heading": {"type": "text", "label": "Heading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
    ),
    (about_page_id, 'values', 'Our Values', 4, true,
    '{"title": "Our Values", "subtitle": "The principles that guide our work and define our company.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Values", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
    ),
    (about_page_id, 'mission_vision', 'Mission & Vision', 5, true,
    '{"visionTitle": "Our Vision", "visionText": "To be the most sought-after interior design firm in Pune, renowned for our innovative designs, exceptional quality, and unwavering commitment to client satisfaction.", "missionTitle": "Our Mission", "missionText": "To create beautiful, functional, and personalized living spaces that inspire and enhance the lives of our clients, through a collaborative process and a relentless pursuit of excellence."}',
    '{"visionTitle": {"type": "text", "label": "Vision Title"}, "visionText": {"type": "textarea", "label": "Vision Text"}, "missionTitle": {"type": "text", "label": "Mission Title"}, "missionText": {"type": "textarea", "label": "Mission Text"}}'
    ),
    (about_page_id, 'team', 'Meet the Team', 6, true,
    '{"title": "Meet the Team", "subtitle": "The creative minds behind our success.", "members": [{"name": "Ravi Kumar", "role": "Founder & Lead Designer", "image": "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBtYW58ZW58MHx8fHwxNzU2MjgzMjc4fDA&ixlib=rb-4.1.0&q=80&w=1080", "bio": "With over 15 years of experience, Ravi is the visionary force behind Shriram Interio. His passion for design and attention to detail are evident in every project."}, {"name": "Priya Sharma", "role": "Senior Interior Designer", "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjB3b21hbnxlbnwwfHx8fDE3NTYyODMyOTd8MA&ixlib=rb-4.1.0&q=80&w=1080", "bio": "Priya specializes in creating elegant and functional residential spaces. She has a keen eye for color, texture, and light, bringing a unique touch to each home."}, {"name": "Amit Patel", "role": "Project Manager", "image": "https://images.unsplash.com/photo-1601455763557-db1bea8a9a5a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbmRpYW4lMjBtYW58ZW58MHx8fHwxNzU2MjgzMjc4fDA&ixlib=rb-4.1.0&q=80&w=1080", "bio": "Amit ensures that every project runs smoothly, from initial planning to final handover. His organizational skills and commitment to timelines are unparalleled."}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "members": {"type": "repeater", "label": "Team Members", "fields": {"name": {"type": "text", "label": "Name"}, "role": {"type": "text", "label": "Role"}, "image": {"type": "image", "label": "Image"}, "bio": {"type": "textarea", "label": "Bio"}}}}'
    );

    -- Customer Stories Page Sections
    INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure) VALUES
    (customer_stories_page_id, 'header', 'Header', 1, true, 
    '{"title": "Customer Stories", "subtitle": "Real stories from real homeowners. Discover how we turn houses into dream homes, one happy client at a time."}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}}'
    ),
    (customer_stories_page_id, 'featured_story', 'Featured Story', 2, true,
    '{"buttonText": "Read Their Story"}',
    '{"buttonText": {"type": "text", "label": "Button Text"}}'
    ),
    (customer_stories_page_id, 'more_stories', 'More Stories', 3, true,
    '{"title": "More Success Stories"}',
    '{"title": {"type": "text", "label": "Title"}}'
    ),
    (customer_stories_page_id, 'work_gallery', 'Work Gallery', 4, true,
    '{"title": "Our Work in a Nutshell", "subtitle": "A gallery of our finest transformations.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Gallery Items", "fields": {"title": {"type": "text", "label": "Title"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}}'
    ),
    (customer_stories_page_id, 'partners', 'Partners', 5, true,
    '{"title": "Our Trusted Partners", "subtitle": "QUALITY YOU CAN RELY ON", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Partners", "fields": {"name": {"type": "text", "label": "Name"}, "logoSrc": {"type": "image", "label": "Logo"}}}}'
    ),
    (customer_stories_page_id, 'faq', 'FAQ', 6, true,
    '{"title": "Frequently Asked Questions", "subtitle": "Everything you need to know about our customer-centric process.", "items": [{"question": "How do you select which customer stories to feature?", "answer": "We feature a diverse range of projects that showcase our capabilities across different styles, budgets, and home types. We always seek our clients'' permission before sharing their stories and beautiful homes with the world."}, {"question": "Can I speak to one of your past clients?", "answer": "Protecting our clients'' privacy is paramount. While we cannot share their contact details directly, our testimonials and detailed stories provide authentic insights into their experience with us. We are confident they speak for themselves!"}, {"question": "What if I''m not completely happy with the final outcome?", "answer": "Your complete satisfaction is our number one goal. We have a multi-stage review process and won''t consider a project complete until you are absolutely thrilled with your new space. We also offer a one-year warranty for peace of mind."}]}',
    '{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "FAQ Items", "fields": {"question": {"type": "text", "label": "Question"}, "answer": {"type": "textarea", "label": "Answer"}}}}'
    );
END $$;

-- Insert data for individual stories
INSERT INTO public.stories (slug, title, excerpt, image, dataAiHint, category, author, authorAvatar, date, clientImage, location, project, size, quote, content, gallery) VALUES
(
    'the-mehtas-dream-kitchen',
    'The Mehtas'' Dream Kitchen: A Blend of Style and Functionality',
    'Discover how we transformed a cramped, outdated kitchen into a spacious, modern culinary haven for the Mehta family in just 45 days.',
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080',
    'modern kitchen',
    'Kitchen Interiors',
    'Rohan & Priya Mehta',
    '/avatar-2.png',
    '15 July, 2024',
    'https://images.unsplash.com/photo-1506277886164-e25aa3f4ef7f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2Mjg0NTU4fDA&ixlib=rb-4.1.0&q=80&w=1080',
    'Koregaon Park, Pune',
    'Mehta Residence',
    '3 BHK',
    'Shriram Interio didn''t just give us a kitchen; they gave us the heart of our home.',
    '<p>The Mehta family came to us with a common problem: a kitchen that was too small, too dark, and too outdated for their modern lifestyle. They dreamed of a bright, airy space where they could cook, entertain, and create memories.</p><p>Our design team took on the challenge, focusing on smart space-saving solutions and a clean, minimalist aesthetic. We knocked down a non-structural wall to open up the area, introduced a sleek breakfast bar for casual dining, and installed custom-built cabinetry to maximize storage.</p><p>The result is a stunning transformation. The new U-shaped layout is incredibly efficient, and the combination of glossy white finishes and warm wood accents creates a welcoming atmosphere. The Mehtas are thrilled with their new kitchen, which has quickly become their favorite room in the house.</p>',
    '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'
),
(
    'sharmas-serene-sanctuary',
    'The Sharma''s Serene Sanctuary: A Master Bedroom Makeover',
    'From cluttered chaos to a tranquil retreat, see how we designed a master bedroom for the Sharmas that perfectly balances comfort, elegance, and personality.',
    'https://images.unsplash.com/photo-1617098900591-3f90928e8c54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxMnx8YmVkcm9vbSUyMGludGVyaW9yfGVufDB8fHx8fDE3NTYwMTM4MTJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    'modern bedroom',
    'Bedroom Interiors',
    'Anjali Sharma',
    '/avatar-1.png',
    '28 June, 2024',
    'https://images.unsplash.com/photo-1610940345938-15482390a747?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbmRpYW4lMjB3b21hbnxlbnwwfHx8fDE3NTYyODQ2ODZ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    'Baner, Pune',
    'Sharma Residence',
    '4 BHK',
    'Our bedroom is now my personal sanctuary. The team understood my vision perfectly.',
    '<p>Anjali Sharma wanted her master bedroom to be more than just a place to sleep. She envisioned a personal retreat—a calm, organized, and stylish space to unwind after a long day. Her existing room, however, was cluttered and lacked a cohesive design.</p><p>We focused on a soothing color palette of muted blues and soft grays, complemented by rich textures and natural materials. A custom-designed walk-in closet with smart organizational features was a game-changer, eliminating clutter and creating a sense of order. We also designed a cozy reading nook by the window, complete with a comfortable armchair and ambient lighting.</p><p>The centerpiece of the room is a beautiful upholstered headboard that adds a touch of luxury. The final space is a testament to how thoughtful design can impact well-being. It''s a serene sanctuary that Anjali now cherishes.</p>',
    '[{"src": "/bedroom-gallery1.jpg", "alt": "Full view of the bedroom", "dataAiHint": "serene bedroom"}, {"src": "/bedroom-gallery2.jpg", "alt": "Walk-in closet details", "dataAiHint": "organized closet"}, {"src": "/bedroom-gallery3.jpg", "alt": "Cozy reading nook", "dataAiHint": "reading nook"}]'
),
(
    'a-living-room-for-the-guptas',
    'A Living Room for the Guptas: Where Family Comes Together',
    'The Gupta family needed a living room that could keep up with their active lifestyle. We created a multi-functional space that’s perfect for everything from movie nights to festive gatherings.',
    'https://images.unsplash.com/photo-1554995207-c18c203602cb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxsaXZpbmclMjByb29tJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU2Mjg0ODM2fDA&ixlib=rb-4.1.0&q=80&w=1080',
    'spacious living room',
    'Living Area Design',
    'Mr. & Mrs. Gupta',
    '/avatar-5.png',
    '05 June, 2024',
    'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2Mjg0NTU4fDA&ixlib=rb-4.1.0&q=80&w=1080',
    'Hinjewadi, Pune',
    'Gupta Residence',
    '2 BHK',
    'It’s not just a living room; it’s the hub of our family''s happiness. Thank you, Shriram Interio!',
    '<p>For the Gupta family, the living room is the most important space in their home. It''s where they entertain guests, watch movies, and spend quality time together. They needed a design that was durable, comfortable, and flexible enough to accommodate various activities.</p><p>We started by optimizing the layout to create distinct zones for seating, entertainment, and even a small play area for the kids. A large, comfortable sectional sofa was chosen to provide ample seating. The highlight of the room is a custom-built entertainment unit that neatly houses all their media devices and provides plenty of storage.</p><p>We used a warm, neutral color palette with pops of vibrant color in the cushions and artwork to create a cheerful and inviting atmosphere. The result is a living room that is as practical as it is beautiful, a perfect reflection of the Gupta family''s vibrant personality.</p>',
    '[{"src": "/living-gallery1.jpg", "alt": "Overall view of the living room", "dataAiHint": "family living room"}, {"src": "/living-gallery2.jpg", "alt": "Custom entertainment unit", "dataAiHint": "tv unit"}, {"src": "/living-gallery3.jpg", "alt": "Seating area detail", "dataAiHint": "comfortable sofa"}]'
);
