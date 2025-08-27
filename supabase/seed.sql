-- Seed data for pages
INSERT INTO "pages" (title, slug, meta_title, meta_description) VALUES
('Home', 'home', 'Shriram Interio - Top Interior Designers in Pune', 'Shriram Interio offers innovative and bespoke interior design solutions in Pune. Specializing in modular kitchens, wardrobes, and full home interiors for modern living.'),
('About Us', 'about', 'About Shriram Interio | Our Story, Mission, and Values', 'Learn about Shriram Interio, Pune''s leading interior design company. Discover our journey, our expert team, and our commitment to creating beautiful, functional spaces.'),
('Customer Stories', 'customer-stories', 'Customer Success Stories | Shriram Interio Projects', 'Read inspiring stories from our happy clients. See how we transformed their houses into dream homes with our expert interior design services.'),
('Clients', 'clients', 'Our Valued Clients & Testimonials | Shriram Interio', 'Hear directly from our clients. Read their reviews and testimonials about their experience with Shriram Interio''s design services and project execution.'),
('Services', 'services', 'Interior Design Services in Pune | Shriram Interio', 'Explore our comprehensive interior design services, including modular kitchens, wardrobe solutions, full home interiors, and more. Your vision, our expertise.'),
('Portfolio', 'portfolio', 'Our Interior Design Portfolio | Shriram Interio Projects', 'Browse our portfolio of stunning interior design projects in Pune. Get inspired by our work on kitchens, living areas, bedrooms, and more.'),
('How It Works', 'how-it-works', 'Our Design Process | From Concept to Completion | Shriram Interio', 'Understand our seamless 6-step interior design process. From initial consultation to final handover, we ensure a transparent and hassle-free experience.'),
('Contact', 'contact', 'Contact Shriram Interio | Get in Touch for a Consultation', 'Contact us for a free interior design consultation in Pune. Find our address, phone number, and email to start your home transformation journey.'),
('Products', 'products', 'Our Interior Design Products | Kitchens, Wardrobes & More', 'Discover our range of high-quality products, including modular kitchens, custom wardrobes, space-saving furniture, and more for your home interior needs.');

-- Helper function to get page_id
CREATE OR REPLACE FUNCTION get_page_id(page_slug TEXT)
RETURNS INT AS $$
DECLARE
    p_id INT;
BEGIN
    SELECT id INTO p_id FROM pages WHERE slug = page_slug;
    RETURN p_id;
END;
$$ LANGUAGE plpgsql;

