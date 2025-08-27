
-- Create pages table
CREATE TABLE IF NOT EXISTS pages (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    meta_title TEXT,
    meta_description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create sections table
CREATE TABLE IF NOT EXISTS sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER REFERENCES pages(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    type TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    visible BOOLEAN DEFAULT TRUE,
    content JSONB,
    content_structure JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(page_id, type)
);

-- Create stories table
CREATE TABLE IF NOT EXISTS stories (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    category TEXT,
    excerpt TEXT,
    image TEXT,
    "dataAiHint" TEXT,
    author TEXT,
    "authorAvatar" TEXT,
    date TEXT,
    content TEXT,
    "clientImage" TEXT,
    location TEXT,
    project TEXT,
    size TEXT,
    quote TEXT,
    gallery JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Drop existing data to avoid conflicts
TRUNCATE TABLE pages, sections, stories RESTART IDENTITY CASCADE;

-- Seed data for pages
INSERT INTO pages (title, slug, meta_title, meta_description) VALUES
('Home', 'home', 'Shriram Interio | Pune''s Premier Interior Designers', 'Discover bespoke interior design solutions in Pune with Shriram Interio. Specializing in modular kitchens, wardrobes, and full home interiors that blend style and functionality.'),
('About Us', 'about', 'About Shriram Interio | Our Story & Values', 'Learn about Shriram Interio, our journey since 2016, our mission, vision, and the expert team dedicated to creating beautiful living spaces in Pune.'),
('Customer Stories', 'customer-stories', 'Customer Stories | Shriram Interio Projects', 'Read inspiring stories from our clients. See how Shriram Interio transformed their houses into dream homes with our expert interior design services.'),
('Clients', 'clients', 'Our Clients | Shriram Interio Testimonials', 'See what our happy clients have to say. Browse testimonials and see why Shriram Interio is a trusted name in Pune for interior design.'),
('Services', 'services', 'Our Services | Interior Design, Kitchens, Wardrobes', 'Explore the wide range of interior design services offered by Shriram Interio, from modular kitchens and wardrobes to full home interiors and exterior design.'),
('Portfolio', 'portfolio', 'Portfolio | Our Interior Design Work | Shriram Interio', 'Browse our portfolio of completed interior design projects. Get inspired by our work on kitchens, living rooms, bedrooms, and more across Pune.'),
('How It Works', 'how-it-works', 'How It Works | Our Interior Design Process', 'Understand our seamless 6-step interior design process, from initial consultation and 3D visualization to installation and post-project support.'),
('Products', 'products', 'Our Products | Kitchens, Wardrobes, Furniture', 'Discover our range of high-quality products, including modular kitchens, custom wardrobes, and space-saving furniture, all crafted with precision.'),
('Contact', 'contact', 'Contact Us | Shriram Interio | Get in Touch', 'Contact Shriram Interio for a free consultation. Find our address, phone number, and email to start your interior design project in Pune.');

-- Seed data for sections
-- HOME PAGE SECTIONS
INSERT INTO sections (page_id, title, type, "order", content, content_structure) VALUES
((SELECT id FROM pages WHERE slug = 'home'), 'Hero Section', 'hero', 1, 
'{"title": "Transforming Spaces, Creating Dreams", "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Let us craft a space that is uniquely yours.", "buttonText": "Explore Our Services", "videoUrl": "https://videos.pexels.com/video-files/8765248/8765248-hd_1920_1080_25fps.mp4", "slides": [{"image": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"image": "https://images.unsplash.com/photo-1556702571-3e11dd2b1a4a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "videoUrl": {"type": "text", "label": "Video URL"}, "slides": {"type": "repeater", "label": "Image Slides", "fields": {"image": {"type": "image", "label": "Image"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'Welcome Section', 'welcome', 2, 
'{"image": "/welcom.jpg", "paragraph1": "At Shriram Interio, we specialize in turning your interior design dreams into reality. We believe that a well-designed space can significantly enhance your quality of life, and our mission is to deliver interiors that are both beautiful and functional.", "paragraph2": "We offer comprehensive design solutions, from initial concept to final execution, ensuring a seamless and stress-free experience for our clients. Whether you''re looking to redesign a single room or require a complete home makeover, our team of experts is here to guide you every step of the way."}',
'{"image": {"type": "image", "label": "Image"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'About Company Section', 'about_company', 3, 
'{"title": "Pune''s Premier Interior Design Company", "text": "is a name synonymous with trust and excellence in the world of interior design. Since our inception, we have been committed to creating spaces that are not just aesthetically pleasing but also a true reflection of our clients'' personalities and lifestyles."}',
'{"title": {"type": "text", "label": "Title"}, "text": {"type": "textarea", "label": "Text"}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'Why Us Section', 'why_us', 4, 
'{"title": "Why Shriram Interio?", "subtitle": "Your dream home is just a call away.", "items": [{"title": "Expert Design Team", "description": "Our team of skilled designers and craftsmen work together to bring your vision to life with precision and creativity."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of design options, from contemporary to classic, ensuring a personalized touch to every project."}, {"title": "Affordable Design Fees", "description": "Get top-notch design solutions at competitive prices, tailored to fit your budget without compromising on quality."}, {"title": "On-Time Project Delivery", "description": "We value your time. Our streamlined process ensures your project is completed and delivered as per the schedule."}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'Work Gallery Section', 'work_gallery', 5, 
'{"title": "Our Work Gallery", "subtitle": "A Glimpse into Our World of Design", "items": [{"image": "/c1.jpg", "title": "Modern Living Room", "hint": "modern living room"}, {"image": "/c2.jpg", "title": "Elegant Kitchen", "hint": "elegant kitchen"}, {"image": "/c3.jpg", "title": "Cozy Bedroom", "hint": "cozy bedroom"}, {"image": "/c4.jpg", "title": "Stylish Wardrobe", "hint": "stylish wardrobe"}, {"image": "/c5.jpg", "title": "Functional Study", "hint": "functional study"}, {"image": "/c6.jpg", "title": "Chic Crockery Unit", "hint": "chic crockery unit"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"image": {"type": "image", "label": "Image"}, "title": {"type": "text", "label": "Title"}, "hint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'Design at Your Comfort Section', 'comfort_design', 6, 
'{"title": "Design At Your Comfort & Convenience", "subtitle": "Get personalized 2D and 3D interior designs, delivered to you online.", "items": [{"title": "Live 3D Designs", "description": "Experience your dream home in 3D with our live design sessions, all from the comfort of your home."}, {"title": "Contactless Experience", "description": "Our end-to-end online process ensures a safe and convenient way to design your interiors."}, {"title": "Instant Pricing", "description": "Get transparent and instant quotes for your project with no hidden costs."}, {"title": "Expertise & Passion", "description": "Our designers are passionate about creating spaces that are both beautiful and functional."}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'What We Do Section', 'what_we_do', 7, 
'{"title": "What We Do", "subtitle": "From modular kitchens to full home interiors, we do it all.", "trendingItems": [{"name": "Trending Full Home", "image": "/t1.jpg", "hint": "full home interior"}, {"name": "Trending Kitchen", "image": "/t2.jpg", "hint": "modern kitchen"}, {"name": "Trending Wardrobe", "image": "/t3.jpg", "hint": "modern wardrobe"}, {"name": "Trending Living", "image": "/t4.jpg", "hint": "modern living room"}], "bestSellingKitchens": [{"name": "L-Shaped Modular Kitchen", "image": "/bsk1.jpg", "hint": "l-shaped kitchen"}, {"name": "U-Shaped Modular Kitchen", "image": "/bsk2.jpg", "hint": "u-shaped kitchen"}, {"name": "Parallel Modular Kitchen", "image": "/bsk3.jpg", "hint": "parallel kitchen"}, {"name": "Island Modular Kitchen", "image": "/bsk4.jpg", "hint": "island kitchen"}], "bestSellingWardrobes": [{"name": "Sliding Wardrobe", "image": "/bsw1.jpg", "hint": "sliding wardrobe"}, {"name": "Hinged Wardrobe", "image": "/bsw2.jpg", "hint": "hinged wardrobe"}, {"name": "Walk-in Wardrobe", "image": "/bsw3.jpg", "hint": "walk-in closet"}, {"name": "Wardrobe with Dresser", "image": "/bsw4.jpg", "hint": "wardrobe dresser"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "trendingItems": {"type": "repeater", "label": "Trending Items", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}, "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}, "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes", "fields": {"name": {"type": "text", "label": "Name"}, "image": {"type": "image", "label": "Image"}, "hint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'Testimonials Section', 'testimonials', 8, 
'{"title": "What Our Clients Say", "subtitle": "We are committed to making our customers happy.", "buttonText": "View All Testimonials", "items": [{"name": "Rohan & Priya", "review": "Shriram Interio transformed our house into a home. The team was professional, and their attention to detail was exceptional. We couldn''t be happier!", "image": "/client1.jpg"}, {"name": "Sameer & Anjali", "review": "The modular kitchen they designed for us is not only stunning but also incredibly functional. The whole process was smooth and hassle-free.", "image": "/client2.jpg"}, {"name": "Mr. & Mrs. Deshpande", "review": "From the 3D designs to the final installation, everything was perfect. We highly recommend Shriram Interio for their quality and professionalism.", "image": "/client3.jpg"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "buttonText": {"type": "text", "label": "Button Text"}, "items": {"type": "repeater", "label": "Items", "fields": {"name": {"type": "text", "label": "Name"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'FAQ Section', 'faq', 9, 
'{"title": "Frequently Asked Questions", "subtitle": "Have questions? We have answers.", "items": [{"question": "What is the timeline for a typical project?", "answer": "A typical project timeline ranges from 4 to 6 weeks, depending on the scope and complexity of the design. We provide a detailed schedule at the beginning of each project."}, {"question": "Do you offer a warranty?", "answer": "Yes, we offer a comprehensive one-year warranty on all our workmanship and materials. We stand by the quality of our work and are committed to your satisfaction."}, {"question": "Can I see my design in 3D?", "answer": "Absolutely! We provide detailed 3D visualizations of your space, allowing you to see and approve the design before we begin manufacturing. We also offer live 3D sessions for a contactless experience."}, {"question": "What is the cost of interior design?", "answer": "The cost of interior design varies based on the size of the project, materials used, and complexity. We offer a free initial consultation to discuss your needs and provide a transparent, detailed quote with no hidden charges."}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"question": {"type": "text", "label": "Question"}, "answer": {"type": "textarea", "label": "Answer"}}}}'
),
((SELECT id FROM pages WHERE slug = 'home'), 'Partners Section', 'partners', 10, 
'{"title": "Our Trusted Partners", "subtitle": "OUR PARTNERS", "items": [{"name": "Partner 1", "logoSrc": "/p1.png"}, {"name": "Partner 2", "logoSrc": "/p2.png"}, {"name": "Partner 3", "logoSrc": "/p3.png"}, {"name": "Partner 4", "logoSrc": "/p4.png"}, {"name": "Partner 5", "logoSrc": "/p5.png"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Items", "fields": {"name": {"type": "text", "label": "Name"}, "logoSrc": {"type": "image", "label": "Logo Image"}}}}'
),

-- ABOUT US PAGE SECTIONS
((SELECT id FROM pages WHERE slug = 'about'), 'Hero Section', 'hero', 1, 
'{"title": "About Shriram Interio", "subtitle": "Crafting beautiful and functional spaces since 2016.", "backgroundImage": "https://images.unsplash.com/photo-1537724326059-2ea202514d4c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxjb21wYW55JTIwYWJvdXR8ZW58MHx8fHwxNzU2MjY4NjQ4fDA&ixlib=rb-4.1.0&q=80&w=1080"}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "backgroundImage": {"type": "image", "label": "Background Image"}}'
),
((SELECT id FROM pages WHERE slug = 'about'), 'Our Story Section', 'story', 2, 
'{"heading": "Our Story", "subheading": "The journey of a thousand miles begins with a single step.", "paragraph1": "SHRIRAM INTERIO is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project.", "paragraph2": "We started as a small studio with a handful of clients, driven by a passion for creating beautiful and functional environments. Our commitment to quality and customer satisfaction quickly earned us a reputation as a trusted name in Pune''s interior design landscape.", "paragraph3": "Over the years, we''ve evolved, but our commitment to excellence remains unwavering. Today, Shriram Interio is a full-service design firm with a talented team of designers, project managers, and craftsmen, all working together to bring your dream space to life.", "paragraph4": "Our portfolio showcases a diverse range of projects, from cozy residential apartments to sprawling commercial spaces. Each project is a testament to our dedication to creating interiors that are not just aesthetically pleasing but also a true reflection of our clients'' personalities and lifestyles.", "image": "https://images.unsplash.com/photo-1519389950473-47ba0277781c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx0ZWFtJTIwd29ya2luZ3xlbnwwfHx8fDE3NTYyNjg4MjR8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
'{"heading": {"type": "text", "label": "Heading"}, "subheading": {"type": "text", "label": "Subheading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
),
((SELECT id FROM pages WHERE slug = 'about'), 'Our Journey Section', 'journey', 3, 
'{"heading": "Our Journey", "paragraph1": "Our journey has been one of continuous growth and learning. We have embraced new technologies, explored innovative materials, and refined our processes to deliver the best possible results for our clients. From hand-drawn sketches to immersive 3D visualizations, we leverage the power of technology to bring our creative visions to life.", "paragraph2": "We are proud of the relationships we have built with our clients, partners, and suppliers. These collaborations are the foundation of our success and inspire us to push the boundaries of design every day.", "paragraph3": "As we look to the future, we are excited to continue our journey of transforming spaces and creating exceptional experiences. We remain committed to our core values of creativity, integrity, and customer satisfaction, and look forward to partnering with you on your next design adventure.", "paragraph4": "Thank you for being a part of our story. We invite you to explore our portfolio and discover the Shriram Interio difference.", "image": "https://images.unsplash.com/photo-1542744173-05336fcc7ad4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYyNjkwOTd8MA&ixlib=rb-4.1.0&q=80&w=1080"}',
'{"heading": {"type": "text", "label": "Heading"}, "paragraph1": {"type": "textarea", "label": "Paragraph 1"}, "paragraph2": {"type": "textarea", "label": "Paragraph 2"}, "paragraph3": {"type": "textarea", "label": "Paragraph 3"}, "paragraph4": {"type": "textarea", "label": "Paragraph 4"}, "image": {"type": "image", "label": "Image"}}'
),
((SELECT id FROM pages WHERE slug = 'about'), 'Our Values Section', 'values', 4, 
'{"title": "Our Core Values", "subtitle": "The principles that guide everything we do.", "items": [{"title": "Expert Design Team", "description": "Our team of skilled designers and craftsmen work together to bring your vision to life with precision and creativity."}, {"title": "Variety of Design Choices", "description": "We offer a wide range of design options, from contemporary to classic, ensuring a personalized touch to every project."}, {"title": "Affordable Design Fees", "description": "Get top-notch design solutions at competitive prices, tailored to fit your budget without compromising on quality."}, {"title": "On-Time Project Delivery", "description": "We value your time. Our streamlined process ensures your project is completed and delivered as per the schedule."}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Value Items", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM pages WHERE slug = 'about'), 'Mission and Vision Section', 'mission_vision', 5, 
'{"visionTitle": "Our Vision", "visionText": "To be the leading interior design firm in Pune, known for our innovative designs, exceptional quality, and unwavering commitment to customer satisfaction.", "missionTitle": "Our Mission", "missionText": "To create beautiful, functional, and personalized living spaces that inspire and enhance the lives of our clients. We strive to deliver excellence in every project, from concept to completion."}',
'{"visionTitle": {"type": "text", "label": "Vision Title"}, "visionText": {"type": "textarea", "label": "Vision Text"}, "missionTitle": {"type": "text", "label": "Mission Title"}, "missionText": {"type": "textarea", "label": "Mission Text"}}'
),
((SELECT id FROM pages WHERE slug = 'about'), 'Meet the Team Section', 'team', 6, 
'{"title": "Meet the Team", "subtitle": "The creative minds behind our success.", "members": [{"name": "Shriram", "role": "Founder & Lead Designer", "bio": "With over a decade of experience, Shriram leads our team with a passion for creating timeless and innovative designs.", "image": "https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MjY5NzY4fDA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Priya", "role": "Project Manager", "bio": "Priya ensures that every project runs smoothly, from initial concept to final handover, with meticulous attention to detail.", "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYyNjk4MDF8MA&ixlib=rb-4.1.0&q=80&w=1080"}, {"name": "Amit", "role": "Senior Interior Designer", "bio": "Amit specializes in creating functional and aesthetically pleasing spaces, with a keen eye for color and texture.", "image": "https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MjY5NzY4fDA&ixlib=rb-4.1.0&q=80&w=1080"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "members": {"type": "repeater", "label": "Team Members", "fields": {"name": {"type": "text", "label": "Name"}, "role": {"type": "text", "label": "Role"}, "bio": {"type": "textarea", "label": "Bio"}, "image": {"type": "image", "label": "Image"}}}}'
),

-- CUSTOMER STORIES PAGE SECTIONS
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'Header Section', 'header', 1, 
'{"title": "Customer Stories", "subtitle": "Real stories from real clients. See how we''ve transformed their spaces and lives."}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}}'
),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'Featured Story Section', 'featured_story', 2, 
'{"buttonText": "Read Their Story"}',
'{"buttonText": {"type": "text", "label": "Button Text"}}'
),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'More Stories Section', 'more_stories', 3, 
'{"title": "More Success Stories"}',
'{"title": {"type": "text", "label": "Title"}}'
),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'Work Gallery Section', 'work_gallery', 4, 
'{"title": "Our Work Gallery", "subtitle": "A Glimpse into Our World of Design", "items": [{"image": "/c1.jpg", "title": "Modern Living Room", "hint": "modern living room"}, {"image": "/c2.jpg", "title": "Elegant Kitchen", "hint": "elegant kitchen"}, {"image": "/c3.jpg", "title": "Cozy Bedroom", "hint": "cozy bedroom"}, {"image": "/c4.jpg", "title": "Stylish Wardrobe", "hint": "stylish wardrobe"}, {"image": "/c5.jpg", "title": "Functional Study", "hint": "functional study"}, {"image": "/c6.jpg", "title": "Chic Crockery Unit", "hint": "chic crockery unit"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Gallery Items", "fields": {"image": {"type": "image", "label": "Image"}, "title": {"type": "text", "label": "Title"}, "hint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'Partners Section', 'partners', 5, 
'{"title": "Our Trusted Partners", "subtitle": "OUR PARTNERS", "items": [{"name": "Partner 1", "logoSrc": "/p1.png"}, {"name": "Partner 2", "logoSrc": "/p2.png"}, {"name": "Partner 3", "logoSrc": "/p3.png"}, {"name": "Partner 4", "logoSrc": "/p4.png"}, {"name": "Partner 5", "logoSrc": "/p5.png"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Partner Items", "fields": {"name": {"type": "text", "label": "Name"}, "logoSrc": {"type": "image", "label": "Logo Image"}}}}'
),
((SELECT id FROM pages WHERE slug = 'customer-stories'), 'FAQ Section', 'faq', 6, 
'{"title": "Frequently Asked Questions", "subtitle": "Have questions? We have answers.", "items": [{"question": "How do I get featured in a customer story?", "answer": "We love to showcase our beautiful projects! If you''re happy with your transformation and would like to be featured, please reach out to our team. We handle all photography and interviews."}, {"question": "What is the process for a customer story?", "answer": "Once you agree, we schedule a professional photoshoot of your new space. We also conduct a brief interview to capture your thoughts and experience. The entire process is managed by our team to be as seamless as possible for you."}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "items": {"type": "repeater", "label": "FAQ Items", "fields": {"question": {"type": "text", "label": "Question"}, "answer": {"type": "textarea", "label": "Answer"}}}}'
),

