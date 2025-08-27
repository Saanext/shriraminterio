
-- Enable Row Level Security
alter table public.pages enable row level security;
alter table public.sections enable row level security;
alter table public.stories enable row level security;

-- Create Policies
create policy "Allow read access to everyone" on public.pages for select using (true);
create policy "Allow read access to everyone" on public.sections for select using (true);
create policy "Allow read access to everyone" on public.stories for select using (true);
create policy "Allow full access to authenticated users" on public.pages for all using (auth.role() = 'authenticated');
create policy "Allow full access to authenticated users" on public.sections for all using (auth.role() = 'authenticated');
create policy "Allow full access to authenticated users" on public.stories for all using (auth.role() = 'authenticated');

-- Create storage bucket for public images
INSERT INTO storage.buckets (id, name, public)
VALUES ('public', 'public', true)
ON CONFLICT (id) DO NOTHING;

-- Create policy for public images
CREATE POLICY "Public images are readable by everyone"
ON storage.objects FOR SELECT
USING ( bucket_id = 'public' );

CREATE POLICY "Anyone can upload an image to the public bucket"
ON storage.objects FOR INSERT
WITH CHECK ( bucket_id = 'public' );

-- Seed Pages
insert into public.pages (id, slug, title, meta_title, meta_description) values
(1, 'home', 'Home', 'Shriram Interio Digital | Pune''s Premier Interior Designers', 'Discover bespoke interior designs for modular kitchens, wardrobes, and full homes in Pune. Shriram Interio offers expert design solutions and quality craftsmanship.'),
(2, 'about', 'About Us', 'About Shriram Interio | Our Story, Mission, and Values', 'Learn about Shriram Interio''s journey, our passionate team, and our commitment to creating beautiful and functional living spaces in Pune.'),
(3, 'customer-stories', 'Customer Stories', 'Inspiring Customer Stories | Shriram Interio Design Projects', 'Read real-life stories from our happy clients and see how we transformed their homes and lives with our interior design expertise.'),
(4- 'clients', 'Clients', 'Our Valued Clients | Testimonials & Reviews', 'See what our clients have to say about their experience with Shriram Interio. Read testimonials and watch video reviews from satisfied homeowners in Pune.'),
(5, 'services', 'Services', 'Our Interior Design Services | From Concept to Completion', 'Explore our comprehensive range of interior design services, including modular kitchens, wardrobes, full home interiors, and more.'),
(6, 'portfolio', 'Portfolio', 'Interior Design Portfolio | Shriram Interio''s Completed Projects', 'Browse our portfolio of stunning interior design projects. See examples of our work in modular kitchens, living areas, and bedrooms.'),
(7, 'how-it-works', 'How It Works', 'Our Design Process | How Shriram Interio Works', 'Understand our seamless 6-step interior design process, from initial consultation and 3D visualization to project handover and warranty.'),
(8, 'contact', 'Contact Us', 'Contact Shriram Interio | Get in Touch for a Free Consultation', 'Contact us today for a free interior design consultation. Find our address, phone number, and email to start your project.');