-- Seed data for sections
INSERT INTO "sections" (page_id, "order", type, title, visible, content, content_structure) VALUES
-- Home Page Sections
(get_page_id('home'), 1, 'hero', 'Hero Section', true, '{
    "videoUrl": "https://www.shriraminterio.com/wp-content/uploads/2024/05/2-1.mp4",
    "title": "Crafting Your Dream Space, One Detail at a Time",
    "subtitle": "Discover Pune''s leading interior design expertise for modular kitchens, wardrobes, and full home interiors that reflect your style and elevate your living.",
    "buttonText": "Explore Our Services",
    "slides": [
        {"image": "/h1.png"},
        {"image": "/h3.png"},
        {"image": "/h4.png"}
    ]
}', '{
    "videoUrl": {"type": "text", "label": "Background Video URL"},
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"},
    "slides": {"type": "repeater", "label": "Image Slides"}
}'),
(get_page_id('home'), 2, 'welcome', 'Welcome Section', true, '{
    "image": "/w1.png",
    "paragraph1": "Welcome to Shriram Interio, your trusted partner in creating beautiful and functional living spaces. Based in Pune, we are a team of passionate designers and skilled craftsmen dedicated to turning your interior dreams into reality.",
    "paragraph2": "Whether you''re looking for a state-of-the-art modular kitchen, a custom-designed wardrobe, or a complete home interior makeover, we have the expertise and creativity to deliver exceptional results that exceed your expectations."
}', '{
    "image": {"type": "image", "label": "Welcome Image"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"}
}'),
(get_page_id('home'), 3, 'about_company', 'About Company Section', true, '{
    "title": "ABOUT COMPANY",
    "text": "is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering."
}', '{
    "title": {"type": "text", "label": "Section Title"},
    "text": {"type": "textarea", "label": "Company Description"}
}'),
(get_page_id('home'), 4, 'why_us', 'Why Us Section', true, '{
    "title": "Why Shriram Interio?",
    "subtitle": "Your dream home is our commitment. Here’s why we are the right choice for you.",
    "items": [
        { "title": "Expert Design Team", "description": "Our team of experienced designers works with you to bring your vision to life, ensuring every detail is perfect."},
        { "title": "Variety of Design Choices", "description": "We offer a wide range of designs, materials, and finishes to suit every taste and budget."},
        { "title": "Affordable Design Fees", "description": "Get professional interior design services at competitive prices, without compromising on quality."},
        { "title": "On-Time Project Delivery", "description": "We value your time. Our streamlined process ensures your project is completed on schedule."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Why Us Items"}
}'),
(get_page_id('home'), 5, 'work_gallery', 'Work Gallery', true, '{
    "title": "Our Work Gallery",
    "subtitle": "A Glimpse into Our World of Design",
    "items": [
        {"image": "/g1.png", "title": "Modern Living Room", "hint": "modern living room"},
        {"image": "/g2.png", "title": "Elegant Kitchen", "hint": "elegant kitchen"},
        {"image": "/g3.png", "title": "Cozy Bedroom", "hint": "cozy bedroom"},
        {"image": "/g4.png", "title": "Stylish Wardrobe", "hint": "stylish wardrobe"},
        {"image": "/g5.png", "title": "Functional Office Space", "hint": "office space"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Gallery Items"}
}'),
(get_page_id('home'), 6, 'comfort_design', 'Comfort Design Section', true, '{
    "title": "Design at Your Comfort",
    "subtitle": "Experience a seamless and personalized design journey from the comfort of your home.",
    "items": [
        { "title": "Live 3D Designs", "description": "Visualize your dream home with our live 3D designing sessions."},
        { "title": "Contactless Experience", "description": "From design to delivery, enjoy a completely contactless process."},
        { "title": "Instant Pricing", "description": "Get transparent and instant pricing for your project with no hidden costs."},
        { "title": "Expertise & Passion", "description": "Our team of experts is passionate about creating spaces you''ll love."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Comfort Design Items"}
}'),
(get_page_id('home'), 7, 'what_we_do', 'What We Do Section', true, '{
    "title": "What We Do",
    "subtitle": "Explore our best-selling designs and trending interior solutions.",
    "trendingItems": [
        {"name": "L-Shaped Modular Kitchen", "image": "/t1.png", "hint": "l-shaped kitchen"},
        {"name": "Sliding Wardrobe", "image": "/t2.png", "hint": "sliding wardrobe"},
        {"name": "Entertainment Unit", "image": "/t3.png", "hint": "entertainment unit"},
        {"name": "Study Unit", "image": "/t4.png", "hint": "study unit"}
    ],
    "bestSellingKitchens": [
        {"name": "U-Shaped Modular Kitchen", "image": "/k1.png", "hint": "u-shaped kitchen"},
        {"name": "Parallel Kitchen", "image": "/k2.png", "hint": "parallel kitchen"},
        {"name": "Island Kitchen", "image": "/k3.png", "hint": "island kitchen"},
        {"name": "Straight Kitchen", "image": "/k4.png", "hint": "straight kitchen"}
    ],
    "bestSellingWardrobes": [
        {"name": "Hinged Wardrobe", "image": "/w1.png", "hint": "hinged wardrobe"},
        {"name": "Walk-in Wardrobe", "image": "/w2.png", "hint": "walk-in wardrobe"},
        {"name": "Free Standing Wardrobe", "image": "/w3.png", "hint": "freestanding wardrobe"},
        {"name": "Sliding Wardrobe", "image": "/t2.png", "hint": "sliding wardrobe"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "trendingItems": {"type": "repeater", "label": "Trending Items"},
    "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens"},
    "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes"}
}'),
(get_page_id('home'), 8, 'testimonials', 'Testimonials Section', true, '{
    "title": "Happy Clients, Happy Homes",
    "subtitle": "See what our clients have to say about their experience with Shriram Interio.",
    "buttonText": "View All Testimonials",
    "items": [
        { "name": "Rohan Sharma", "review": "Shriram Interio transformed our home! The attention to detail and creative solutions were outstanding. We couldn''t be happier.", "image": "/c1.png" },
        { "name": "Priya Mehta", "review": "The modular kitchen they designed for us is both beautiful and incredibly functional. The entire process was smooth and professional.", "image": "/c2.png" },
        { "name": "Amit Singh", "review": "An amazing team that listens to your needs and delivers beyond expectations. Our living room is now our favorite space.", "image": "/c3.png" }
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"},
    "items": {"type": "repeater", "label": "Testimonials"}
}'),
(get_page_id('home'), 9, 'faq', 'FAQ Section', true, '{
    "title": "Frequently Asked Questions",
    "subtitle": "Have questions? We’ve got answers.",
    "items": [
        { "question": "What is the timeline for a typical project?", "answer": "A typical project timeline can range from 4 to 8 weeks, depending on the scope and complexity. We provide a detailed schedule at the beginning of each project."},
        { "question": "Do you offer a warranty on your work?", "answer": "Yes, we offer a comprehensive warranty on all our products and workmanship. The duration and terms vary by product, and we provide all details upfront."},
        { "question": "Can I see the design before you start the work?", "answer": "Absolutely! We provide detailed 2D and 3D designs for your approval before we begin any manufacturing or installation. This ensures you are completely satisfied with the plan."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "FAQ Items"}
}'),
(get_page_id('home'), 10, 'partners', 'Partners Section', true, '{
    "title": "Our Trusted Partners",
    "subtitle": "Brands We Work With",
    "items": [
        {"name": "Hettich", "logoSrc": "/p1.png"},
        {"name": "Greenply", "logoSrc": "/p2.png"},
        {"name": "Bosch", "logoSrc": "/p3.png"},
        {"name": "Siemens", "logoSrc": "/p4.png"},
        {"name": "Kaff", "logoSrc": "/p5.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Partner Logos"}
}'),
-- About Us Page Sections
(get_page_id('about'), 1, 'hero', 'Hero', true, '{
  "title": "About Shriram Interio",
  "subtitle": "Pioneering interior design with passion and precision since 2016.",
  "backgroundImage": "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbiUyMGJhY2tncm91bmR8ZW58MHx8fHwxNzU2MDk5MzA5fDA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "textarea", "label": "Subtitle"},
  "backgroundImage": {"type": "image", "label": "Background Image"}
}'),
(get_page_id('about'), 2, 'story', 'Our Story', true, '{
  "heading": "Our Story",
  "subheading": "From a shared vision to a leading design studio.",
  "paragraph1": "SHRIRAM INTERIO began in 2016 with a simple yet powerful idea: to transform living spaces and enrich lives through exceptional design. Our founders, a team of passionate designers and engineers, saw an opportunity to bring together creativity, innovation, and craftsmanship under one roof.",
  "paragraph2": "What started as a small studio in Pune has grown into a renowned interior design firm, known for our personalized approach and commitment to quality. We''ve had the privilege of working on hundreds of projects, each one a unique journey of collaboration and creation.",
  "paragraph3": "Our philosophy is centered around you, our client. We believe in listening intently to your needs, understanding your lifestyle, and translating your vision into a tangible, beautiful reality. It''s this client-centric approach that has been the cornerstone of our success.",
  "paragraph4": "Today, we continue to push the boundaries of design, exploring new materials, technologies, and ideas to create spaces that are not only aesthetically stunning but also deeply personal and functional.",
  "image": "https://images.unsplash.com/photo-1549638321-797e16a2b851?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxkZXNpZ24lMjB0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYwOTkzOTF8MA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
  "heading": {"type": "text", "label": "Heading"},
  "subheading": {"type": "text", "label": "Subheading"},
  "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
  "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
  "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
  "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
  "image": {"type": "image", "label": "Story Image"}
}'),
(get_page_id('about'), 3, 'journey', 'Our Journey', true, '{
    "heading": "Our Journey",
    "paragraph1": "Our journey has been one of continuous learning and growth. We started with a focus on modular kitchens and wardrobes, mastering the art of space optimization and functionality. As our reputation grew, so did our portfolio.",
    "paragraph2": "We expanded our services to include full home interiors, taking on complex projects that challenged our creativity and honed our skills. We embraced new technologies, like 3D visualization, to provide our clients with an immersive and transparent design experience.",
    "paragraph3": "Each project has been a milestone, each challenge an opportunity. From cozy apartments to luxurious villas, we have left our mark of quality and innovation across Pune. Our journey is a testament to our passion for design and our dedication to our clients.",
    "paragraph4": "We are proud of how far we''ve come, but we are even more excited about the future. We are constantly exploring new trends and techniques to ensure we remain at the forefront of the interior design industry.",
    "image": "https://images.unsplash.com/photo-1517048676732-d65bc937f952?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbiUyMHdvcmtzaG9wfGVufDB8fHx8MTc1NjA5OTU3Nnww&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "heading": {"type": "text", "label": "Heading"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
    "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
    "image": {"type": "image", "label": "Journey Image"}
}'),
(get_page_id('about'), 4, 'values', 'Our Values', true, '{
  "title": "What We Stand For",
  "subtitle": "Our core values guide every decision we make and every space we create.",
  "items": [
    { "title": "Expert Design Team", "description": "Our team of experienced designers works with you to bring your vision to life, ensuring every detail is perfect."},
    { "title": "Variety of Design Choices", "description": "We offer a wide range of designs, materials, and finishes to suit every taste and budget."},
    { "title": "Affordable Design Fees", "description": "Get professional interior design services at competitive prices, without compromising on quality."},
    { "title": "On-Time Project Delivery", "description": "We value your time. Our streamlined process ensures your project is completed on schedule."}
  ]
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "textarea", "label": "Subtitle"},
  "items": {"type": "repeater", "label": "Value Items"}
}'),
(get_page_id('about'), 5, 'mission_vision', 'Mission and Vision', true, '{
  "visionTitle": "Our Vision",
  "visionText": "To be Pune''s most trusted and innovative interior design firm, transforming spaces and enriching lives through creativity, functionality, and exceptional service.",
  "missionTitle": "Our Mission",
  "missionText": "To deliver personalized and high-quality interior design solutions that exceed client expectations, while maintaining transparency, integrity, and a commitment to on-time delivery."
}', '{
  "visionTitle": {"type": "text", "label": "Vision Title"},
  "visionText": {"type": "textarea", "label": "Vision Text"},
  "missionTitle": {"type": "text", "label": "Mission Title"},
  "missionText": {"type": "textarea", "label": "Mission Text"}
}'),
(get_page_id('about'), 6, 'team', 'Meet the Team', true, '{
  "title": "Meet Our Creative Minds",
  "subtitle": "The passionate and talented individuals behind our successful designs.",
  "members": [
    { "name": "Ramesh Kumar", "role": "Founder & Lead Designer", "bio": "With over 15 years of experience, Ramesh is the creative force behind Shriram Interio. His passion for design is matched only by his commitment to client satisfaction.", "image": "https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MTAwMTMxfDA&ixlib=rb-4.1.0&q=80&w=1080" },
    { "name": "Sunita Sharma", "role": "Head of Operations", "bio": "Sunita ensures that every project runs smoothly from start to finish. Her meticulous planning and coordination are key to our on-time delivery promise.", "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYxMDAxODV8MA&ixlib=rb-4.1.0&q=80&w=1080" },
    { "name": "Anil Desai", "role": "Senior Interior Designer", "bio": "Anil specializes in creating functional and aesthetically pleasing kitchens and living spaces. His innovative designs have won several accolades.", "image": "https://images.unsplash.com/photo-1615109398623-88346a601842?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxpbmRpYW4lMjBtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MTAwMTMxfDA&ixlib=rb-4.1.0&q=80&w=1080" }
  ]
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "textarea", "label": "Subtitle"},
  "members": {"type": "repeater", "label": "Team Members"}
}'),
-- Customer Stories Page Sections
(get_page_id('customer-stories'), 1, 'header', 'Header', true, '{
    "title": "Our Customer Stories",
    "subtitle": "Discover the real stories behind our designs. See how we''ve collaborated with clients to turn their houses into homes they love."
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
(get_page_id('customer-stories'), 2, 'featured_story', 'Featured Story', true, '{
    "buttonText": "Read The Full Story"
}', '{
    "buttonText": {"type": "text", "label": "Button Text"}
}'),
(get_page_id('customer-stories'), 3, 'more_stories', 'More Stories', true, '{
    "title": "More Inspiring Journeys"
}', '{
    "title": {"type": "text", "label": "Title"}
}'),
(get_page_id('customer-stories'), 4, 'work_gallery', 'Work Gallery', false, '{
    "title": "Our Work Gallery",
    "subtitle": "A Glimpse into Our World of Design",
    "items": []
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Gallery Items"}
}'),
(get_page_id('customer-stories'), 5, 'partners', 'Partners', false, '{
    "title": "Our Trusted Partners",
    "subtitle": "Brands We Work With",
    "items": []
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Partner Logos"}
}'),
(get_page_id('customer-stories'), 6, 'faq', 'FAQ', true, '{
    "title": "Frequently Asked Questions",
    "subtitle": "Find answers to common questions about our process and services.",
    "items": [
        { "question": "How do you select stories to feature?", "answer": "We feature stories that showcase a variety of styles, challenges, and solutions to inspire a wide range of clients. We always get our clients'' permission before sharing their story."},
        { "question": "Can my project be featured as a customer story?", "answer": "We''d love to hear from you! If you''re proud of your home transformation and would like to share your experience, please get in touch with our marketing team."},
        { "question": "What information is included in a customer story?", "answer": "Our stories typically include the client''s initial vision, the design challenges, our proposed solutions, and the final outcome, complete with beautiful photos and testimonials."}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "FAQ Items"}
}'),
-- Clients Page Sections
(get_page_id('clients'), 1, 'featured_testimonial', 'Featured Testimonial', true, '{
    "name": "Rohan Sharma",
    "location": "Pune",
    "project": "Full Home Interior",
    "size": "3 BHK",
    "quote": "The best decision we made for our new home!",
    "review": "The team at Shriram Interio is exceptional. From the initial 3D designs to the final handover, the process was seamless. They understood our vision perfectly and delivered a home that is both beautiful and functional. Their professionalism and attention to detail are commendable. We are thrilled with the outcome and would highly recommend them to anyone looking for top-notch interior designers.",
    "image": "https://images.unsplash.com/photo-1599566150163-29194dcaad36?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxwZXJzb24lMjBzbWlsaW5nfGVufDB8fHx8MTc1NjEwMDU0Nnww&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "name": {"type": "text", "label": "Client Name"},
    "location": {"type": "text", "label": "Location"},
    "project": {"type": "text", "label": "Project Type"},
    "size": {"type": "text", "label": "Property Size"},
    "quote": {"type": "textarea", "label": "Highlight Quote"},
    "review": {"type": "textarea", "label": "Full Review"},
    "image": {"type": "image", "label": "Client Image"}
}'),
(get_page_id('clients'), 2, 'video_testimonials', 'Video Testimonials', true, '{
    "title": "Hear From Our Clients",
    "subtitle": "Watch our clients share their experience with Shriram Interio.",
    "videos": [
        { "name": "The Mehta Family", "location": "Koregaon Park, Pune", "review": "Our kitchen is now the heart of our home, thanks to Shriram Interio.", "imageSrc": "https://images.unsplash.com/photo-1556742212-5b321f3c261b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBmYW1pbHklMjBpbiUyMGtpdGNoZW58ZW58MHx8fHwxNzU2MTAwNjg1fDA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "happy family kitchen", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ" },
        { "name": "Mr. Singh", "location": "Hinjewadi, Pune", "review": "They designed the perfect home office for my needs. Professional and efficient.", "imageSrc": "https://images.unsplash.com/photo-1554224155-6726b3ff858f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBtYW4lMjBpbiUyMGhvbWUlMjBvZmZpY2V8ZW58MHx8fHwxNzU2MTAwNzMyfDA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "man home office", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ" },
        { "name": "The Joshi Couple", "location": "Baner, Pune", "review": "From start to finish, the experience was wonderful. Our bedroom is a dream come true.", "imageSrc": "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjBjb3VwbGUlMjBpbiUyMGJhdGhyb29tfGVufDB8fHx8MTc1NjEwMDc4OHww&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "couple modern bedroom", "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "videos": {"type": "repeater", "label": "Video Testimonials"}
}'),
(get_page_id('clients'), 3, 'text_testimonials', 'Text Testimonials', true, '{
    "title": "What Our Clients Say",
    "subtitle": "Don''t just take our word for it. Here is some more feedback from our clients.",
    "testimonials": [
        { "name": "Aarav Patel", "review": "Professional, creative, and budget-friendly. Shriram Interio ticked all the boxes for our renovation project. Highly recommended!", "image": "https://images.unsplash.com/photo-1610216705422-caa3fcb6d158?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjBtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MTAwMTMxfDA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "AP" },
        { "name": "Ishani Gupta", "review": "I was impressed with their 3D visualization service. It helped me see exactly how my wardrobe would look. The final product was even better!", "image": "https://images.unsplash.com/photo-1619405398226-9f688a87932c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHxpbmRpYW4lMjBmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYxMDAxODV8MA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "IG" },
        { "name": "Vikram Rathore", "review": "The quality of materials and the finishing is top-notch. They delivered the project on time, as promised. A very reliable team.", "image": "https://images.unsplash.com/photo-1594744806529-99612ba5d5a7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw3fHxpbmRpYW4lMjBtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MTAwMTMxfDA&ixlib=rb-4.1.0&q=80&w=1080", "avatar": "VR" }
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "testimonials": {"type": "repeater", "label": "Text Testimonials"}
}'),
-- Services Page Sections
(get_page_id('services'), 1, 'header', 'Header', true, '{
  "title": "Our Services",
  "subtitle": "Comprehensive interior design solutions tailored to your needs."
}', '{
  "title": {"type": "text", "label": "Title"},
  "subtitle": {"type": "textarea", "label": "Subtitle"}
}'),
(get_page_id('services'), 2, 'our_services', 'Our Services', true, '{
  "services": [
    { "title": "Modular Kitchen Design", "description": "Creating efficient, stylish, and durable kitchens that are the heart of your home."},
    { "title": "Wardrobe & Storage Solutions", "description": "Custom wardrobes and storage units that maximize space and organize your life."},
    { "title": "Bedroom Interiors", "description": "Designing serene and personal sanctuaries for rest and relaxation."},
    { "title": "Living Area Design", "description": "Crafting inviting and functional living spaces for family and friends to gather."},
    { "title": "Exterior Design Services", "description": "Enhancing your home''s curb appeal with our expert exterior design solutions."},
    { "title": "Full Home Interiors", "description": "A complete, end-to-end interior design service for a cohesive and beautiful home."}
  ]
}', '{
  "services": {"type": "repeater", "label": "Services List"}
}'),
(get_page_id('services'), 3, 'detailed_services', 'Detailed Services', true, '{
  "services": [
    { "title": "Modular Kitchens", "href": "/products/kitchen", "imageSrc": "https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "modern kitchen" },
    { "title": "Wardrobes", "href": "/products/wardrobe", "imageSrc": "https://images.unsplash.com/photo-1614631446501-abcf76949eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "modern wardrobe" },
    { "title": "Living Area Design", "href": "/products/living-room", "imageSrc": "https://images.unsplash.com/photo-1604537529428-49d7c237887a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxsaXZpbmclMjByb29tJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU2MTAxMDk4fDA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "living room design" }
  ]
}', '{
  "services": {"type": "repeater", "label": "Detailed Services List"}
}'),
-- Portfolio Page Sections
(get_page_id('portfolio'), 1, 'projects_gallery', 'Projects Gallery', true, '{
    "projects": [
      { "id": 1, "title": "Contemporary Kitchen", "category": "Kitchens", "imageSrc": "https://images.unsplash.com/photo-1596205263989-423c8e57e034?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxjb250ZW1wb3JhcnklMjBraXRjaGVufGVufDB8fHx8fDE3NTYxMDEyMjB8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "contemporary kitchen" },
      { "id": 2, "title": "Minimalist Living Room", "category": "Living Areas", "imageSrc": "https://images.unsplash.com/photo-1617098900591-3f90928e8c54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtaW5pbWFsaXN0JTIwbGl2aW5nJTIwcm9vbXxlbnwwfHx8fDE3NTYxMDEyNDZ8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "minimalist living room" },
      { "id": 3, "title": "Walk-in Wardrobe", "category": "Wardrobes", "imageSrc": "https://images.unsplash.com/photo-1628591038392-1718503a35d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx3YWxrLWluJTIwY2xvc2V0fGVufDB8fHx8fDE3NTYxMDEyNzR8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "walk-in closet" },
      { "id": 4, "title": "Modern Bedroom", "category": "Bedrooms", "imageSrc": "https://images.unsplash.com/photo-1560185007-c5ca9d2c015d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBiZWRyb29tfGVufDB8fHx8fDE3NTYxMDEzMTZ8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "modern bedroom" },
      { "id": 5, "title": "Island Kitchen", "category": "Kitchens", "imageSrc": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpc2xhbmQlMjBraXRjaGVufGVufDB8fHx8fDE3NTYxMDEzNDR8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "island kitchen" },
      { "id": 6, "title": "Cozy Living Space", "category": "Living Areas", "imageSrc": "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxjb3p5JTIwbGl2aW5nJTIwcm9vbXxlbnwwfHx8fDE3NTYxMDEzNjl8MA&ixlib=rb-4.1.0&q=80&w=1080", "dataAiHint": "cozy living space" }
    ]
}', '{
    "projects": {"type": "repeater", "label": "Projects"}
}'),
(get_page_id('portfolio'), 2, 'partners', 'Partners Section', true, '{
    "title": "Our Trusted Partners",
    "subtitle": "Brands We Work With",
    "items": [
        {"name": "Hettich", "logoSrc": "/p1.png"},
        {"name": "Greenply", "logoSrc": "/p2.png"},
        {"name": "Bosch", "logoSrc": "/p3.png"},
        {"name": "Siemens", "logoSrc": "/p4.png"},
        {"name": "Kaff", "logoSrc": "/p5.png"}
    ]
}', '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Partner Logos"}
}');
-- No sections needed for contact, how-it-works, or products pages as they are mostly static or simple.
-- Their content is managed within their respective page files for simplicity, but they exist in the `pages` table for site structure.
-- We can add editable sections for them later if needed.