-- CLIENTS PAGE SECTIONS
((SELECT id FROM pages WHERE slug = 'clients'), 'Featured Testimonial', 'featured_testimonial', 1, 
'{"name": "Rohan Sharma", "location": "Pune", "project": "Full Home Interior", "size": "3 BHK", "quote": "The entire process, from design to execution, was seamless. The team''s dedication and attention to detail were truly commendable.", "review": "Shriram Interio didn''t just give us a house; they gave us a home. Every corner reflects our personality, and the quality of work is outstanding. We are incredibly grateful for their passion and professionalism. Our friends and family are always in awe when they visit.", "image": "https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYW4lMjBzbWlsaW5nfGVufDB8fHx8MTc1NjM1OTIyNHww&ixlib=rb-4.1.0&q=80&w=1080"}',
'{"name": {"type": "text", "label": "Name"}, "location": {"type": "text", "label": "Location"}, "project": {"type": "text", "label": "Project Type"}, "size": {"type": "text", "label": "Property Size"}, "quote": {"type": "textarea", "label": "Quote"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"}}'
),
((SELECT id FROM pages WHERE slug = 'clients'), 'Video Testimonials', 'video_testimonials', 2, 
'{"title": "Client Stories on Video", "subtitle": "Hear directly from our happy clients about their experience with Shriram Interio.", "videos": [{"name": "Priya & Sameer", "location": "Koregaon Park, Pune", "review": "Our kitchen is now the heart of our home, thanks to Shriram Interio!", "imageSrc": "https://images.unsplash.com/photo-1588704487282-e7c65b5d1b73?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxjb3VwbGUlMjBpbiUyMGtpdGNoZW58ZW58MHx8fHwxNzU2MzU5Njc5fDA&ixlib=rb-4.1.0&q=80&w=1080", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "dataAiHint": "couple in kitchen"}, {"name": "The Joshi Family", "location": "Wakad, Pune", "review": "They understood our family''s needs perfectly. The design is both beautiful and practical.", "imageSrc": "https://images.unsplash.com/photo-1560114928-40f1f1eb26a0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmYW1pbHklMjBpbiUyMGxpdmluZyUyMHJvb218ZW58MHx8fHwxNzU2MzU5NzA5fDA&ixlib=rb-4.1.0&q=80&w=1080", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "dataAiHint": "family living room"}, {"name": "Ankit Deshmukh", "location": "Hinjewadi, Pune", "review": "The team delivered on time and within budget. Highly professional and recommended.", "imageSrc": "https://images.unsplash.com/photo-1615109398623-88346a601842?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYW4lMjBpbiUyMGhvbWV8ZW58MHx8fHwxNzU2MzU5NzMzfDA&ixlib=rb-4.1.0&q=80&w=1080", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ", "dataAiHint": "man at home"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "videos": {"type": "repeater", "label": "Videos", "fields": {"name": {"type": "text", "label": "Name"}, "location": {"type": "text", "label": "Location"}, "review": {"type": "textarea", "label": "Review"}, "imageSrc": {"type": "image", "label": "Thumbnail Image"}, "videoUrl": {"type": "text", "label": "Video URL"}, "dataAiHint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM pages WHERE slug = 'clients'), 'Text Testimonials', 'text_testimonials', 3, 
'{"title": "What Our Clients Say", "subtitle": "We are committed to making our customers happy.", "testimonials": [{"name": "Ananya Reddy", "review": "Working with Shriram Interio was a pleasure. Their designers are creative, and the execution was flawless. My apartment looks amazing!", "image": "https://images.unsplash.com/photo-1580489944761-15a19d654956?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYyNjk4MDF8MA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "AR"}, {"name": "Vikram Singh", "review": "The wardrobe they designed is a masterpiece of form and function. It has completely organized my space. Excellent craftsmanship.", "image": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MjY5NzY4fDA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "VS"}, {"name": "The Mehta Family", "review": "We are thrilled with our new home interiors. The team was patient and incorporated all our ideas beautifully. Thank you, Shriram Interio!", "image": "https://images.unsplash.com/photo-1541534433154-c48834579c16?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmYW1pbHl8ZW58MHx8fHwxNzU2MzYwMTQ3fDA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "MF"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}, "testimonials": {"type": "repeater", "label": "Testimonials", "fields": {"name": {"type": "text", "label": "Name"}, "review": {"type": "textarea", "label": "Review"}, "image": {"type": "image", "label": "Image"}, "avatar": {"type": "text", "label": "Avatar Fallback"}}}}'
),

