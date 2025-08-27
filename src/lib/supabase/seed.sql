-- Create storage bucket for public assets
INSERT INTO storage.buckets (id, name, public)
VALUES ('public', 'public', true)
ON CONFLICT (id) DO NOTHING;

-- Set up policies for public bucket
CREATE POLICY "Public Access" ON storage.objects
FOR SELECT USING (bucket_id = 'public');

CREATE POLICY "Allow Insert" ON storage.objects
FOR INSERT WITH CHECK (bucket_id = 'public');

CREATE POLICY "Allow Update" ON storage.objects
FOR UPDATE WITH CHECK (bucket_id = 'public');

CREATE POLICY "Allow Delete" ON storage.objects
FOR DELETE USING (bucket_id = 'public');

-- Create pages table
CREATE TABLE IF NOT EXISTS pages (
  id BIGINT PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  meta_title TEXT,
  meta_description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create sections table
CREATE TABLE IF NOT EXISTS sections (
  id BIGINT PRIMARY KEY,
  page_id BIGINT REFERENCES pages(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  title TEXT NOT NULL,
  "order" INT NOT NULL,
  visible BOOLEAN DEFAULT TRUE,
  content JSONB,
  content_structure JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create stories table
CREATE TABLE IF NOT EXISTS stories (
  id BIGINT PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  category TEXT NOT NULL,
  image TEXT NOT NULL,
  "dataAiHint" TEXT,
  excerpt TEXT,
  author TEXT,
  "authorAvatar" TEXT,
  date TEXT,
  content TEXT,
  "clientImage" TEXT,
  location TEXT,
  project TEXT,
  size TEXT,
  quote TEXT,
  gallery JSONB
);

-- Seed data for pages table
INSERT INTO pages (id, slug, title, meta_title, meta_description) VALUES
(1, 'home', 'Home', 'Shriram Interio Digital | Pune''s Top Interior Designers', 'Discover exceptional interior design services in Pune with Shriram Interio. We specialize in modular kitchens, wardrobes, and complete home interiors, tailored to your style.'),
(2, 'about', 'About Us', 'About Shriram Interio | Our Story, Mission & Vision', 'Learn about Shriram Interio, a leading interior design company in Pune. Discover our story, our design philosophy, and the team that brings your vision to life.'),
(3, 'customer-stories', 'Customer Stories', 'Customer Stories & Project Showcases | Shriram Interio', 'Explore detailed stories and project showcases from our satisfied clients. See the transformations we''ve brought to homes across Pune.'),
(4, 'clients', 'Clients', 'Our Valued Clients | Testimonials & Reviews', 'See what our clients have to say about their experience with Shriram Interio. Read testimonials and watch video reviews from satisfied homeowners in Pune.'),
(5, 'services', 'Services', 'Our Interior Design Services | Shriram Interio', 'From modular kitchens to full home interiors, explore the comprehensive range of design services offered by Shriram Interio in Pune.'),
(6, 'portfolio', 'Portfolio', 'Interior Design Portfolio | Shriram Interio Projects', 'Browse our portfolio of completed interior design projects. See examples of our work in modular kitchens, living areas, and more.'),
(7, 'how-it-works', 'How It Works', 'Our Design Process | From Concept to Completion', 'Understand the Shriram Interio design process. Learn about our seamless 6-step journey from initial consultation to final handover.'),
(8, 'contact', 'Contact Us', 'Contact Shriram Interio | Get In Touch Today', 'Contact us for a free consultation. Find our address, phone number, and email to start your interior design journey with Pune''s experts.'),
(9, 'products', 'Products', 'Our Products | Kitchens, Wardrobes & More', 'Explore our range of high-quality interior products, including modular kitchens, custom wardrobes, and space-saving furniture.')
ON CONFLICT (id) DO UPDATE SET
  slug = EXCLUDED.slug,
  title = EXCLUDED.title,
  meta_title = EXCLUDED.meta_title,
  meta_description = EXCLUDED.meta_description;

-- Seed data for Home page sections
INSERT INTO sections (id, page_id, type, title, "order", visible, content, content_structure) VALUES
(101, 1, 'hero', 'Hero Section', 1, true, '{
    "title": "Crafting Dream Spaces, One Home at a Time",
    "subtitle": "Pune’s leading interior design company for modular kitchens, wardrobes, and full home interiors. Let’s create a space that’s uniquely yours.",
    "buttonText": "Explore Our Services",
    "videoUrl": "/hero-video.mp4",
    "slides": [
        {"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM5MjN8MA&ixlib=rb-4.1.0&q=80&w=1080"},
        {"image": "https://images.unsplash.com/photo-1556702585-528ee78b2d2a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxNXx8bW9kZXJuJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU2MjQyOTJ8MA&ixlib=rb-4.1.0&q=80&w=1080"},
        {"image": "https://images.unsplash.com/photo-1594451950995-134a6758c54a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxsaXZpbmclMjByb29tfGVufDB8fHx8fDE3NTU2MjQzMjN8MA&ixlib=rb-4.1.0&q=80&w=1080"}
    ]
}', '{
    "title": {"type": "text", "label": "Main Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"},
    "videoUrl": {"type": "text", "label": "Background Video URL"},
    "slides": {"type": "repeater", "label": "Image Slides", "fields": {"image": {"type": "image", "label": "Slide Image"}}}
}'),
(102, 1, 'welcome', 'Welcome Section', 2, true, '{
    "image": "https://images.unsplash.com/photo-1588854337236-6889d631f379?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbnRlcmlvciUyMGRlc2lnbiUyMHNrZXRjaHxlbnwwfHx8fDE3NTU4NDY5MTF8MA&ixlib=rb-4.1.0&q=80&w=1080",
    "paragraph1": "We believe that interior design is more than just aesthetics; it’s about creating environments that reflect your personality and enhance your quality of life. At Shriram Interio, we blend innovative design with flawless execution to turn your vision into a reality.",
    "paragraph2": "Our team is dedicated to understanding your needs and aspirations. From the initial concept to the final handover, we ensure a seamless and transparent process, delivering spaces that are not only beautiful but also functional and enduring."
}', '{
    "image": {"type": "image", "label": "Welcome Image"},
    "paragraph1": {"type": "textarea", "label": "First Paragraph"},
    "paragraph2": {"type": "textarea", "label": "Second Paragraph"}
}'),
(103, 1, 'about_company', 'About Company Section', 3, true, '{
    "title": "About Our Company",
    "text": "is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."
}', '{
    "title": {"type": "text", "label": "Title"},
    "text": {"type": "textarea", "label": "Company Description"}
}'),
(104, 1, 'why_us', 'Why Us Section', 4, true, '{
    "title": "Why Shriram Interio?",
    "subtitle": "Discover the difference that passion, expertise, and dedication can make.",
    "items": [
        {"title": "Expert Design Team", "description": "Our team of skilled designers and craftsmen work together to bring your vision to life with precision and creativity."},
        {"title": "Variety of Design Choices", "description": "We offer a wide range of styles, materials, and finishes to suit every taste and budget, ensuring a truly personalized space."},
        {"title": "Affordable Design Fees", "description": "Experience top-tier design solutions without breaking the bank. We believe in transparent pricing and delivering value."},
        {"title": "On-Time Project Delivery", "description": "We respect your time. Our streamlined process ensures your project is completed on schedule, without compromising on quality."}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Reasons", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}
}'),
(105, 1, 'work_gallery', 'Work Gallery Section', 5, true, '{
    "title": "Our Work Gallery",
    "subtitle": "A glimpse into the spaces we have transformed.",
    "items": [
        {"image": "/g1.png", "title": "Elegant Living Area", "hint": "elegant living area"},
        {"image": "/g2.png", "title": "Modern U-Shaped Kitchen", "hint": "modern kitchen"},
        {"image": "/g3.png", "title": "Minimalist Bedroom Design", "hint": "minimalist bedroom"},
        {"image": "/g4.png", "title": "Compact & Functional Study", "hint": "functional study room"},
        {"image": "/g5.png", "title": "Luxury Bathroom Interior", "hint": "luxury bathroom"},
        {"image": "/g6.png", "title": "Chic Wardrobe Solution", "hint": "chic wardrobe"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Gallery Items", "fields": {"image": {"type": "image", "label": "Image"}, "title": {"type": "text", "label": "Title"}, "hint": {"type": "text", "label": "AI Hint"}}}
}'),
(106, 1, 'comfort_design', 'Comfort Design Section', 6, true, '{
    "title": "Design At Your Comfort",
    "subtitle": "We bring the design studio to you, making the process convenient, transparent, and enjoyable.",
    "items": [
        {"title": "Live 3D Designs", "description": "Experience your future home with live 3D designing sessions. See your vision come to life in real-time and make instant decisions."},
        {"title": "Contactless Experience", "description": "From consultation to design finalization, we offer a completely remote and safe process for your convenience."},
        {"title": "Instant Pricing", "description": "Get transparent, itemized quotes for your project instantly. No hidden costs, no surprises."},
        {"title": "Expertise & Passion", "description": "Our team brings years of experience and a deep passion for design to every project, ensuring exceptional results."}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Comfort Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}
}'),
(107, 1, 'what_we_do', 'What We Do Section', 7, true, '{
    "title": "What We Do",
    "subtitle": "We specialize in creating beautiful and functional spaces tailored to your lifestyle.",
    "trendingItems": [
        {"name": "L-Shaped Modular Kitchen", "image": "/t1.png", "hint": "l-shaped kitchen"},
        {"name": "Entertainment Unit", "image": "/t2.png", "hint": "entertainment unit"},
        {"name": "3-Door Wardrobe", "image": "/t3.png", "hint": "wardrobe"},
        {"name": "Queen Size Bed", "image": "/t4.png", "hint": "queen size bed"}
    ],
    "bestSellingKitchens": [
        {"name": "Glossy Maroon", "image": "/k1.png", "hint": "maroon kitchen"},
        {"name": "Dual Tone", "image": "/k2.png", "hint": "dual tone kitchen"},
        {"name": "Matte Grey", "image": "/k3.png", "hint": "matte grey kitchen"},
        {"name": "Wooden Finish", "image": "/k4.png", "hint": "wooden kitchen"}
    ],
    "bestSellingWardrobes": [
        {"name": "Sliding Wardrobe", "image": "/w1.png", "hint": "sliding wardrobe"},
        {"name": "Glossy White", "image": "/w2.png", "hint": "white wardrobe"},
        {"name": "3-Door Hinged", "image": "/w3.png", "hint": "hinged wardrobe"},
        {"name": "Walk-in Style", "image": "/w4.png", "hint": "walk-in wardrobe"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "trendingItems": {"type": "repeater", "label": "Trending Items", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}},
    "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}},
    "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}
}'),
(108, 1, 'testimonials', 'Testimonials Section', 8, true, '{
    "title": "Happy Customers",
    "subtitle": "Don''t just take our word for it. Hear what our clients have to say about their experience with Shriram Interio.",
    "buttonText": "View All Testimonials",
    "items": [
        {"name": "Mr. & Mrs. Kulkarni", "review": "Shriram Interio transformed our cramped kitchen into a spacious and modern culinary haven. The team was professional, and the project was completed on time. We couldn''t be happier!", "image": "/c1.png"},
        {"name": "Sneha Gupta", "review": "The wardrobe they designed for my bedroom is not only beautiful but also incredibly functional. It has completely organized my space. Thank you for the amazing work!", "image": "/c2.png"},
        {"name": "Amit Patel", "review": "We opted for a full home interior package, and the result is breathtaking. Every corner of our home reflects our style, thanks to the talented designers at Shriram Interio.", "image": "/c3.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"},
    "items": {"type": "repeater", "label": "Testimonials", "fields": {"name": {"type": "text", "label": "Client Name"}, "review": {"type": "textarea", "label": "Review Text"}, "image": {"type": "image", "label": "Client Image"}}}
}'),
(109, 1, 'faq', 'FAQ Section', 9, true, '{
    "title": "Frequently Asked Questions",
    "subtitle": "Find answers to common questions about our services and process.",
    "items": [
        {"question": "What is the typical timeline for a project?", "answer": "A typical project timeline ranges from 4 to 8 weeks, depending on the scope and complexity. A standard modular kitchen or wardrobe usually takes about 4 weeks from design finalization to installation."},
        {"question": "Do you provide a warranty?", "answer": "Yes, we provide a one-year warranty on all our workmanship and materials. We also offer support for any post-installation queries or issues."},
        {"question": "Can I see a 3D model of my design?", "answer": "Absolutely! We provide detailed 2D and 3D visualizations of your project. This allows you to see exactly how your space will look and make any changes before manufacturing begins."},
        {"question": "What are the payment terms?", "answer": "We have a flexible payment structure. Typically, we require an advance to start the design process, with subsequent payments linked to project milestones. We will provide a clear payment schedule in our quote."}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "FAQ Items", "fields": {"question": {"type": "text", "label": "Question"}, "answer": {"type": "textarea", "label": "Answer"}}}
}'),
(110, 1, 'partners', 'Partners Section', 10, true, '{
    "title": "Our Trusted Partners",
    "subtitle": "IN PARTNERSHIP WITH",
    "items": [
        {"name": "Hettich", "logoSrc": "/Hettich.png"},
        {"name": "CenturyPly", "logoSrc": "/centuryply.png"},
        {"name": "Greenply", "logoSrc": "/greenply.png"},
        {"name": "Hafele", "logoSrc": "/Hafele.png"},
        {"name": "Merino", "logoSrc": "/Merino.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Partners", "fields": {"name": {"type": "text", "label": "Partner Name"}, "logoSrc": {"type": "image", "label": "Logo Image"}}}
}'),
-- Seed data for About Us page sections
(201, 2, 'hero', 'Hero Section', 1, true, '{
  "title": "About Shriram Interio",
  "subtitle": "Crafting beautiful and functional spaces since 2016.",
  "backgroundImage": "https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbiUyMG9mZmljZXxlbnwwfHx8fDE3NTYzODIwOTV8MA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "text", "label": "Subtitle"},
  "backgroundImage": {"type": "image", "label": "Background Image"}
}'),
(202, 2, 'story', 'Our Story', 2, true, '{
  "heading": "Our Story",
  "subheading": "From a small workshop to Pune’s leading interior design studio.",
  "paragraph1": "Shriram Interio was founded in 2016 with a simple mission: to make high-quality interior design accessible to everyone. What started as a passion project in a small workshop has grown into a full-fledged design studio known for its commitment to quality, innovation, and customer satisfaction.",
  "paragraph2": "Our founder, driven by a vision to blend traditional craftsmanship with modern aesthetics, laid the foundation for a company that values creativity and precision. Over the years, we have honed our skills, expanded our team, and embraced new technologies to stay at the forefront of the industry.",
  "paragraph3": "We have successfully completed hundreds of projects, each one a testament to our dedication and expertise. Our portfolio showcases a diverse range of styles and solutions, from compact urban apartments to spacious family homes.",
  "paragraph4": "Today, Shriram Interio is a name synonymous with trust and excellence in Pune''s interior design landscape. We continue to be inspired by our clients and are passionate about creating spaces that they are proud to call home.",
  "image": "https://images.unsplash.com/photo-1519389950473-47ba0277781c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYzODI3NTh8MA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
  "heading": {"type": "text", "label": "Heading"},
  "subheading": {"type": "text", "label": "Subheading"},
  "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
  "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
  "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
  "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
  "image": {"type": "image", "label": "Image"}
}'),
(203, 2, 'journey', 'Our Journey', 3, true, '{
    "heading": "Our Journey",
    "paragraph1": "The journey of Shriram Interio is one of passion, persistence, and partnership. We started with a small team of dedicated professionals who shared a common goal: to create beautiful, functional, and personalized living spaces.",
    "paragraph2": "Our first few projects taught us the importance of listening to our clients and understanding their unique needs. This client-centric approach has been the cornerstone of our success and has helped us build lasting relationships.",
    "paragraph3": "As we grew, we invested in state-of-the-art technology and a modern manufacturing unit. This allowed us to control the quality of our products and ensure timely delivery, every single time.",
    "paragraph4": "We are proud of the journey we have undertaken and are excited about the future. We remain committed to our core values of quality, integrity, and customer satisfaction, and we look forward to continuing to create dream homes for our clients.",
    "image": "https://images.unsplash.com/photo-1541848215688-a73229562a87?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxkZXNpZ24lMjBtb29kJTIwYm9hcmR8ZW58MHx8fHwxNzU2MzgyODM5fDA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "heading": {"type": "text", "label": "Heading"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
    "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
    "image": {"type": "image", "label": "Image"}
}'),
(204, 2, 'values', 'Our Values', 4, true, '{
  "title": "Our Core Values",
  "subtitle": "The principles that guide everything we do.",
  "items": [
    {"title": "Expert Design Team", "description": "Our strength lies in our team of experienced and passionate design professionals."},
    {"title": "Variety of Design Choices", "description": "We offer a vast selection of materials and finishes to create truly unique interiors."},
    {"title": "Affordable Design Fees", "description": "Quality design should be accessible. We offer transparent and competitive pricing."},
    {"title": "On-Time Project Delivery", "description": "We are committed to delivering your project on schedule, without any compromise on quality."}
  ]
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "text", "label": "Subtitle"},
  "items": {"type": "repeater", "label": "Value Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}
}'),
(205, 2, 'mission_vision', 'Mission and Vision', 5, true, '{
  "visionTitle": "Our Vision",
  "visionText": "To be Pune''s most trusted and innovative interior design company, known for creating spaces that inspire and delight.",
  "missionTitle": "Our Mission",
  "missionText": "To deliver exceptional design solutions and an unparalleled customer experience through creativity, collaboration, and a commitment to quality."
}', '{
  "visionTitle": {"type": "text", "label": "Vision Title"},
  "visionText": {"type": "textarea", "label": "Vision Text"},
  "missionTitle": {"type": "text", "label": "Mission Title"},
  "missionText": {"type": "textarea", "label": "Mission Text"}
}'),
(206, 2, 'team', 'Meet the Team', 6, true, '{
  "title": "Meet the Team",
  "subtitle": "The creative minds behind Shriram Interio.",
  "members": [
    {"name": "Rohan Deshmukh", "role": "Founder & Principal Designer", "bio": "With over 15 years of experience, Rohan leads the creative vision of the company.", "image": "https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxwb3J0cmFpdCUyMG1hbGV8ZW58MHx8fHwxNzU2MzgzMzc3fDA&ixlib=rb-4.1.0&q=80&w=1080"},
    {"name": "Priya Sharma", "role": "Head of Design", "bio": "Priya brings a wealth of experience in material science and spatial planning.", "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMGZlbWFsZXxlbnwwfHx8fDE3NTYzODMzNDN8MA&ixlib=rb-4.1.0&q=80&w=1080"},
    {"name": "Anil Kumar", "role": "Project Manager", "bio": "Anil ensures that every project is executed flawlessly and delivered on time.", "image": "https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxwb3J0cmFpdCUyMG1hbGV8ZW58MHx8fHwxNzU2MzgzMzc3fDA&ixlib=rb-4.1.0&q=80&w=1080"}
  ]
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "text", "label": "Subtitle"},
  "members": {"type": "repeater", "label": "Team Members", "fields": {"name": {"type": "text", "label": "Name"}, "role": {"type": "text", "label": "Role"}, "bio": {"type": "textarea", "label": "Bio"}, "image": {"type": "image", "label": "Image"}}}
}'),
-- Seed data for Customer Stories page sections
(301, 3, 'header', 'Page Header', 1, true, '{
  "title": "Customer Stories",
  "subtitle": "Discover the real stories behind our designs. See how we''ve collaborated with clients to transform their houses into homes they love."
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
(302, 3, 'featured_story', 'Featured Story', 2, true, '{
  "buttonText": "Read Their Story"
}', '{
  "buttonText": {"type": "text", "label": "Button Text"}
}'),
(303, 3, 'more_stories', 'More Stories', 3, true, '{
  "title": "More Inspiring Stories"
}', '{
  "title": {"type": "text", "label": "Section Title"}
}'),
(304, 3, 'work_gallery', 'Work Gallery Section', 4, true, '{
    "title": "Explore Our Work",
    "subtitle": "A showcase of our craftsmanship and design excellence across various projects.",
    "items": [
        {"image": "/g1.png", "title": "Elegant Living Area", "hint": "elegant living area"},
        {"image": "/g2.png", "title": "Modern U-Shaped Kitchen", "hint": "modern kitchen"},
        {"image": "/g3.png", "title": "Minimalist Bedroom Design", "hint": "minimalist bedroom"},
        {"image": "/g4.png", "title": "Compact & Functional Study", "hint": "functional study room"},
        {"image": "/g5.png", "title": "Luxury Bathroom Interior", "hint": "luxury bathroom"},
        {"image": "/g6.png", "title": "Chic Wardrobe Solution", "hint": "chic wardrobe"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Gallery Items", "fields": {"image": {"type": "image", "label": "Image"}, "title": {"type": "text", "label": "Title"}, "hint": {"type": "text", "label": "AI Hint"}}}
}'),
(305, 3, 'partners', 'Partners Section', 5, true, '{
    "title": "Our Trusted Partners",
    "subtitle": "IN PARTNERSHIP WITH",
    "items": [
        {"name": "Hettich", "logoSrc": "/Hettich.png"},
        {"name": "CenturyPly", "logoSrc": "/centuryply.png"},
        {"name": "Greenply", "logoSrc": "/greenply.png"},
        {"name": "Hafele", "logoSrc": "/Hafele.png"},
        {"name": "Merino", "logoSrc": "/Merino.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Partners", "fields": {"name": {"type": "text", "label": "Partner Name"}, "logoSrc": {"type": "image", "label": "Logo Image"}}}
}'),
(306, 3, 'faq', 'FAQ Section', 6, true, '{
    "title": "Frequently Asked Questions",
    "subtitle": "Find answers to common questions about our services and process.",
    "items": [
        {"question": "How do you select stories to feature?", "answer": "We feature stories that showcase a variety of styles, challenges, and solutions. We always seek our clients'' permission before sharing their stories and images."},
        {"question": "Can I submit my own project story?", "answer": "We would love to hear from you! Please get in touch with our team through the contact page to share your experience."},
        {"question": "Are the photos in the stories real projects?", "answer": "Yes, all photos featured in our customer stories are from real projects designed and executed by Shriram Interio."},
        {"question": "How can I get a similar design for my home?", "answer": "If you are inspired by one of our stories, you can book a free consultation with us. Mention the project you liked, and our designers can create a similar concept tailored to your space and needs."}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "textarea", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "FAQ Items", "fields": {"question": {"type": "text", "label": "Question"}, "answer": {"type": "textarea", "label": "Answer"}}}
}'),
-- Seed data for stories table
(307, 4, 'featured_testimonial', 'Featured Testimonial', 1, true, '{
    "image": "https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxzbWlsaW5nJTIwbWFufGVufDB8fHx8MTc1NjM5OTQ0N3ww&ixlib=rb-4.1.0&q=80&w=1080",
    "location": "Baner, Pune",
    "project": "Full Home Interior",
    "size": "3 BHK",
    "quote": "The best part about working with Shriram Interio was their attention to detail.",
    "name": "The Sharma Family",
    "review": "From the initial 3D designs to the final handover, the team''s professionalism and creativity were evident. They took our vague ideas and turned them into a beautiful, cohesive design that feels both luxurious and comfortable. Our home is now our favorite place to be!"
}', '{
    "image": {"type": "image", "label": "Client Image"},
    "location": {"type": "text", "label": "Location"},
    "project": {"type": "text", "label": "Project Type"},
    "size": {"type": "text", "label": "Property Size"},
    "quote": {"type": "textarea", "label": "Quote"},
    "name": {"type": "text", "label": "Client Name"},
    "review": {"type": "textarea", "label": "Full Review"}
}'),
(308, 4, 'video_testimonials', 'Video Testimonials', 2, true, '{
    "title": "Hear From Our Clients",
    "subtitle": "Watch our clients share their experiences with Shriram Interio.",
    "videos": [
        {"name": "Priya & Sameer Joshi", "location": "Kothrud, Pune", "review": "Our modular kitchen is a dream come true! It''s functional, stylish, and the quality is outstanding.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://images.unsplash.com/photo-1512485640342-38a5ea138342?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwY291cGxlfGVufDB8fHx8MTc1NjM5OTU5Nnww&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "smiling couple"},
        {"name": "Vikram Singh", "location": "Wakad, Pune", "review": "The team delivered my project on time and within budget. Their professionalism is commendable.", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFufGVufDB8fHx8fDE3NTYzOTk0NDd8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "smiling man"},
        {"name": "Anjali Deshpande", "location": "Hinjewadi, Pune", "review": "I love the space-saving solutions they provided for my apartment. It feels so much bigger now!", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "imageSrc": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2Mzk5NzA3fDA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "smiling woman"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "videos": {"type": "repeater", "label": "Videos", "fields": {
        "name": {"type": "text", "label": "Client Name"},
        "location": {"type": "text", "label": "Location"},
        "review": {"type": "textarea", "label": "Review Snippet"},
        "videoUrl": {"type": "text", "label": "Video URL"},
        "imageSrc": {"type": "image", "label": "Thumbnail Image"},
        "dataAiHint": {"type": "text", "label": "AI Hint"}
    }}
}'),
(309, 4, 'text_testimonials', 'Text Testimonials', 3, true, '{
    "title": "What Our Clients Say",
    "subtitle": "Read reviews from homeowners who trusted us with their vision.",
    "testimonials": [
        {"name": "Ravi & Sunita Kumar", "review": "The entire process was smooth and transparent. The designers were patient and incorporated all our feedback. Highly recommended!", "image": "https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxwZXJzb24lMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYzOTk5MDV8MA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "RS"},
        {"name": "Neha Agarwal", "review": "I am so impressed with the quality of the materials and the finish. My kitchen looks like it''s straight out of a magazine.", "image": "https://images.unsplash.com/photo-1580489944761-15a19d654956?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxwZXJzb24lMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYzOTk5MDV8MA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "NA"},
        {"name": "Sanjay Menon", "review": "A very professional team that delivers on its promises. They understood our budget constraints and provided excellent solutions without compromising on quality.", "image": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxwZXJzb24lMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYzOTk5MDV8MA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "SM"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "testimonials": {"type": "repeater", "label": "Testimonials", "fields": {
        "name": {"type": "text", "label": "Client Name"},
        "review": {"type": "textarea", "label": "Review Text"},
        "image": {"type": "image", "label": "Client Image"},
        "avatar": {"type": "text", "label": "Avatar Fallback"}
    }}
}'),
-- Seed data for Services page sections
(401, 5, 'header', 'Services Header', 1, true, '{
    "title": "Our Services",
    "subtitle": "Comprehensive design solutions tailored to your needs."
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
(402, 5, 'our_services', 'Our Services', 2, true, '{
    "services": [
        {"title": "Modular Kitchen Design", "description": "Creating efficient, ergonomic, and beautiful kitchens with smart storage and premium finishes."},
        {"title": "Wardrobe & Storage Solutions", "description": "Custom wardrobes and storage units that maximize space and organize your life with style."},
        {"title": "Bedroom Interiors", "description": "Designing serene and personal sanctuaries for rest and rejuvenation."},
        {"title": "Living Area Design", "description": "Crafting inviting and functional living spaces for family, friends, and entertainment."},
        {"title": "Exterior Design Services", "description": "Enhancing curb appeal with thoughtful exterior design solutions."},
        {"title": "Full Home Interiors", "description": "A complete, end-to-end design service for a cohesive and harmonious home."}
    ]
}', '{
    "services": {"type": "repeater", "label": "Service Items", "fields": {
        "title": {"type": "text", "label": "Service Title"},
        "description": {"type": "textarea", "label": "Description"}
    }}
}'),
(403, 5, 'detailed_services', 'Detailed Services', 3, true, '{
    "services": [
        {"title": "Modular Kitchens", "imageSrc": "https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080", "href": "/products/kitchen", "dataAiHint": "modern kitchen"},
        {"title": "Wardrobes", "imageSrc": "https://images.unsplash.com/photo-1614631446501-abcf76949eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080", "href": "/products/wardrobe", "dataAiHint": "modern wardrobe"},
        {"title": "Living Room Design", "imageSrc": "/b2.jpg", "href": "/products/living-room", "dataAiHint": "living room"}
    ]
}', '{
    "services": {"type": "repeater", "label": "Detailed Service Links", "fields": {
        "title": {"type": "text", "label": "Service Title"},
        "imageSrc": {"type": "image", "label": "Image"},
        "href": {"type": "text", "label": "Link URL"},
        "dataAiHint": {"type": "text", "label": "AI Hint"}
    }}
}'),
-- Seed data for Portfolio page sections
(501, 6, 'projects_gallery', 'Projects Gallery', 1, true, '{
    "projects": [
      {"id": 1, "title": "Modern Minimalist Living", "category": "Living Areas", "imageSrc": "/g1.png", "dataAiHint": "minimalist living room"},
      {"id": 2, "title": "Elegant U-Shaped Kitchen", "category": "Kitchens", "imageSrc": "/g2.png", "dataAiHint": "u-shaped kitchen"},
      {"id": 3, "title": "Sleek Sliding Wardrobe", "category": "Wardrobes", "imageSrc": "/w1.png", "dataAiHint": "sliding wardrobe"},
      {"id": 4, "title": "Cozy Scandinavian Bedroom", "category": "Bedrooms", "imageSrc": "/g3.png", "dataAiHint": "scandinavian bedroom"},
      {"id": 5, "title": "Vibrant Blue Kitchen", "category": "Kitchens", "imageSrc": "/k2.png", "dataAiHint": "blue kitchen"},
      {"id": 6, "title": "Walk-in Closet Wonder", "category": "Wardrobes", "imageSrc": "/w4.png", "dataAiHint": "walk-in closet"}
    ]
}', '{
    "projects": {"type": "repeater", "label": "Projects", "fields": {
        "id": {"type": "number", "label": "ID"},
        "title": {"type": "text", "label": "Title"},
        "category": {"type": "text", "label": "Category"},
        "imageSrc": {"type": "image", "label": "Image"},
        "dataAiHint": {"type": "text", "label": "AI Hint"}
    }}
}'),
(502, 6, 'partners', 'Partners Section', 2, true, '{
    "title": "Our Trusted Partners",
    "subtitle": "IN PARTNERSHIP WITH",
    "items": [
        {"name": "Hettich", "logoSrc": "/Hettich.png"},
        {"name": "CenturyPly", "logoSrc": "/centuryply.png"},
        {"name": "Greenply", "logoSrc": "/greenply.png"},
        {"name": "Hafele", "logoSrc": "/Hafele.png"},
        {"name": "Merino", "logoSrc": "/Merino.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Partners", "fields": {"name": {"type": "text", "label": "Partner Name"}, "logoSrc": {"type": "image", "label": "Logo Image"}}}
}'),
-- Placeholder for How It Works page, can be expanded
(601, 7, 'page_content', 'How It Works Content', 1, true, '{}', '{}'),
-- Placeholder for Contact page, can be expanded
(701, 8, 'page_content', 'Contact Page Content', 1, true, '{}', '{}'),
-- Placeholder for Products page, can be expanded
(801, 9, 'page_content', 'Products Page Content', 1, true, '{}', '{}')
ON CONFLICT (id) DO UPDATE SET
  page_id = EXCLUDED.page_id,
  type = EXCLUDED.type,
  title = EXCLUDED.title,
  "order" = EXCLUDED."order",
  visible = EXCLUDED.visible,
  content = EXCLUDED.content,
  content_structure = EXCLUDED.content_structure;
  
INSERT INTO stories (id, slug, title, category, image, "dataAiHint", excerpt, author, "authorAvatar", date, content, "clientImage", location, project, size, quote, gallery) VALUES
(1, 'modern-kitchen-pune', 'A Modern Kitchen Transformation in Pune', 'Kitchens', '/story1.jpg', 'modern kitchen', 'See how we transformed a compact kitchen into a spacious, modern culinary hub for the Sharma family.', 'Priya Sharma', '/c2.png', '15 May 2024',
'<p>The Sharma family came to us with a common challenge: a kitchen that was outdated, cramped, and lacked efficient storage. Their dream was a modern, open space where they could cook together and entertain guests.</p>
<h3>The Challenge</h3>
<p>Our main challenge was to maximize the sense of space within the existing footprint. We needed to introduce more light, create smarter storage solutions, and update the overall aesthetic to match their contemporary tastes.</p>
<h3>Our Solution</h3>
<p>We started by knocking down a non-structural wall to open up the kitchen to the dining area. For the color palette, we chose a combination of high-gloss white laminates for the upper cabinets to reflect light, and a warm wood grain for the lower cabinets to add texture and depth. A sleek quartz countertop and a minimalist backsplash completed the look.</p>
<p>Key features included:</p>
<ul>
  <li>A pull-out pantry for easy access to groceries.</li>
  <li>Deep drawers instead of standard cabinets for pots and pans.</li>
  <li>Under-cabinet LED lighting to brighten up the workspace.</li>
  <li>A compact breakfast bar for quick meals.</li>
</ul>
<h3>The Result</h3>
<p>The result is a stunning, functional kitchen that has become the heart of the Sharma family''s home. It’s a testament to how thoughtful design can completely transform a space, making it not just more beautiful, but also more joyful to live in.</p>',
'https://images.unsplash.com/photo-1512485640342-38a5ea138342?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwY291cGxlfGVufDB8fHx8fDE3NTYzOTk1OTZ8MA&ixlib=rb-4.1.0&q=80&w=1080',
'Koregaon Park, Pune', 'Modular Kitchen', '120 sq. ft.', 'Shriram Interio didn''t just give us a new kitchen; they gave us a new way to live as a family.',
'[
  {"src": "/g2.png", "alt": "The new U-shaped kitchen layout.", "dataAiHint": "u-shaped kitchen"},
  {"src": "/k1.png", "alt": "High-gloss cabinets reflecting light.", "dataAiHint": "glossy cabinets"},
  {"src": "/k3.png", "alt": "Smart storage solutions in action.", "dataAiHint": "kitchen storage"}
]'),
(2, 'wardrobe-revamp-baner', 'Wardrobe Revamp for a Modern Apartment', 'Wardrobes', '/story2.jpg', 'modern wardrobe', 'A sleek and stylish wardrobe solution that maximized storage in a compact bedroom.', 'Anil Kumar', '/c3.png', '22 June 2024',
'<p>This is the story of how we helped a young professional in Baner optimize his bedroom storage with a custom-designed wardrobe.</p>
<h3>The Challenge</h3>
<p>The client needed a wardrobe that could accommodate a growing collection of clothes and accessories, without overwhelming the relatively small bedroom space. The design had to be modern, minimalist, and highly functional.</p>
<h3>Our Solution</h3>
<p>We designed a floor-to-ceiling sliding door wardrobe to make the most of the vertical space. The sliding doors were a key choice to save room, as they don''t require clearance to open. We used a light grey laminate finish to keep the room feeling bright and airy. One of the sliding panels was fitted with a full-length mirror, which not only added functionality but also helped to create an illusion of a larger space.</p>
<p>The internal configuration was completely customized to the client''s needs, with a mix of:</p>
<ul>
  <li>Double hanging rods for shirts and trousers.</li>
  <li>Adjustable shelves for folded clothes and boxes.</li>
  <li>Dedicated drawers for accessories like belts and ties.</li>
  <li>A pull-out shoe rack at the bottom.</li>
</ul>
<h3>The Result</h3>
<p>The new wardrobe is a perfect blend of form and function. It provides ample storage, looks incredibly sleek, and has transformed the usability of the bedroom. The client was thrilled with how we were able to meet all his requirements within the given constraints.</p>',
'https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFufGVufDB8fHx8fDE3NTYzOTk0NDd8MA&ixlib=rb-4.1.0&q=80&w=1080',
'Baner, Pune', 'Sliding Wardrobe', '10 ft. wide', 'I was amazed at how much storage they could create. The design is smart and looks fantastic.',
'[
  {"src": "/w1.png", "alt": "The sleek sliding doors.", "dataAiHint": "sliding wardrobe"},
  {"src": "/w3.png", "alt": "The mirrored panel.", "dataAiHint": "mirrored wardrobe"},
  {"src": "/wardrobe-internals.jpg", "alt": "Customized internal storage.", "dataAiHint": "wardrobe interior"}
]')
ON CONFLICT (id) DO UPDATE SET
  slug = EXCLUDED.slug,
  title = EXCLUDED.title,
  category = EXCLUDED.category,
  image = EXCLUDED.image,
  "dataAiHint" = EXCLUDED."dataAiHint",
  excerpt = EXCLUDED.excerpt,
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