-- Seed Home Page Sections
insert into public.sections (page_id, "order", type, title, content, content_structure, visible) values
(1, 1, 'hero', 'Hero Section', '{
  "title": "Crafting Dream Spaces, One Home at a Time",
  "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors.",
  "buttonText": "Explore Our Services",
  "videoUrl": "https://www.shriraminterio.com/wp-content/uploads/2024/05/10000000_1170068494165649_148818819522192734_n.mp4",
  "slides": [
    { "image": "https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80" },
    { "image": "https://images.unsplash.com/photo-1616046229478-9901c5536a45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80" }
  ]
}', '{
    "title": { "label": "Main Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "buttonText": { "label": "Button Text", "type": "text" },
    "videoUrl": { "label": "Background Video URL", "type": "text" },
    "slides": { "label": "Image Slides", "type": "repeater" }
}', true),
(1, 2, 'welcome', 'Welcome Section', '{
    "paragraph1": "SHRIRAM INTERIO is a modular interior manufacturing unit where we provide a one-stop solution for all your interior needs. With over 8 years of experience, we have successfully completed 500+ projects, delivering quality and excellence every time.",
    "paragraph2": "We specialize in modular kitchens, wardrobes, beds, TV units, and much more. Our experienced team ensures that every detail is crafted to perfection, transforming your space into a dream home.",
    "image": "https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbnRlcmlvciUyMGRlc2lnbiUyMHNrZXRjaHxlbnwwfHx8fDE3NTU2MjQwODZ8MA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "paragraph1": { "label": "Paragraph 1", "type": "textarea" },
    "paragraph2": { "label": "Paragraph 2", "type": "textarea" },
    "image": { "label": "Image", "type": "image" }
}', true),
(1, 3, 'about_company', 'About Company Section', '{
    "title": "ABOUT COMPANY",
    "text": "is a modular interior manufacturing unit where we provide a one-stop solution for all your interior needs."
}', '{
    "title": { "label": "Title", "type": "text" },
    "text": { "label": "Text", "type": "textarea" }
}', true),
(1, 4, 'why_us', 'Why Us Section', '{
    "title": "Why Shriram Interio",
    "subtitle": "Discover the benefits of working with our experienced team.",
    "items": [
        { "title": "Expert Design Team", "description": "We have a team of experienced designers who can help you create the perfect space." },
        { "title": "Variety of Design Choices", "description": "We offer a wide range of design choices to suit your style and budget." },
        { "title": "Affordable Design Fees", "description": "We offer affordable design fees to help you create your dream home." },
        { "title": "On-Time Project Delivery", "description": "We ensure that your project is delivered on time, every time." }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Items", "type": "repeater" }
}', true),
(1, 5, 'work_gallery', 'Work Gallery Section', '{
    "title": "Our Work Gallery",
    "subtitle": "A Glimpse into Our World of Creativity",
    "items": [
        { "title": "Modern Living Room", "image": "https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "living room" },
        { "title": "Elegant Kitchen Design", "image": "https://images.unsplash.com/photo-1556911220-bff31c812dba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "kitchen design" },
        { "title": "Cozy Bedroom Interior", "image": "https://images.unsplash.com/photo-1616046229478-9901c5536a45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "bedroom interior" },
        { "title": "Luxury Bathroom", "image": "https://images.unsplash.com/photo-1603952178233-0874c7b8478a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "luxury bathroom" },
        { "title": "Stylish Wardrobe", "image": "https://images.unsplash.com/photo-1618221195710-869956a9975a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "wardrobe" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Items", "type": "repeater" }
}', true),
(1, 6, 'comfort_design', 'Comfort Design Section', '{
    "title": "Design At Your Comfort",
    "subtitle": "Discover our streamlined process that puts you at the center of your design journey. From virtual consultations to live 3D visualizations, we bring your vision to life without you ever having to leave your home. Experience a hassle-free, personalized design process tailored to your comfort and convenience.",
    "items": [
        { "title": "Live 3D Designs", "description": "Experience your new home in 3D before it’s built." },
        { "title": "Contactless Experience", "description": "Connect with our designers from the comfort of your home." },
        { "title": "Instant Pricing", "description": "Get a customized quote for your project in minutes." },
        { "title": "Expertise & Passion", "description": "We are passionate about design and dedicated to creating spaces that inspire." }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Items", "type": "repeater" }
}', true),
(1, 7, 'what_we_do', 'What We Do Section', '{
    "title": "What We Do",
    "subtitle": "Discover the Latest in Home Interior Designs",
    "trendingItems": [
        { "name": "Minimalist Living Room", "image": "/t1.jpg", "hint": "minimalist living room" },
        { "name": "Modern Kitchen", "image": "/t2.jpg", "hint": "modern kitchen" },
        { "name": "Cozy Bedroom", "image": "/t3.jpg", "hint": "cozy bedroom" },
        { "name": "Elegant Wardrobe", "image": "/t4.jpg", "hint": "elegant wardrobe" }
    ],
    "bestSellingKitchens": [
        { "name": "L-Shaped Modular Kitchen", "image": "/k1.jpg", "hint": "l-shaped kitchen" },
        { "name": "U-Shaped Modular Kitchen", "image": "/k2.jpg", "hint": "u-shaped kitchen" },
        { "name": "Parallel Kitchen", "image": "/k3.jpg", "hint": "parallel kitchen" },
        { "name": "Island Kitchen", "image": "/k4.jpg", "hint": "island kitchen" }
    ],
    "bestSellingWardrobes": [
        { "name": "Sliding Wardrobe", "image": "/w1.jpg", "hint": "sliding wardrobe" },
        { "name": "Hinged Wardrobe", "image": "/w2.jpg", "hint": "hinged wardrobe" },
        { "name": "Walk-in Wardrobe", "image": "/w3.jpg", "hint": "walk-in wardrobe" },
        { "name": "Freestanding Wardrobe", "image": "/w4.jpg", "hint": "freestanding wardrobe" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "trendingItems": { "label": "Trending Items", "type": "repeater" },
    "bestSellingKitchens": { "label": "Best Selling Kitchens", "type": "repeater" },
    "bestSellingWardrobes": { "label": "Best Selling Wardrobes", "type": "repeater" }
}', true),
(1, 8, 'testimonials', 'Testimonials Section', '{
    "title": "What Our Clients Say",
    "subtitle": "We are proud to have served over 500 happy clients.",
    "buttonText": "Read More Stories",
    "items": [
        { "name": "Rahul & Anjali", "review": "The team at Shriram Interio transformed our vision into reality. Their attention to detail and commitment to quality is commendable. Our home feels like a dream!", "image": "https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" },
        { "name": "Vikram Singh", "review": "From the initial design consultation to the final handover, the process was seamless. The designers were patient and incorporated all our ideas beautifully.", "image": "https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" },
        { "name": "Priya & Sameer", "review": "Professional, creative, and reliable. Shriram Interio delivered our modular kitchen on time and the quality is outstanding. Highly recommended!", "image": "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "buttonText": { "label": "Button Text", "type": "text" },
    "items": { "label": "Items", "type": "repeater" }
}', true),
(1, 9, 'faq', 'FAQ Section', '{
    "title": "Frequently Asked Questions",
    "subtitle": "Find answers to common questions about our services.",
    "items": [
        { "question": "What is the typical timeline for a project?", "answer": "A typical project takes about 4-6 weeks from design approval to handover. However, this can vary based on the scope and complexity of the project." },
        { "question": "Do you offer a warranty?", "answer": "Yes, we offer a one-year warranty on all our modular products against any manufacturing defects." },
        { "question": "Can I see a 3D design before finalizing?", "answer": "Absolutely! We provide detailed 2D and 3D designs to help you visualize your space. We also offer live 3D sessions for a more interactive experience." },
        { "question": "What are the payment terms?", "answer": "We have a flexible payment structure. Typically, we require a 50% advance to start the project, and the remaining 50% is due upon completion and before handover." }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Items", "type": "repeater" }
}', true),
(1, 10, 'partners', 'Partners Section', '{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY BRANDS",
    "items": [
        { "name": "Hettich", "logoSrc": "/Hettich.png" },
        { "name": "Hafele", "logoSrc": "/Hafele.png" },
        { "name": "Merino", "logoSrc": "/Merino.png" },
        { "name": "Greenply", "logoSrc": "/Greenply.png" },
        { "name": "Bosch", "logoSrc": "/Bosch.png" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Items", "type": "repeater" }
}', true);


-- Seed About Us Page Sections
insert into public.sections (page_id, "order", type, title, content, content_structure, visible) values
(2, 1, 'hero', 'Hero Section', '{
  "title": "About Shriram Interio",
  "subtitle": "Crafting beautiful and functional spaces since 2016.",
  "backgroundImage": "https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxhYm91dCUyMHVzJTIwaW50ZXJpb3IlMjBkZXNpZ258ZW58MHx8fHwxNzU2MjAxMjM3fDA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "backgroundImage": { "label": "Background Image", "type": "image" }
}', true),
(2, 2, 'story', 'Our Story Section', '{
    "heading": "Our Story",
    "subheading": "The journey of a thousand miles begins with a single step.",
    "paragraph1": "SHRIRAM INTERIO is a modular interior manufacturing unit where we provide a one-stop solution for all your interior needs. With over 8 years of experience, we have successfully completed 500+ projects, delivering quality and excellence every time.",
    "paragraph2": "We specialize in modular kitchens, wardrobes, beds, TV units, and much more. Our experienced team ensures that every detail is crafted to perfection, transforming your space into a dream home.",
    "paragraph3": "Our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering.",
    "paragraph4": "Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul. We believe that a well-designed space has the power to inspire, comfort, and rejuvenate.",
    "image": "https://images.unsplash.com/photo-1519389950473-47ba0277781c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxvdXIlMjBzdG9yeSUyMGRlc2lnbiUyMHRlYW18ZW58MHx8fHwxNzU2MjAxMzYxfDA&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "heading": { "label": "Heading", "type": "text" },
    "subheading": { "label": "Subheading", "type": "text" },
    "paragraph1": { "label": "Paragraph 1", "type": "textarea" },
    "paragraph2": { "label": "Paragraph 2", "type": "textarea" },
    "paragraph3": { "label": "Paragraph 3", "type": "textarea" },
    "paragraph4": { "label": "Paragraph 4", "type": "textarea" },
    "image": { "label": "Image", "type": "image" }
}', true),
(2, 3, 'journey', 'Our Journey Section', '{
    "heading": "Our Journey",
    "paragraph1": "Since our establishment in 2016, Shriram Interio has been on a remarkable journey of growth and innovation. What started as a small team of passionate designers has now blossomed into a leading name in Pune''s interior design landscape.",
    "paragraph2": "We have successfully delivered over 500 projects, each one a testament to our dedication and craftsmanship. Our portfolio showcases a diverse range of styles, from contemporary and minimalist to classic and luxurious.",
    "paragraph3": "We have continuously adapted to the latest trends and technologies, integrating smart home solutions and sustainable practices into our designs. Our state-of-the-art manufacturing unit ensures precision and quality in every piece of furniture we create.",
    "paragraph4": "The trust and satisfaction of our clients have been the cornerstone of our success. We are grateful for the relationships we have built and look forward to many more years of creating beautiful homes together.",
    "image": "https://images.unsplash.com/photo-1541848216316-2811a461394f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxkZXNpZ24lMjBqb3VybmV5fGVufDB8fHx8MTc1NjIwMTQ5MHww&ixlib=rb-4.1.0&q=80&w=1080"
}', '{
    "heading": { "label": "Heading", "type": "text" },
    "paragraph1": { "label": "Paragraph 1", "type": "textarea" },
    "paragraph2": { "label": "Paragraph 2", "type": "textarea" },
    "paragraph3": { "label": "Paragraph 3", "type": "textarea" },
    "paragraph4": { "label": "Paragraph 4", "type": "textarea" },
    "image": { "label": "Image", "type": "image" }
}', true),
(2, 4, 'values', 'Our Values Section', '{
    "title": "Our Core Values",
    "subtitle": "The principles that guide our work and define our culture.",
    "items": [
        { "title": "Expert Design Team", "description": "Our team of skilled designers brings a wealth of experience and creativity to every project, ensuring innovative and personalized solutions." },
        { "title": "Variety of Design Choices", "description": "We offer a diverse palette of styles, materials, and finishes to cater to your unique taste and preferences." },
        { "title": "Affordable Design Fees", "description": "We believe that great design should be accessible. Our transparent and competitive pricing ensures value without compromising on quality." },
        { "title": "On-Time Project Delivery", "description": "We respect your time. Our efficient project management ensures that we deliver your dream home within the promised timeline." }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Value Items", "type": "repeater" }
}', true),
(2, 5, 'mission_vision', 'Mission & Vision Section', '{
    "visionTitle": "Our Vision",
    "visionText": "To be the most trusted and innovative interior design firm in Pune, renowned for creating spaces that inspire and enhance the quality of life.",
    "missionTitle": "Our Mission",
    "missionText": "To deliver exceptional interior design solutions through a collaborative process, combining creativity, quality craftsmanship, and a client-centric approach to turn every house into a home."
}', '{
    "visionTitle": { "label": "Vision Title", "type": "text" },
    "visionText": { "label": "Vision Text", "type": "textarea" },
    "missionTitle": { "label": "Mission Title", "type": "text" },
    "missionText": { "label": "Mission Text", "type": "textarea" }
}', true),
(2, 6, 'team', 'Meet the Team Section', '{
    "title": "Meet Our Creative Team",
    "subtitle": "The passionate individuals behind our successful designs.",
    "members": [
        { "name": "Anjali Sharma", "role": "Lead Interior Designer", "bio": "Anjali brings over a decade of experience in residential and commercial design, with a flair for creating elegant and timeless spaces.", "image": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYyMDE4NDR8MA&ixlib=rb-4.1.0&q=80&w=1080" },
        { "name": "Ravi Kumar", "role": "Project Manager", "bio": "Ravi ensures that every project is executed flawlessly, from initial planning to final handover, with a keen eye for detail and timelines.", "image": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYWxlJTIwcG9ydHJhaXR8ZW58MHx8fHwxNzU2MjAxODgxfDA&ixlib=rb-4.1.0&q=80&w=1080" },
        { "name": "Priya Singh", "role": "3D Visualization Expert", "bio": "Priya is the artist who brings our designs to life, creating stunningly realistic 3D renderings that help clients visualize their future homes.", "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYyMDE4NDR8MA&ixlib=rb-4.1.0&q=80&w=1080" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "members": { "label": "Team Members", "type": "repeater" }
}', true);


-- Seed Customer Stories Page Sections
insert into public.sections (page_id, "order", type, title, content, content_structure, visible) values
(3, 1, 'header', 'Header', '{
    "title": "Customer Stories",
    "subtitle": "Discover how we''ve transformed houses into dream homes. Real stories from our valued clients."
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" }
}', true),
(3, 2, 'featured_story', 'Featured Story', '{
    "buttonText": "Read Their Story"
}', '{
    "buttonText": { "label": "Button Text", "type": "text" }
}', true),
(3, 3, 'more_stories', 'More Stories', '{
    "title": "More Inspiring Stories"
}', '{
    "title": { "label": "Title", "type": "text" }
}', true),
(3, 4, 'work_gallery', 'Work Gallery Section', '{
    "title": "Our Work Gallery",
    "subtitle": "A Glimpse into Our World of Creativity",
    "items": [
        { "title": "Modern Living Room", "image": "https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "living room" },
        { "title": "Elegant Kitchen Design", "image": "https://images.unsplash.com/photo-1556911220-bff31c812dba?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "kitchen design" },
        { "title": "Cozy Bedroom Interior", "image": "https://images.unsplash.com/photo-1616046229478-9901c5536a45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%D%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "bedroom interior" },
        { "title": "Luxury Bathroom", "image": "https://images.unsplash.com/photo-1603952178233-0874c7b8478a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "luxury bathroom" },
        { "title": "Stylish Wardrobe", "image": "https://images.unsplash.com/photo-1618221195710-869956a9975a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80", "hint": "wardrobe" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Gallery Items", "type": "repeater" }
}', true),
(3, 5, 'partners', 'Partners Section', '{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY BRANDS",
    "items": [
        { "name": "Hettich", "logoSrc": "/Hettich.png" },
        { "name": "Hafele", "logoSrc": "/Hafele.png" },
        { "name": "Merino", "logoSrc": "/Merino.png" },
        { "name": "Greenply", "logoSrc": "/Greenply.png" },
        { "name": "Bosch", "logoSrc": "/Bosch.png" }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "Partner Items", "type": "repeater" }
}', true),
(3, 6, 'faq', 'FAQ Section', '{
    "title": "Frequently Asked Questions",
    "subtitle": "Find answers to common questions about our services.",
    "items": [
        { "question": "What is the typical timeline for a project?", "answer": "A typical project takes about 4-6 weeks from design approval to handover. However, this can vary based on the scope and complexity of the project." },
        { "question": "Do you offer a warranty?", "answer": "Yes, we offer a one-year warranty on all our modular products against any manufacturing defects." },
        { "question": "Can I see a 3D design before finalizing?", "answer": "Absolutely! We provide detailed 2D and 3D designs to help you visualize your space. We also offer live 3D sessions for a more interactive experience." },
        { "question": "What are the payment terms?", "answer": "We have a flexible payment structure. Typically, we require a 50% advance to start the project, and the remaining 50% is due upon completion and before handover." }
    ]
}', '{
    "title": { "label": "Title", "type": "text" },
    "subtitle": { "label": "Subtitle", "type": "textarea" },
    "items": { "label": "FAQ Items", "type": "repeater" }
}', true);


-- Seed Clients Page Sections
insert into public.sections (page_id, "order", type, title, content, content_structure, visible) values
(4, 1, 'featured_testimonial', 'Featured Testimonial', '{
    "name": "Rohan Sharma",
    "image": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYWxlJTIwcG9ydHJhaXQlMjBzbWlsaW5nfGVufDB8fHx8MTc1NjIyMjI1OHww&ixlib=rb-4.1.0&q=80&w=1080",
    "location": "Pune, Maharashtra",
    "project": "Full Home Interior",
    "size": "3 BHK",
    "quote": "The best interior design decision we ever made.",
    "review": "From our first meeting to the final handover, the team at Shriram Interio was exceptional. They understood our vision perfectly and brought it to life with incredible attention to detail. The quality of their modular furniture is top-notch, and their professionalism made the entire process stress-free. Our home is not just beautiful, it''s a true reflection of our personality. We couldn''t be happier!"
}', '{
    "name": {"label": "Client Name", "type": "text"},
    "image": {"label": "Client Image", "type": "image"},
    "location": {"label": "Location", "type": "text"},
    "project": {"label": "Project Type", "type": "text"},
    "size": {"label": "Property Size", "type": "text"},
    "quote": {"label": "Quote", "type": "textarea"},
    "review": {"label": "Full Review", "type": "textarea"}
}', true),
(4, 2, 'video_testimonials', 'Video Testimonials', '{
    "title": "Hear From Our Clients",
    "subtitle": "Watch our clients share their experiences with Shriram Interio.",
    "videos": [
        {
            "name": "The Gupta Family",
            "location": "Koregaon Park, Pune",
            "review": "Our kitchen is now the heart of our home, thanks to Shriram Interio. The design is both beautiful and incredibly functional.",
            "imageSrc": "https://images.unsplash.com/photo-1556911220-e4a73363362a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2R1bGFyJTIwa2l0Y2hlbiUyMGNvdXBsZXxlbnwwfHx8fDE3NTYyMjI3Mzd8MA&ixlib=rb-4.1.0&q=80&w=1080",
            "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            "dataAiHint": "couple kitchen"
        },
        {
            "name": "Aarav Deshmukh",
            "location": "Hinjewadi, Pune",
            "review": "They designed the perfect wardrobe for my compact bedroom. The space optimization is simply brilliant.",
            "imageSrc": "https://images.unsplash.com/photo-1593506132331-b02b66236780?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYW4lMjBpbiUyMGJhdGhyb29tfGVufDB8fHx8MTc1NjIyMzA3N3ww&ixlib=rb-4.1.0&q=80&w=1080",
            "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            "dataAiHint": "man bedroom"
        },
        {
            "name": "The Joshi Household",
            "location": "Baner, Pune",
            "review": "The full home interior service was fantastic. They managed everything professionally, delivering our dream home on time.",
            "imageSrc": "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmYW1pbHklMjBpbiUyMGxpdmluZyUyMHJvb218ZW58MHx8fHwxNzU2MjIyOTUzfDA&ixlib=rb-4.1.0&q=80&w=1080",
            "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
            "dataAiHint": "family living room"
        }
    ]
}', '{
    "title": {"label": "Section Title", "type": "text"},
    "subtitle": {"label": "Section Subtitle", "type": "textarea"},
    "videos": {"label": "Videos", "type": "repeater"}
}', true),
(4, 3, 'text_testimonials', 'Text Testimonials', '{
    "title": "Words of Appreciation",
    "subtitle": "We are proud to have served over 500 happy clients.",
    "testimonials": [
        { "name": "Priya Patel", "avatar": "PP", "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYyMjMzMTR8MA&ixlib=rb-4.1.0&q=80&w=1080", "review": "The quality of the materials and the finishing is excellent. My modular kitchen is not only beautiful but also very easy to maintain. Highly recommended!" },
        { "name": "Amit Kumar", "avatar": "AK", "image": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtYWxlJTIwcG9ydHJhaXQlMjBzbWlsaW5nJTIwb3V0ZG9vcnN8ZW58MHx8fHwxNzU2MjIzMzg0fDA&ixlib=rb-4.1.0&q=80&w=1080", "review": "A thoroughly professional team. They listened to all my requirements and delivered a design that perfectly matched my lifestyle. The project was completed on schedule." },
        { "name": "Sneha Reddy", "avatar": "SR", "image": "https://images.unsplash.com/photo-1580489944761-15a19d654956?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxmZW1hbGUlMjBwb3J0cmFpdHxlbnwwfHx8fDE3NTYyMjMzMTR8MA&ixlib=rb-4.1.0&q=80&w=1080", "review": "I was very impressed with their design process, especially the 3D visualizations. It helped me make decisions confidently. The end result is fantastic!" }
    ]
}', '{
    "title": {"label": "Section Title", "type": "text"},
    "subtitle": {"label": "Section Subtitle", "type": "textarea"},
    "testimonials": {"label": "Testimonials", "type": "repeater"}
}', true);


-- Seed Services Page Sections
insert into public.sections (page_id, "order", type, title, content, content_structure, visible) values
(5, 1, 'header', 'Header', '{
    "title": "Our Services",
    "subtitle": "Comprehensive interior design solutions tailored to your needs."
}', '{
    "title": {"label": "Title", "type": "text"},
    "subtitle": {"label": "Subtitle", "type": "textarea"}
}', true),
(5, 2, 'our_services', 'Our Services', '{
    "services": [
        { "title": "Modular Kitchen Design", "description": "Creating efficient, elegant, and ergonomic kitchen spaces tailored to your cooking style." },
        { "title": "Wardrobe & Storage Solutions", "description": "Customized wardrobes and storage units that maximize space and enhance your room''s aesthetics." },
        { "title": "Bedroom Interiors", "description": "Designing serene and personal sanctuaries for rest and relaxation." },
        { "title": "Living Area Design", "description": "Crafting welcoming and functional living spaces for family, friends, and entertainment." },
        { "title": "Exterior Design Services", "description": "Expert solutions for creating stunning and durable exteriors that complement your home." },
        { "title": "Full Home Interiors", "description": "A complete, end-to-end design solution for a cohesive and beautifully designed home." }
    ]
}', '{
    "services": {"label": "Services List", "type": "repeater"}
}', true),
(5, 3, 'detailed_services', 'Detailed Services', '{
    "services": [
        {
            "title": "Modular Kitchens",
            "href": "/products/kitchen",
            "imageSrc": "https://images.unsplash.com/photo-1556911220-bff31c812dba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080",
            "dataAiHint": "modular kitchen"
        },
        {
            "title": "Wardrobes",
            "href": "/products/wardrobe",
            "imageSrc": "https://images.unsplash.com/photo-1618221195710-869956a9975a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHx3YXJkcm9iZXxlbnwwfHx8fDE3NTU3MTUzOTF8MA&ixlib=rb-4.1.0&q=80&w=1080",
            "dataAiHint": "modern wardrobe"
        },
        {
            "title": "Living Room Interiors",
            "href": "/products/living-room",
            "imageSrc": "https://images.unsplash.com/photo-1618220179428-22790b461013?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxsaXZpbmclMjByb29tJTIwaW50ZXJpb3J8ZW58MHx8fHwxNzU2MjI1MDIwfDA&ixlib=rb-4.1.0&q=80&w=1080",
            "dataAiHint": "living room interior"
        }
    ]
}', '{
    "services": {"label": "Detailed Services List", "type": "repeater"}
}', true);


-- Seed Portfolio Page Sections
insert into public.sections (page_id, "order", type, title, content, content_structure, visible) values
(6, 1, 'projects_gallery', 'Projects Gallery', '{
    "projects": [
        { "id": 1, "title": "Contemporary Kitchen", "category": "Kitchens", "imageSrc": "/portfolio/kitchen1.jpg", "dataAiHint": "contemporary kitchen" },
        { "id": 2, "title": "Minimalist Living Area", "category": "Living Areas", "imageSrc": "/portfolio/living1.jpg", "dataAiHint": "minimalist living" },
        { "id": 3, "title": "Walk-in Wardrobe", "category": "Wardrobes", "imageSrc": "/portfolio/wardrobe1.jpg", "dataAiHint": "walk-in wardrobe" },
        { "id": 4, "title": "U-Shaped Kitchen", "category": "Kitchens", "imageSrc": "/portfolio/kitchen2.jpg", "dataAiHint": "u-shaped kitchen" },
        { "id": 5, "title": "Modern Bedroom", "category": "Bedrooms", "imageSrc": "/portfolio/bedroom1.jpg", "dataAiHint": "modern bedroom" },
        { "id": 6, "title": "Entertainment Zone", "category": "Living Areas", "imageSrc": "/portfolio/living2.jpg", "dataAiHint": "entertainment zone" },
        { "id": 7, "title": "Sliding Door Wardrobe", "category": "Wardrobes", "imageSrc": "/portfolio/wardrobe2.jpg", "dataAiHint": "sliding wardrobe" },
        { "id": 8, "title": "Classic Kitchen", "category": "Kitchens", "imageSrc": "/portfolio/kitchen3.jpg", "dataAiHint": "classic kitchen" },
        { "id": 9, "title": "Kids Bedroom", "category": "Bedrooms", "imageSrc": "/portfolio/bedroom2.jpg", "dataAiHint": "kids bedroom" }
    ]
}', '{
    "projects": {"label": "Projects", "type": "repeater"}
}', true),
(6, 2, 'partners', 'Partners Section', '{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY BRANDS",
    "items": [
        { "name": "Hettich", "logoSrc": "/Hettich.png" },
        { "name": "Hafele", "logoSrc": "/Hafele.png" },
        { "name": "Merino", "logoSrc": "/Merino.png" },
        { "name": "Greenply", "logoSrc": "/Greenply.png" },
        { "name": "Bosch", "logoSrc": "/Bosch.png" }
    ]
}', '{
    "title": {"label": "Title", "type": "text"},
    "subtitle": {"label": "Subtitle", "type": "text"},
    "items": {"label": "Partners", "type": "repeater"}
}', true);


-- Seed Stories
insert into public.stories (id, slug, title, category, date, author, authorAvatar, excerpt, image, dataAiHint, clientImage, location, project, size, quote, content, gallery) values
(1, 'modern-minimalist-living', 'Transforming a Compact Space into a Modern Minimalist Haven', 'Living Areas', '15 May, 2024', 'The Sharma Family', 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmYW1pbHklMjBpbiUyMGxpdmluZyUyMHJvb218ZW58MHx8fHwxNzU2MjI2MjMwfDA&ixlib=rb-4.1.0&q=80&w=1080', 'Discover how we redesigned a 2BHK apartment in Pune to create a spacious, light-filled living area that perfectly blends style and functionality.', '/customer-stories/story1-main.jpg', 'minimalist living room', 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxmYW1pbHklMjBpbiUyMGxpdmluZyUyMHJvb218ZW58MHx8fHwxNzU2MjI2MjMwfDA&ixlib=rb-4.1.0&q=80&w=1080', 'Kharadi, Pune', 'Living Area & TV Unit', '2 BHK', 'Shriram Interio turned our small apartment into a spacious and elegant home.', '<h3>The Challenge</h3><p>The Sharma family approached us with a common urban challenge: their 2BHK apartment felt cramped and lacked a cohesive design. They wanted a living space that was modern, minimalist, and yet warm and inviting—a place where the family could relax and entertain guests comfortably.</p><h3>Our Approach</h3><p>Our design team, led by Anjali, focused on creating an illusion of space. We used a light color palette with shades of white, beige, and grey, accented with natural wood tones to add warmth. We designed a custom, wall-mounted TV unit with sleek, handle-less cabinets to provide storage without occupying floor space. A large mirror was strategically placed on one wall to reflect light and create a sense of depth. For furniture, we selected a low-profile sofa and nesting coffee tables that could be easily moved around.</p><h3>The Result</h3><p>The transformation was remarkable. The living area now feels open, airy, and significantly larger. The clever use of colors, custom furniture, and strategic lighting has created a beautiful and functional space that the Sharma family adores. "It feels like a completely new home," Mrs. Sharma told us. "The team didn''t just design our space; they understood our lifestyle and created a solution that works perfectly for us."</p>', '[
    {"src": "/customer-stories/story1-gallery1.jpg", "alt": "Wide shot of the living area", "dataAiHint": "living area"},
    {"src": "/customer-stories/story1-gallery2.jpg", "alt": "Close-up of the custom TV unit", "dataAiHint": "tv unit"},
    {"src": "/customer-stories/story1-gallery3.jpg", "alt": "The seating area with the new sofa", "dataAiHint": "sofa area"}
]'),
(2, 'elegant-kitchen-redesign', 'An Elegant and Ergonomic Kitchen Redesign for a Passionate Cook', 'Kitchens', '22 April, 2024', 'Mrs. Anita Desai', 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjB3b21hbiUyMGluJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTYyMjY0NjJ8MA&ixlib=rb-4.1.0&q=80&w=1080', 'A complete kitchen overhaul for a client who loves to cook, focusing on workflow efficiency, premium materials, and a timeless aesthetic.', '/customer-stories/story2-main.jpg', 'modern kitchen', 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxpbmRpYW4lMjB3b21hbiUyMGluJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTYyMjY0NjJ8MA&ixlib=rb-4.1.0&q=80&w=1080', 'Aundh, Pune', 'Modular Kitchen', '120 sq. ft.', 'My kitchen is now my happy place. It’s as beautiful as it is functional.', '<h3>The Challenge</h3><p>Mrs. Desai, an avid home baker and cook, had a kitchen that was outdated and inefficient. The storage was inadequate, the countertop space was limited, and the workflow was hampered by a poor layout. She dreamed of a kitchen that was not only beautiful but also highly organized and a joy to work in.</p><h3>Our Approach</h3><p>We implemented the classic kitchen work triangle (linking the stove, sink, and refrigerator) to ensure an efficient workflow. We designed a U-shaped layout to maximize counter and storage space. High-quality acrylic-finish cabinets were chosen for their durability and sleek look, complemented by a quartz countertop that is both heat and scratch-resistant. We incorporated smart storage solutions like a pull-out pantry, magic corner units, and deep drawers to keep everything organized and accessible.</p><h3>The Result</h3><p>The new kitchen is a masterpiece of design and functionality. The bright, open space is filled with natural light, and the smart layout makes cooking a breeze. Mrs. Desai was thrilled with the outcome. "I spend most of my day in the kitchen, and now it’s my favorite room in the house," she said. "The team at Shriram Interio listened to every single detail and delivered beyond my expectations."</p>', '[
    {"src": "/customer-stories/story2-gallery1.jpg", "alt": "The new U-shaped kitchen layout", "dataAiHint": "u-shaped kitchen"},
    {"src": "/customer-stories/story2-gallery2.jpg", "alt": "Smart storage solutions in action", "dataAiHint": "kitchen storage"},
    {"src": "/customer-stories/story2-gallery3.jpg", "alt": "Close-up of the acrylic finish cabinets", "dataAiHint": "kitchen cabinets"}
]');