-- SERVICES PAGE SECTIONS
((SELECT id FROM pages WHERE slug = 'services'), 'Header Section', 'header', 1, 
'{"title": "Our Services", "subtitle": "Comprehensive design solutions tailored to your needs."}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "textarea", "label": "Subtitle"}}'
),
((SELECT id FROM pages WHERE slug = 'services'), 'Our Services Section', 'our_services', 2, 
'{"services": [{"title": "Modular Kitchen Design", "description": "Creating efficient, stylish, and functional kitchens that are the heart of your home."}, {"title": "Wardrobe & Storage Solutions", "description": "Custom-designed wardrobes and storage units to maximize space and organization."}, {"title": "Bedroom Interiors", "description": "Designing serene and personal sanctuaries for rest and relaxation."}, {"title": "Living Area Design", "description": "Crafting inviting and comfortable living spaces for family and guests."}, {"title": "Exterior Design Services", "description": "Enhancing the curb appeal and functionality of your home''s exterior."}, {"title": "Full Home Interiors", "description": "A complete design solution for your entire home, from concept to completion."}]}',
'{"services": {"type": "repeater", "label": "Services List", "fields": {"title": {"type": "text", "label": "Title"}, "description": {"type": "textarea", "label": "Description"}}}}'
),
((SELECT id FROM pages WHERE slug = 'services'), 'Detailed Services Section', 'detailed_services', 3, 
'{"services": [{"title": "Modular Kitchens", "href": "/products/kitchen", "imageSrc": "https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "modern kitchen"}, {"title": "Custom Wardrobes", "href": "/products/wardrobe", "imageSrc": "https://images.unsplash.com/photo-1614631446501-abcf76949eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "modern wardrobe"}, {"title": "Full Home Interiors", "href": "/services", "imageSrc": "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxsaXZpbmclMjByb29tfGVufDB8fHx8MTc1NjM2MDY5NHww&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "living room"}]}',
'{"services": {"type": "repeater", "label": "Detailed Services", "fields": {"title": {"type": "text", "label": "Title"}, "href": {"type": "text", "label": "Link URL"}, "imageSrc": {"type": "image", "label": "Image"}, "dataAiHint": {"type": "text", "label": "AI Hint"}}}}'
),

