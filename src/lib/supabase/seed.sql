-- Drop existing tables in reverse order of dependency to avoid foreign key conflicts
DROP TABLE IF EXISTS sections;
DROP TABLE IF EXISTS stories;
DROP TABLE IF EXISTS pages;


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
    type text NOT NULL,
    title text,
    "order" integer,
    visible boolean DEFAULT true,
    content jsonb,
    content_structure jsonb
);

-- Create the stories table
CREATE TABLE public.stories (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug text NOT NULL UNIQUE,
    title text NOT NULL,
    category text,
    excerpt text,
    image text,
    "dataAiHint" text,
    author text,
    "authorAvatar" text,
    date text,
    content text,
    "clientImage" text,
    location text,
    project text,
    size text,
    quote text,
    gallery jsonb
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.pages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stories ENABLE ROW LEVEL SECURITY;

-- Create policies to allow public read access
CREATE POLICY "Allow public read access to pages" ON public.pages FOR SELECT USING (true);
CREATE POLICY "Allow public read access to sections" ON public.sections FOR SELECT USING (true);
CREATE POLICY "Allow public read access to stories" ON public.stories FOR SELECT USING (true);
-- Note: You will need to set up policies for write access (INSERT, UPDATE, DELETE) for authenticated admin users.


-- Insert data for all pages
-- Home Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('home', 'Home', 'Shriram Interio Digital - Pune''s Best Interior Designers', 'Welcome to Shriram Interio, Pune''s leading interior design company. We specialize in modular kitchens, wardrobes, and full home interiors. Quality, innovation, and customer satisfaction are at the heart of what we do.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- About Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('about', 'About Us', 'About Shriram Interio | Our Story, Mission, and Team', 'Learn about Shriram Interio, our journey since 2016, our mission to create exceptional spaces, and meet the passionate team dedicated to bringing your vision to life.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- Customer Stories Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('customer-stories', 'Customer Stories', 'Happy Client Stories | Shriram Interio Portfolio', 'Read inspiring stories from our happy clients. See how we transformed their houses into dream homes with our interior design expertise.')
ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
meta_title = EXCLUDED.meta_title,
meta_description = EXCLUDED.meta_description;

-- Get the IDs of the pages we just inserted
DO $$
DECLARE
    home_page_id bigint;
    about_page_id bigint;
    customer_stories_page_id bigint;
BEGIN
    SELECT id INTO home_page_id FROM public.pages WHERE slug = 'home';
    SELECT id INTO about_page_id FROM public.pages WHERE slug = 'about';
    SELECT id INTO customer_stories_page_id FROM public.pages WHERE slug = 'customer-stories';
    
    -- Home Page Sections
    INSERT INTO public.sections (page_id, type, title, "order", content, content_structure) VALUES
    (home_page_id, 'hero', 'Hero Section', 1,
        '{"title": "Hero", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Experience quality craftsmanship and timely delivery with our expert team.", "buttonText": "Explore Our Designs", "videoUrl": "https://videos.pexels.com/video-files/8329388/8329388-hd_1920_1080_30fps.mp4", "slides": [{"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM4OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "buttonText": {"label": "Button Text", "type": "text"}, "videoUrl": {"label": "Background Video URL", "type": "text"}, "slides": {"label": "Background Image Slides", "type": "repeater"}}'
    ),
    (home_page_id, 'welcome', 'Welcome Section', 2,
        '{"paragraph1": "Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Our journey began with a vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project.", "paragraph2": "We specialize in modular kitchens, wardrobes, and full home interiors, ensuring every corner of your home is both beautiful and functional. Over the years, we''ve evolved, but our commitment to excellence remains unwavering.", "image": "https://images.unsplash.com/photo-1558997519-83ea9252edf8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbnRlcmlvciUyMGRlc2lnbiUyMHN0dWRpb3xlbnwwfHx8fDE3NTYxOTI5MjJ8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
        '{"paragraph1": {"label": "Paragraph 1", "type": "textarea"}, "paragraph2": {"label": "Paragraph 2", "type": "textarea"}, "image": {"label": "Image URL", "type": "image"}}'
    ),
    (home_page_id, 'about_company', 'About Company Section', 3,
        '{"title": "About Company", "text": "A place where design meets inspiration and innovation. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."}',
        '{"title": {"label": "Title", "type": "text"}, "text": {"label": "Text", "type": "textarea"}}'
    ),
    (home_page_id, 'why_us', 'Why Us Section', 4,
        '{"title": "Why Us", "subtitle": "Discover the difference that quality, expertise, and passion can make.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "Items", "type": "repeater"}}'
    ),
    (home_page_id, 'work_gallery', 'Work Gallery Section', 5,
        '{"title": "Work Gallery", "subtitle": "A glimpse into the spaces we''ve transformed.", "items": [{"image": "/b2.jpg", "title": "Modern Living Room", "hint": "modern living room"}, {"image": "/b1.jpg", "title": "Elegant Kitchen Design", "hint": "elegant kitchen"}, {"image": "/kitchen.jpg", "title": "Cozy Bedroom Interior", "hint": "cozy bedroom"}, {"image": "/SlidingWardrobe.jpg", "title": "Luxury Wardrobe", "hint": "luxury wardrobe"}, {"image": "/kitchengallery.jpg", "title": "Contemporary Space", "hint": "contemporary space"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "Gallery Items", "type": "repeater"}}'
    ),
    (home_page_id, 'comfort_design', 'Comfort Design Section', 6,
        '{"title": "Design at Your Comfort", "subtitle": "Our process is designed to be as convenient and transparent as possible, bringing your dream home to life without the hassle.", "items": [{"title": "Live 3D Designs", "description": "Experience your new home with our live 3D designing sessions. Visualize your space and make changes in real-time."}, {"title": "Contactless Experience", "description": "From design to delivery, we offer a safe and seamless contactless experience for your convenience."}, {"title": "Instant Pricing", "description": "Get transparent and instant pricing for your project with no hidden costs."}, {"title": "Expertise & Passion", "description": "Our team of passionate designers brings a wealth of expertise to every project, ensuring exceptional results."}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "Items", "type": "repeater"}}'
    ),
    (home_page_id, 'what_we_do', 'What We Do Section', 7,
        '{"title": "What We Do", "subtitle": "From trendy designs to best-selling classics, explore our curated collections.", "trendingItems": [{"name": "Parallel Kitchen", "image": "/trending1.jpg", "hint": "parallel kitchen"}, {"name": "U-Shaped Modular Kitchen", "image": "/trending2.jpg", "hint": "u-shaped kitchen"}, {"name": "L-Shaped Modular Kitchen", "image": "/trending3.jpg", "hint": "l-shaped kitchen"}, {"name": "Sliding Wardrobe", "image": "/trending4.jpg", "hint": "sliding wardrobe"}, {"name": "Hinged Wardrobe", "image": "/trending5.jpg", "hint": "hinged wardrobe"}], "bestSellingKitchens": [{"name": "Classic L-Shape", "image": "/kitchen1.jpg", "hint": "classic l-shaped kitchen"}, {"name": "Modern U-Shape", "image": "/kitchen2.jpg", "hint": "modern u-shaped kitchen"}, {"name": "Island Kitchen", "image": "/kitchn1.jpg", "hint": "island kitchen"}, {"name": "Minimalist Galley", "image": "/kitchengallery.jpg", "hint": "minimalist galley kitchen"}], "bestSellingWardrobes": [{"name": "Sliding Door", "image": "/SlidingWardrobe.jpg", "hint": "sliding wardrobe"}, {"name": "Walk-in Wonder", "image": "/r1.jpg", "hint": "walk-in wardrobe"}, {"name": "Hinged Classic", "image": "/b1.jpg", "hint": "hinged wardrobe"}, {"name": "Mirrored Finish", "image": "/b2.jpg", "hint": "mirrored wardrobe"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "trendingItems": {"label": "Trending Items", "type": "repeater"}, "bestSellingKitchens": {"label": "Best Selling Kitchens", "type": "repeater"}, "bestSellingWardrobes": {"label": "Best Selling Wardrobes", "type": "repeater"}}'
    ),
    (home_page_id, 'testimonials', 'Testimonials Section', 8,
        '{"title": "Testimonials", "subtitle": "Hear from our happy clients across Pune.", "buttonText": "View All Testimonials", "items": [{"name": "Anjali P.", "review": "Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish.", "image": "/avatar-1.png"}, {"name": "Rohan & Priya S.", "review": "The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations.", "image": "/avatar-2.png"}, {"name": "Meera K.", "review": "Excellent service and stunning wardrobe design. The quality of materials is top-notch, and the installation was seamless.", "image": "/avatar-3.png"}, {"name": "Sameer Joshi", "review": "We opted for the full home interior service and it was the best decision. The final result is a cohesive, beautiful home.", "image": "/avatar-4.png"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "buttonText": {"label": "Button Text", "type": "text"}, "items": {"label": "Testimonials", "type": "repeater"}}'
    ),
    (home_page_id, 'faq', 'FAQ Section', 9,
        '{"title": "FAQ", "subtitle": "Have questions? We have answers.", "items": [{"question": "What services do you offer?", "answer": "We offer a comprehensive range of interior design services, including modular kitchens, custom wardrobes, full home interiors, living area design, bedroom design, and more. We handle everything from design conception to final installation."}, {"question": "What is your design process?", "answer": "Our process begins with a free consultation to understand your needs. We then move to 3D design and visualization, material selection, manufacturing, and finally, professional installation and handover. We keep you involved at every step."}, {"question": "How much does interior design cost?", "answer": "The cost varies greatly depending on the scope of the project, materials chosen, and the size of the space. We provide transparent pricing and detailed quotes after the initial consultation. We offer solutions for various budget ranges."}, {"question": "How long does a project typically take?", "answer": "A typical project timeline can range from a few weeks for a single room to a few months for a full home interior. After understanding your requirements, we provide a detailed project timeline."}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "FAQ Items", "type": "repeater"}}'
    ),
    (home_page_id, 'partners', 'Partners Section', 10,
        '{"title": "Partners", "subtitle": "MEET OUR PARTNERS", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "items": {"label": "Partners", "type": "repeater"}}'
    );

    -- About Page Sections
    INSERT INTO public.sections (page_id, type, title, "order", content, content_structure) VALUES
    (about_page_id, 'hero', 'Hero Section', 1,
        '{"title": "About Shriram Interio", "subtitle": "Crafting Stories, Building Dreams Since 2016", "backgroundImage": "https://images.unsplash.com/photo-1540555233353-96e164893706?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw3fHxpbnRlcmlvciUyMGRlc2lnbiUyMHN0dWRpb3xlbnwwfHx8fDE3NTYxOTI5MjJ8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "backgroundImage": {"label": "Background Image URL", "type": "image"}}'
    ),
    (about_page_id, 'story', 'Our Story', 2,
        '{"heading": "Our Story", "subheading": "The journey of a thousand homes begins with a single idea.", "paragraph1": "SHRIRAM INTERIO began in 2016 with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. We saw a gap in the market for high-quality, reliable interior solutions in Pune and decided to fill it.", "paragraph2": "Our founders, driven by a passion for design and a commitment to craftsmanship, started with a small workshop and a dedicated team. The goal was simple: to create beautiful, livable spaces that reflect the unique personalities of our clients.", "paragraph3": "From our first modular kitchen to our latest full-home interior project, our core values have remained the same. We believe in listening to our clients, understanding their dreams, and turning them into reality with precision and care.", "paragraph4": "Today, we are proud to be one of Pune''s leading interior design firms, known for our innovative designs, quality materials, and unwavering commitment to customer satisfaction. Our story is one of growth, passion, and the hundreds of happy homes we''ve had the privilege to create.", "image": "https://images.unsplash.com/photo-1572021335469-31706a17aaef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYxOTQ0NjB8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
        '{"heading": {"label": "Heading", "type": "text"}, "subheading": {"label": "Subheading", "type": "text"}, "paragraph1": {"label": "Paragraph 1", "type": "textarea"}, "paragraph2": {"label": "Paragraph 2", "type": "textarea"}, "paragraph3": {"label": "Paragraph 3", "type": "textarea"}, "paragraph4": {"label": "Paragraph 4", "type": "textarea"}, "image": {"label": "Image URL", "type": "image"}}'
    ),
    (about_page_id, 'journey', 'Our Journey', 3,
        '{"heading": "Our Journey", "paragraph1": "The journey of a thousand homes begins with a single idea. Our story started in 2016, born from a passion for creating spaces that are not just beautiful, but also deeply personal and functional.", "paragraph2": "We began as a small, dedicated team with a big vision: to bring high-quality, bespoke interior design to Pune. Our focus was on understanding the unique needs of each client and translating their dreams into tangible, everyday luxury.", "paragraph3": "Through years of dedication, we have grown into a full-service design firm, expanding our expertise from modular kitchens and wardrobes to complete home interiors. Every project has been a stepping stone, teaching us, challenging us, and fueling our passion.", "paragraph4": "Our journey is marked by the smiling faces of hundreds of satisfied clients and the beautiful homes we have co-created. We look forward to continuing this journey, one dream home at a time.", "image": "https://images.unsplash.com/photo-1516556859649-6d88a1a89f92?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxkZXNpZ24lMjBtb29kJTIwYm9hcmR8ZW58MHx8fHwxNzU2MTk0NTQyfDA&ixlib=rb-4.1.0&q=80&w=1080"}',
        '{"heading": {"label": "Heading", "type": "text"}, "paragraph1": {"label": "Paragraph 1", "type": "textarea"}, "paragraph2": {"label": "Paragraph 2", "type": "textarea"}, "paragraph3": {"label": "Paragraph 3", "type": "textarea"}, "paragraph4": {"label": "Paragraph 4", "type": "textarea"}, "image": {"label": "Image URL", "type": "image"}}'
    ),
    (about_page_id, 'values', 'Our Values', 4,
        '{"title": "What We Stand For", "subtitle": "Our core values guide every decision we make.", "items": [{"title": "Expert Design Team", "description": "Our team of experienced designers works closely with you to bring your vision to life."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit every taste and budget."}, {"title": "Affordable Design Fees", "description": "Get premium design solutions without breaking the bank. We believe in transparent pricing."}, {"title": "On-Time Project Delivery", "description": "We respect your time and are committed to completing projects on schedule."}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "items": {"label": "Value Items", "type": "repeater"}}'
    ),
    (about_page_id, 'mission_vision', 'Mission and Vision', 5,
        '{"visionTitle": "Our Vision", "visionText": "To be the most trusted and innovative interior design company in Pune, transforming spaces into personalized sanctuaries that enhance the quality of life.", "missionTitle": "Our Mission", "missionText": "To deliver exceptional interior design solutions through creativity, quality craftsmanship, and a relentless focus on customer satisfaction. We aim to create beautiful, functional, and timeless spaces that our clients are proud to call home."}',
        '{"visionTitle": {"label": "Vision Title", "type": "text"}, "visionText": {"label": "Vision Text", "type": "textarea"}, "missionTitle": {"label": "Mission Title", "type": "text"}, "missionText": {"label": "Mission Text", "type": "textarea"}}'
    ),
    (about_page_id, 'team', 'Meet the Team', 6,
        '{"title": "Meet Our Creative Minds", "subtitle": "The passionate team dedicated to making your dream home a reality.", "members": [{"name": "Mr. Shriram", "role": "Founder & Lead Designer", "bio": "With over a decade of experience, Mr. Shriram leads our creative vision, ensuring every project is a masterpiece of design and functionality.", "image": "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBtYW58ZW58MHx8fHwxNzU2MTk0ODA0fDA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Priya Deshpande", "role": "Project Manager", "bio": "Priya ensures that every project runs smoothly, from initial concept to final handover, guaranteeing on-time delivery and flawless execution.", "image": "https://images.unsplash.com/photo-1542600718-a14de844f271?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjB3b21hbnxlbnwwfHx8fDE3NTYxOTQ4NDN8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Rajesh Kumar", "role": "Head of Operations", "bio": "Rajesh oversees our state-of-the-art workshop and logistics, ensuring that only the highest quality materials are used in every project.", "image": "https://images.unsplash.com/photo-1615634289168-35a065b3a0a0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw3fHxpbmRpYW4lMjBtYW58ZW58MHx8fHwxNzU2MTk0ODA0fDA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "members": {"label": "Team Members", "type": "repeater"}}'
    );

    -- Customer Stories Page Sections
    INSERT INTO public.sections (page_id, type, title, "order", content, content_structure) VALUES
    (customer_stories_page_id, 'header', 'Header Section', 1,
        '{"title": "Our Client Stories", "subtitle": "Discover how we''ve transformed houses into dream homes, one happy client at a time. Read their stories and see the magic unfold."}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}}'
    ),
    (customer_stories_page_id, 'featured_story', 'Featured Story Section', 2,
        '{"buttonText": "Read Full Story"}',
        '{"buttonText": {"label": "Button Text", "type": "text"}}'
    ),
    (customer_stories_page_id, 'more_stories', 'More Stories Section', 3,
        '{"title": "More Inspiring Stories", "stories": []}',
        '{"title": {"label": "Title", "type": "text"}, "stories": {"label": "Stories", "type": "repeater"}}'
    ),
    (customer_stories_page_id, 'work_gallery', 'Work Gallery Section', 4,
        '{"title": "Our Work Gallery", "subtitle": "A glimpse into the spaces we''ve transformed.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "Gallery Items", "type": "repeater"}}'
    ),
    (customer_stories_page_id, 'partners', 'Partners Section', 5,
        '{"title": "Our Partners", "subtitle": "MEET OUR PARTNERS", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "items": {"label": "Partner Logos", "type": "repeater"}}'
    ),
    (customer_stories_page_id, 'faq', 'FAQ Section', 6,
        '{"title": "Frequently Asked Questions", "subtitle": "Your questions, answered. Find out everything you need to know about our process and services.", "items": [{"question": "Can I see a design before I commit?", "answer": "Absolutely! We provide detailed 2D and 3D designs, along with live 3D sessions, so you can visualize and approve every detail of your project before we begin manufacturing."}, {"question": "What is the warranty on your work?", "answer": "We stand by the quality of our work. Shriram Interio offers a comprehensive one-year warranty on all our projects, giving you complete peace of mind."}, {"question": "How do you ensure the quality of materials?", "answer": "We partner with trusted and renowned brands in the industry for all our materials and hardware. Quality is our top priority, and we ensure every component meets our high standards."}, {"question": "Can you work with my specific budget?", "answer": "Yes, we are committed to providing solutions for various budgets. We maintain complete price transparency and will work with you to create a beautiful home within your financial comfort zone."}]}',
        '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "FAQ Items", "type": "repeater"}}'
    );
END $$;


-- Insert data for individual customer stories
INSERT INTO public.stories (slug, title, category, excerpt, image, "dataAiHint", author, "authorAvatar", date, content, "clientImage", location, project, size, quote, gallery) VALUES
('modern-mumbai-apartment', 'A Modern Makeover for a Mumbai Apartment', 'Full Home Interior', 'See how we transformed a compact 2BHK apartment in Mumbai into a spacious and modern haven for a young couple, focusing on smart storage and multifunctional spaces.', 'https://images.unsplash.com/photo-1596423236284-35a519b5b546?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmbGF0JTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU2MjY5NzYwfDA&ixlib=rb-4.1.0&q=80&w=1080', 'modern apartment', 'Priya & Rohan Mehta', 'https://images.unsplash.com/photo-1601288496920-b6154fe3626a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxJbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2MjcwMTEyfDA&ixlib=rb-4.1.0&q=80&w=1080', 'June 15, 2024',
'<p>When Priya and Rohan approached us, their brief was simple: they wanted a home that was modern, clutter-free, and reflected their vibrant personalities. The challenge was the compact size of their 2BHK apartment in the heart of Mumbai. Our team took this as an opportunity to showcase our expertise in space-saving solutions.</p><p>We started with a neutral color palette of grays, whites, and beiges to create a sense of spaciousness. Strategic pops of color were introduced through decor and furnishings. The living room featured a custom-built entertainment unit with concealed storage, and a sofa-cum-bed to accommodate guests. The kitchen was designed with sleek, handle-less cabinets and integrated appliances to maximize efficiency. In the master bedroom, a floor-to-ceiling wardrobe with mirrored shutters created an illusion of a larger space while offering ample storage. The second bedroom was designed as a multifunctional space - a home office by day and a cozy guest room by night.</p><p>The result was a home that felt spacious, airy, and deeply personal. Priya and Rohan were thrilled with the transformation. "Shriram Interio didn''t just design our house; they understood our lifestyle and created a home that is perfect for us," said Priya.</p>',
'https://images.unsplash.com/photo-1601288496920-b6154fe3626a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxJbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2MjcwMTEyfDA&ixlib=rb-4.1.0&q=80&w=1080',
'Mumbai', 'Oberoi Splendor', '2 BHK', 'Shriram Interio turned our compact apartment into a spacious, modern haven. Their intelligent design and attention to detail are truly commendable.',
'[{"src": "/gallery1.jpg", "alt": "Living Room View", "dataAiHint": "modern living room"}, {"src": "/gallery2.jpg", "alt": "Kitchen View", "dataAiHint": "modular kitchen"}, {"src": "/gallery3.jpg", "alt": "Bedroom View", "dataAiHint": "modern bedroom"}]'
),
('elegant-pune-kitchen', 'An Elegant and Functional Kitchen in Pune', 'Modular Kitchen', 'This project involved a complete kitchen overhaul for a family in Pune who loves to cook and entertain. We designed a U-shaped kitchen that is both beautiful and highly functional.', 'https://images.unsplash.com/photo-1556911220-bff31c812dba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUyNDR8MA&ixlib=rb-4.1.0&q=80&w=1080', 'elegant kitchen', 'The Sharma Family', 'https://images.unsplash.com/photo-1619436183929-5f4e4a3b7de6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmYW1pbHl8ZW58MHx8fHwxNzU2MjcwMTQxfDA&ixlib=rb-4.1.0&q=80&w=1080', 'May 22, 2024',
'<p>The Sharma family''s kitchen was the heart of their home, but it was dated and inefficient. They wanted a space that was modern, easy to maintain, and equipped for their culinary adventures. Our team designed a U-shaped modular kitchen that optimized their workflow.</p><p>We used a combination of high-gloss acrylic and matte laminates for the cabinetry, creating a sophisticated look. A quartz countertop was chosen for its durability and elegance. We incorporated smart storage solutions like a tall pantry unit, magic corners, and drawer organizers to ensure everything had its place. The addition of under-cabinet LED lighting not only enhanced the aesthetics but also provided excellent task lighting. The result is a kitchen that is a joy to cook in and perfect for entertaining guests.</p>',
'https://images.unsplash.com/photo-1619436183929-5f4e4a3b7de6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmYW1pbHl8ZW58MHx8fHwxNzU2MjcwMTQxfDA&ixlib=rb-4.1.0&q=80&w=1080',
'Pune', 'Blue Ridge', '3 BHK', 'Our new kitchen is a dream come true! It''s beautiful, functional, and the heart of our home again.',
'[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src":": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'
),
('bangalore-wardrobe-wonder', 'A Walk-in Wardrobe Wonder in Bangalore', 'Wardrobes', 'For our client in Bangalore, we designed a luxurious walk-in wardrobe that is a perfect blend of style, storage, and sophistication. It''s a fashion lover''s dream come true.', 'https://images.unsplash.com/photo-1616046229478-9901c5536a45?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx3YWxrJTIwaW4lMjBjbG9zZXR8ZW58MHx8fHwxNzU2MjcwMTY0fDA&ixlib=rb-4.1.0&q=80&w=1080', 'walk-in closet', 'Ms. Aisha Khan', 'https://images.unsplash.com/photo-1542600718-a14de844f271?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjB3b21hbnxlbnwwfHx8fDE3NTYxOTQ4NDN8MA&ixlib=rb-4.1.0&q=80&w=1080', 'April 10, 2024',
'<p>Ms. Khan, a fashion blogger from Bangalore, needed a wardrobe that could keep up with her ever-growing collection. She dreamt of a walk-in closet that was not just a storage space, but a style statement in itself. Our team designed a space that was organized, elegant, and filled with light.</p><p>We used a light wood laminate finish to create a warm and inviting atmosphere. The wardrobe features a mix of open shelving for her designer bags, dedicated shoe racks, and ample hanging space. A central island with drawer storage for accessories and a vanity corner with a large mirror and Hollywood lights completed the look. The result is a highly organized and stunningly beautiful space that makes getting ready a luxurious experience every day.</p>',
'https://images.unsplash.com/photo-1542600718-a14de844f271?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjB3b21hbnxlbnwwfHx8fDE3NTYxOTQ4NDN8MA&ixlib=rb-4.1.0&q=80&w=1080',
'Bangalore', 'Prestige Shantiniketan', '4 BHK', 'My wardrobe is now my favorite room in the house! It''s perfectly organized and absolutely beautiful.',
'[{"src": "/wardrobe-gallery1.jpg", "alt": "Full view of the walk-in closet", "dataAiHint": "walk-in closet"}, {"src": "/wardrobe-gallery2.jpg", "alt": "Shoe and bag display", "dataAiHint": "shoe rack"}, {"src": "/wardrobe-gallery3.jpg", "alt": "Vanity and accessory island", "dataAiHint": "vanity mirror"}]'
) ON CONFLICT (slug) DO UPDATE SET
title = EXCLUDED.title,
category = EXCLUDED.category,
excerpt = EXCLUDED.excerpt,
image = EXCLUDED.image,
"dataAiHint" = EXCLUDED."dataAiHint",
author = EXCLUDED.author,
"authorAvatar" = EXCLUDED."authorAvatar",
date = EXCLUDED.date,
content = EXCLUDED.content,
"clientImage" = EXCLUDED."clientImage",
location = EXCLUDED.location,
project = EXCLUDED.project,
size = EXCLUDED.size,
quote = EXCLUDED.quote,
gallery = EXCLUDED.gallery;