-- PORTFOLIO PAGE SECTIONS
((SELECT id FROM pages WHERE slug = 'portfolio'), 'Projects Gallery Section', 'projects_gallery', 1, 
'{"projects": [{"id": 1, "title": "Contemporary Living Space", "category": "Living Room", "imageSrc": "/portfolio1.jpg", "dataAiHint": "living room"}, {"id": 2, "title": "L-Shaped Modular Kitchen", "category": "Kitchen", "imageSrc": "/portfolio2.jpg", "dataAiHint": "l-shaped kitchen"}, {"id": 3, "title": "Minimalist Bedroom Design", "category": "Bedroom", "imageSrc": "/portfolio3.jpg", "dataAiHint": "minimalist bedroom"}, {"id": 4, "title": "Walk-In Wardrobe", "category": "Wardrobe", "imageSrc": "/portfolio4.jpg", "dataAiHint": "walk-in closet"}, {"id": 5, "Ergonomic Home Office", "category": "Home Office", "imageSrc": "/portfolio5.jpg", "dataAiHint": "home office"}, {"id": 6, "U-Shaped Modern Kitchen", "category": "Kitchen", "imageSrc": "/portfolio6.jpg", "dataAiHint": "u-shaped kitchen"}]}',
'{"projects": {"type": "repeater", "label": "Projects", "fields": {"id": {"type": "number", "label": "ID"}, "title": {"type": "text", "label": "Title"}, "category": {"type": "text", "label": "Category"}, "imageSrc": {"type": "image", "label": "Image"}, "dataAiHint": {"type": "text", "label": "AI Hint"}}}}'
),
((SELECT id FROM pages WHERE slug = 'portfolio'), 'Partners Section', 'partners', 2, 
'{"title": "Our Trusted Partners", "subtitle": "OUR PARTNERS", "items": [{"name": "Partner 1", "logoSrc": "/p1.png"}, {"name": "Partner 2", "logoSrc": "/p2.png"}, {"name": "Partner 3", "logoSrc": "/p3.png"}, {"name": "Partner 4", "logoSrc": "/p4.png"}, {"name": "Partner 5", "logoSrc": "/p5.png"}]}',
'{"title": {"type": "text", "label": "Title"}, "subtitle": {"type": "text", "label": "Subtitle"}, "items": {"type": "repeater", "label": "Partners", "fields": {"name": {"type": "text", "label": "Name"}, "logoSrc": {"type": "image", "label": "Logo Image"}}}}'
);

-- Seed data for stories table
INSERT INTO stories (title, slug, category, excerpt, image, "dataAiHint", author, "authorAvatar", date, content, "clientImage", location, project, size, quote, gallery) VALUES
(
    'A Pune Apartment Gets a Modern Makeover',
    'pune-apartment-makeover',
    'Full Home Interior',
    'See how we transformed a standard 2BHK apartment in Pune into a modern, functional, and stylish living space for the Sharma family.',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBhcGFydG1lbnQlMjBpbnRlcmlvcnxlbnwwfHx8fDE3NTYyODI0ODJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
    'modern apartment',
    'The Sharma Family',
    'https://images.unsplash.com/photo-1541534433154-c48834579c16?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmYW1pbHl8ZW58MHx8fHwxNzU2MzYwMTQ3fDA&ixlib=rb-4.1.0&q=80&w=1080',
    'August 15, 2024',
    '<p>The Sharma family approached us with a common challenge: their 2BHK apartment felt cramped and outdated. They wanted a home that was modern, airy, and reflected their vibrant personalities, all while maximizing storage and functionality. Our team took on the challenge with enthusiasm, focusing on a clean, minimalist aesthetic with clever space-saving solutions.</p><p>We started with an open-plan living and dining area, using a neutral color palette with pops of color to create a sense of spaciousness. The modular kitchen was designed with high-gloss laminates and smart storage to keep it clutter-free. In the bedrooms, custom wardrobes with sliding doors were installed to save space without compromising on storage. The result is a home that is not only beautiful but also perfectly tailored to the family''s lifestyle.</p>',
    'https://images.unsplash.com/photo-1541534433154-c48834579c16?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmYW1pbHl8ZW58MHx8fHwxNzU2MzYwMTQ3fDA&ixlib=rb-4.1.0&q=80&w=1080',
    'Baner, Pune',
    'Full Home Interior',
    '2 BHK',
    'Shriram Interio didn''t just design our home; they understood our dream. The transformation is beyond what we imagined!',
    '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'
),
(
    'The Perfect Modular Kitchen for a Culinary Enthusiast',
    'perfect-modular-kitchen',
    'Modular Kitchen',
    'Mr. Kulkarni, a passionate home chef, wanted a kitchen that was as efficient as a professional setup but with the warmth of a home. Here''s how we did it.',
    'https://images.unsplash.com/photo-1600585152220-04b503c85d69?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2R1bGFyJTIwa2l0Y2hlbiUyMGRlc2lnbnxlbnwwfHx8fDE3NTYyODI3NTd8MA&ixlib=rb-4.1.0&q=80&w=1080',
    'modular kitchen',
    'Mr. Kulkarni',
    'https://images.unsplash.com/photo-1615109398623-88346a601842?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYW4lMjBpbiUyMGhvbWV8ZW58MHx8fHwxNzU2MzU5NzMzfDA&ixlib=rb-4.1.0&q=80&w=1080',
    'July 28, 2024',
    '<p>For Mr. Kulkarni, cooking is more than a chore; it''s an art form. He needed a kitchen that could keep up with his culinary adventures. The old kitchen was inefficient and lacked adequate counter space and storage. Our goal was to create a "golden triangle" layout for maximum efficiency, with ample storage and durable surfaces.</p><p>We designed a U-shaped kitchen with granite countertops, a double sink, and dedicated zones for prepping, cooking, and cleaning. We incorporated pull-out pantry units, spice racks, and deep drawers to keep everything organized and accessible. The result is a chef''s paradise that is both highly functional and beautifully integrated with the rest of the home.</p>',
    'https://images.unsplash.com/photo-1615109398623-88346a601842?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYW4lMjBpbiUyMGhvbWV8ZW58MHx8fHwxNzU2MzU5NzMzfDA&ixlib=rb-4.1.0&q=80&w=1080',
    'Kothrud, Pune',
    'Modular Kitchen',
    '3 BHK',
    'My new kitchen is a dream come true. It''s a joy to cook in, and everything is exactly where I need it to be. The team was fantastic.',
    '[{"src": "/kitchen-gallery1.jpg", "alt": "Wide shot of the kitchen", "dataAiHint": "u-shaped kitchen"}, {"src": "/kitchen-gallery2.jpg", "alt": "Kitchen storage solutions", "dataAiHint": "kitchen storage"}, {"src": "/kitchen-gallery3.jpg", "alt": "Countertop detail", "dataAiHint": "quartz countertop"}]'
);
