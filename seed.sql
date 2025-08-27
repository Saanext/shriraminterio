
-- Make sure to run this in your Supabase SQL Editor to seed the database.

-- Insert Pages
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('home', 'Home', 'Shriram Interio | Pune''s Premier Interior Designers', 'Discover stunning modular kitchens, wardrobes, and full home interiors in Pune. Shriram Interio offers expert design, quality craftsmanship, and timely delivery.'),
('about', 'About Us', 'About Shriram Interio | Our Story and Values', 'Learn about Shriram Interio, our journey, our values, and the talented team dedicated to creating beautiful and functional living spaces in Pune.'),
('clients', 'Clients', 'Our Clients | Shriram Interio Testimonials', 'See what our happy clients have to say about their experience with Shriram Interio. Read testimonials and watch video reviews from homeowners across Pune.'),
('customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio Design Projects', 'Explore detailed stories of our interior design projects. See before-and-after galleries and read about our process for transforming homes in Pune.'),
('products', 'Products', 'Our Products | High-Quality Interior Solutions', 'Browse our range of high-quality products, including modular kitchens, custom wardrobes, bedroom sets, and more. All crafted with precision and designed for life.'),
('how-it-works', 'How It Works', 'How It Works | Our Interior Design Process', 'Understand our seamless 6-step interior design process, from initial consultation and 3D visualization to manufacturing, installation, and post-project support.'),
('services', 'Services', 'Our Services | Comprehensive Interior Design Solutions', 'Discover our wide range of interior design services, including modular kitchens, full home interiors, exterior design, and turnkey project management.'),
('portfolio', 'Portfolio', 'Our Portfolio | Shriram Interio Design Gallery', 'View our portfolio of completed interior design projects. Get inspired by our work in living areas, kitchens, wardrobes, and more across Pune.'),
('contact', 'Contact', 'Contact Us | Get in Touch with Shriram Interio', 'Contact Shriram Interio for a free consultation. Find our address, phone number, and email, or use our contact form to get in touch.'),
('appointment', 'Appointment', 'Book an Appointment | Shriram Interio', 'Schedule a free, no-obligation consultation with our expert interior designers. Book your appointment online today.');

-- Assuming the page IDs are 1 through 10 in the order they were inserted.
-- You may need to adjust these IDs based on your actual database state.

-- HOME PAGE SECTIONS (page_id = 1)
INSERT INTO public.sections (page_id, type, title, "order", visible, content_structure, content)
VALUES
(1, 'hero', 'Hero Section', 1, true, 
'{
  "title": {"type": "text", "label": "Main Headline"},
  "subtitle": {"type": "textarea", "label": "Sub-headline"},
  "buttonText": {"type": "text", "label": "Button Text"},
  "videoUrl": {"type": "text", "label": "Background Video URL"},
  "slides": {"type": "repeater", "label": "Image Slides"}
}',
'{
  "title": "Crafting Dream Spaces, From Concept to Reality",
  "subtitle": "Pune''s leading interior design company for modular kitchens, wardrobes, and full home interiors. Experience the perfect blend of style, functionality, and craftsmanship.",
  "buttonText": "Explore Our Services",
  "videoUrl": "https://videos.pexels.com/video-files/4424849/4424849-hd_1920_1080_25fps.mp4",
  "slides": [
    {"image": "https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80"},
    {"image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1920&q=80"}
  ]
}'),
(1, 'welcome', 'Welcome Section', 2, true,
'{
  "paragraph1": {"type": "textarea", "label": "First Paragraph"},
  "paragraph2": {"type": "textarea", "label": "Second Paragraph"},
  "image": {"type": "image", "label": "Welcome Image"}
}',
'{
  "paragraph1": "We specialize in crafting bespoke interiors that reflect your personality and lifestyle. At Shriram Interio, we believe that a home is more than just a place; it''s a feeling, an experience, a sanctuary. Our team of expert designers and skilled craftsmen work in harmony to bring your vision to life, ensuring every detail is perfect.",
  "paragraph2": "From stunning modular kitchens to elegant wardrobes and complete home makeovers, we are committed to delivering excellence and innovation. Explore our world of design and let us help you create a space that you''ll love for years to come.",
  "image": "https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbnRlcmlvciUyMGRlc2lnbnxlbnwwfHx8fDE3NTU2MjQ1MTB8MA&ixlib=rb-4.1.0&q=80&w=1080"
}'),
(1, 'about_company', 'About Company', 3, true,
'{
  "title": {"type": "text", "label": "Section Title"},
  "text": {"type": "textarea", "label": "Company Description"}
}',
'{
  "title": "About Company",
  "text": "is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul."
}'),
(1, 'why_us', 'Why Us Section', 4, true,
'{
  "title": {"type": "text", "label": "Section Title"},
  "subtitle": {"type": "textarea", "label": "Section Subtitle"},
  "items": {"type": "repeater", "label": "Reasons"}
}',
'{
  "title": "Why Shriram Interio?",
  "subtitle": "We deliver excellence in every project, ensuring customer satisfaction.",
  "items": [
    {"title": "Expert Design Team", "description": "Our team of experienced designers ensures your vision comes to life with creativity and precision."},
    {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit your style and budget."},
    {"title": "Affordable Design Fees", "description": "Get premium interior design services at competitive and transparent prices."},
    {"title": "On-Time Project Delivery", "description": "We are committed to delivering your project on schedule, without compromising on quality."}
  ]
}'),
(1, 'work_gallery', 'Work Gallery', 5, true,
'{
  "title": {"type": "text", "label": "Gallery Title"},
  "subtitle": {"type": "textarea", "label": "Gallery Subtitle"},
  "items": {"type": "repeater", "label": "Gallery Images"}
}',
'{
  "title": "Our Work Gallery",
  "subtitle": "A glimpse into the spaces we''ve transformed.",
  "items": [
    {"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"},
    {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"},
    {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"},
    {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"},
    {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}
  ]
}'),
(1, 'comfort_design', 'Comfort Design', 6, true,
'{
  "title": {"type": "text", "label": "Section Title"},
  "subtitle": {"type": "textarea", "label": "Section Subtitle"},
  "items": {"type": "repeater", "label": "Comfort Features"}
}',
'{
  "title": "Interior Design At Your Comfort",
  "subtitle": "The future of interior design is here. With our contactless interior design process, we bring your dream home to life, from the comfort of your couch.",
  "items": [
    {"title": "Live 3D Designs", "description": "Get a realistic feel of your home interiors with our live 3D designs."},
    {"title": "Contactless Experience", "description": "A safe and seamless interior design experience, from start to finish."},
    {"title": "Instant Pricing", "description": "Transparent quotes for your home interiors from the word go."},
    {"title": "Expertise & Passion", "description": "Our team of interior designers have over 21 years of experience."}
  ]
}'),
(1, 'what_we_do', 'What We Do', 7, true,
'{
  "title": {"type": "text", "label": "Section Title"},
  "subtitle": {"type": "textarea", "label": "Section Subtitle"},
  "trendingItems": {"type": "repeater", "label": "Trending Items"},
  "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens"},
  "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes"}
}',
'{
  "title": "What We Do",
  "subtitle": "We offer a wide range of interior design solutions to suit your needs.",
  "trendingItems": [
    {"name": "Elegant U-Shaped Kitchen", "image": "/trending1.jpg", "hint": "u-shaped kitchen"},
    {"name": "Modern Living Room", "image": "/trending2.jpg", "hint": "modern living room"},
    {"name": "Sleek Sliding Wardrobe", "image": "/trending3.jpg", "hint": "sliding wardrobe"},
    {"name": "Cozy Bedroom Interior", "image": "/trending4.jpg", "hint": "cozy bedroom"}
  ],
  "bestSellingKitchens": [
    {"name": "Classic L-Shape", "image": "/kitchen-1.png", "hint": "l-shaped kitchen"},
    {"name": "Modern Island", "image": "/kitchen-2.png", "hint": "island kitchen"},
    {"name": "Compact Straight", "image": "/kitchen-3.png", "hint": "straight kitchen"},
    {"name": "Spacious U-Shape", "image": "/kitchen-4.png", "hint": "u-shaped kitchen"}
  ],
  "bestSellingWardrobes": [
    {"name": "Sliding Door", "image": "/wardrobe-1.png", "hint": "sliding wardrobe"},
    {"name": "Walk-in Wonder", "image": "/wardrobe-2.png", "hint": "walk-in wardrobe"},
    {"name": "Classic Hinge", "image": "/wardrobe-3.png", "hint": "hinged wardrobe"},
    {"name": "Freestanding Unit", "image": "/wardrobe-4.png", "hint": "freestanding wardrobe"}
  ]
}'),
(1, 'testimonials', 'Testimonials', 8, true,
'{
  "title": {"type": "text", "label": "Section Title"},
  "subtitle": {"type": "textarea", "label": "Section Subtitle"},
  "buttonText": {"type": "text", "label": "Button Text"},
  "items": {"type": "repeater", "label": "Testimonials"}
}',
'{
  "title": "What Our Clients Say",
  "subtitle": "We have successfully designed and delivered over 75,000 homes.",
  "buttonText": "View All Testimonials",
  "items": [
    {"name": "Anjali P. (Kothrud)", "review": "Shriram Interio transformed our home! The kitchen is a dream to work in, and the team was professional from start to finish.", "image": "/avatar-1.png"},
    {"name": "Rohan & Priya S. (Hinjewadi)", "review": "The design process was so transparent and collaborative. They listened to our needs and delivered beyond our expectations.", "image": "/avatar-2.png"},
    {"name": "Meera K. (Baner)", "review": "Excellent service and stunning wardrobe design. The quality of materials is top-notch, and the installation was seamless.", "image": "/avatar-3.png"}
  ]
}'),
(1, 'faq', 'FAQ Section', 9, true,
'{
  "title": {"type": "text", "label": "FAQ Title"},
  "subtitle": {"type": "textarea", "label": "FAQ Subtitle"},
  "items": {"type": "repeater", "label": "FAQ Items"}
}',
'{
  "title": "Frequently Asked Questions",
  "subtitle": "Have questions? We have answers.",
  "items": [
    {"question": "What services do you offer?", "answer": "We offer a comprehensive range of interior design services, including modular kitchens, custom wardrobes, full home interiors, living area design, bedroom design, and more."},
    {"question": "What is your design process?", "answer": "Our process begins with a free consultation, followed by 3D design and visualization, material selection, manufacturing, and finally, professional installation."},
    {"question": "How much does interior design cost?", "answer": "The cost varies depending on the project scope, materials, and space size. We provide transparent pricing and detailed quotes after the initial consultation."},
    {"question": "How long does a project typically take?", "answer": "A typical project can range from a few weeks for a single room to a few months for a full home interior. We provide a detailed timeline after understanding your requirements."}
  ]
}'),
(1, 'partners', 'Partners Section', 10, true,
'{
  "title": {"type": "text", "label": "Section Title"},
  "subtitle": {"type": "textarea", "label": "Section Subtitle"},
  "items": {"type": "repeater", "label": "Partner Logos"}
}',
'{
  "title": "Our Partners",
  "subtitle": "MEET OUR PARTNERS",
  "items": [
    {"name": "Ebco", "logoSrc": "/ebco.jpg"},
    {"name": "Hettich", "logoSrc": "/hettich.png"},
    {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"},
    {"name": "Hafele", "logoSrc": "/hafele.png"},
    {"name": "Godrej", "logoSrc": "/godrej.png"}
  ]
}');

-- ABOUT US PAGE SECTIONS (page_id = 2)
INSERT INTO public.sections (page_id, type, title, "order", visible, content_structure, content)
VALUES
(2, 'hero', 'Hero Section', 1, true, 
'{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "backgroundImage": {"type": "image", "label": "Background Image"}
}', 
'{
    "title": "About Shriram Interio",
    "subtitle": "Designing spaces that inspire and innovate.",
    "backgroundImage": "https://images.unsplash.com/photo-1522771739844-6a9f6d5f14aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxpbnRlcmlvcnxlbnwwfHx8fDE3NTU2MjM5NjR8MA&ixlib=rb-4.1.0&q=80&w=1080"
}'),
(2, 'story', 'Our Story', 2, true,
'{
    "heading": {"type": "text", "label": "Heading"},
    "subheading": {"type": "text", "label": "Subheading"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
    "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
    "image": {"type": "image", "label": "Story Image"}
}',
'{
    "heading": "Our Story",
    "subheading": "A Journey of Creativity and Passion",
    "paragraph1": "SHRIRAM INTERIO is a place where design meets inspiration and innovation. Founded on the belief that exceptional design transforms lives, we are a team of passionate creatives dedicated to curating spaces that resonate with your soul.",
    "paragraph2": "Since our establishment in 2016, our journey began with a shared vision: to redefine interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we''ve evolved, but our commitment to excellence remains unwavering.",
    "paragraph3": "Every project we undertake is a testament to our dedication to craftsmanship and attention to detail. We collaborate closely with our clients, understanding their aspirations and translating them into tangible, breathtaking realities. Our design philosophy revolves around creating spaces that not only look stunning but also enhance the well-being and lifestyle of those who inhabit them.",
    "paragraph4": "At SHRIRAM INTERIO, we don''t just design interiors; we craft experiences. Join us on this creative journey, and let''s build something extraordinary together.",
    "image": "https://images.unsplash.com/photo-1549490014-b52f8a813837?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHx0ZWFtJTIwY29sbGFib3JhdGlvbnxlbnwwfHx8fDE3NTYwMTE3OTR8MA&ixlib=rb-4.1.0&q=80&w=1080"
}'),
(2, 'journey', 'Our Journey', 3, true,
'{
    "heading": {"type": "text", "label": "Heading"},
    "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
    "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
    "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
    "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
    "image": {"type": "image", "label": "Journey Image"}
}',
'{
    "heading": "Our Journey",
    "paragraph1": "Our story is one of passion, persistence, and the pursuit of perfection. From humble beginnings, we have grown into a leading name in Pune''s interior design landscape. It all started with a small team of dedicated designers who shared a common dream: to make high-quality, bespoke interior design accessible to everyone.",
    "paragraph2": "We faced challenges, learned from our experiences, and continuously honed our craft. Our breakthrough came with our first full-home interior project, which was featured in a local design magazine. This recognition fueled our passion and set us on a path of growth and innovation.",
    "paragraph3": "Today, we have a diverse portfolio of residential and commercial projects, each one a unique reflection of our clients'' dreams and our design expertise. Our state-of-the-art manufacturing unit allows us to maintain strict quality control and deliver custom solutions with precision.",
    "paragraph4": "Our journey is far from over. We are constantly exploring new trends, materials, and technologies to push the boundaries of design and create spaces that are not only beautiful but also sustainable and future-ready.",
    "image": "https://images.unsplash.com/photo-1517048676732-d65bc937f952?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxqb3VybmV5fGVufDB8fHx8MTc1NjAxMTgzNHww&ixlib=rb-4.1.0&q=80&w=1080"
}'),
(2, 'values', 'Our Values', 4, true,
'{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "items": {"type": "repeater", "label": "Values"}
}',
'{
    "title": "Our Values",
    "subtitle": "The principles that guide our work and define our commitment to you.",
    "items": [
        {"title": "Expert Design Team", "description": "Our team of experienced designers ensures your vision comes to life with creativity and precision."},
        {"title": "Variety of Design Choices", "description": "We offer a wide range of designs and materials to suit your style and budget."},
        {"title": "Affordable Design Fees", "description": "Get premium interior design services at competitive and transparent prices."},
        {"title": "On-Time Project Delivery", "description": "We are committed to delivering your project on schedule, without compromising on quality."}
    ]
}'),
(2, 'mission_vision', 'Mission and Vision', 5, true,
'{
    "visionTitle": {"type": "text", "label": "Vision Title"},
    "visionText": {"type": "textarea", "label": "Vision Text"},
    "missionTitle": {"type": "text", "label": "Mission Title"},
    "missionText": {"type": "textarea", "label": "Mission Text"}
}',
'{
    "visionTitle": "Our Vision",
    "visionText": "To be the most trusted and sought-after interior design firm in Pune, known for our innovative designs, exceptional quality, and unwavering commitment to client satisfaction. We aim to create spaces that not only look spectacular but also enhance the quality of life.",
    "missionTitle": "Our Mission",
    "missionText": "Our mission is to transform our clients'' living and working environments by providing personalized, high-quality, and sustainable interior design solutions. We strive to deliver every project on time and within budget, ensuring a seamless and enjoyable experience for our clients from concept to completion."
}'),
(2, 'team', 'Meet the Team', 6, true,
'{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "text", "label": "Subtitle"},
    "members": {"type": "repeater", "label": "Team Members"}
}',
'{
    "title": "Meet the Team",
    "subtitle": "The creative minds behind your beautiful spaces.",
    "members": [
        {
            "name": "Prakash Shriram",
            "role": "Founder & Lead Designer",
            "bio": "With over 20 years of experience, Prakash leads our creative team with a passion for innovation and a deep understanding of design principles.",
            "image": "https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMG1hbGV8ZW58MHx8fHwxNzU2MDExOTA1fDA&ixlib=rb-4.1.0&q=80&w=1080"
        },
        {
            "name": "Sunita Pawar",
            "role": "Project Manager",
            "bio": "Sunita ensures that every project runs smoothly, on time, and within budget, coordinating between clients, designers, and craftsmen.",
            "image": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHdvbWFufGVufDB8fHx8MTc1NjAxMTkzMnww&ixlib=rb-4.1.0&q=80&w=1080"
        },
        {
            "name": "Rajesh Verma",
            "role": "Head of Operations",
            "bio": "Rajesh oversees our manufacturing unit and logistics, guaranteeing the highest quality standards for all our materials and products.",
            "image": "https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxwb3J0cmFpdCUyMG1hbGV8ZW58MHx8fHwxNzU2MDExOTA1fDA&ixlib=rb-4.1.0&q=80&w=1080"
        }
    ]
}');

-- Add more sections for other pages as needed...

-- Example for Products Page (page_id = 5)
INSERT INTO public.sections (page_id, type, title, "order", visible, content_structure, content)
VALUES
(5, 'product_list', 'Product List', 1, true, 
'{
    "title": {"type": "text", "label": "Page Title"},
    "subtitle": {"type": "text", "label": "Page Subtitle"},
    "products": {"type": "repeater", "label": "Products"}
}', 
'{
    "title": "Our Products",
    "subtitle": "Crafted with precision, designed for life.",
    "products": [
      {
        "name": "Modular Kitchens",
        "href": "/products/kitchen",
        "imageSrc": "https://images.unsplash.com/photo-1559554704-0f74b35a8718?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwyfHxtb2R1bGFyJTIwa2l0Y2hlbnxlbnwwfHx8fDE3NTU3MTUzMDJ8MA&ixlib=rb-4.1.0&q=80&w=1080",
        "dataAiHint": "modern kitchen",
        "description": "Explore our stunning range of modular kitchens, designed for style and efficiency."
      },
      {
        "name": "Wardrobes",
        "href": "/products/wardrobe",
        "imageSrc": "https://images.unsplash.com/photo-1614631446501-abcf76949eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwzfHx3YXJkcm9iZXN8ZW58MHx8fHwxNzU1NzE1MzkxfDA&ixlib=rb-4.1.0&q=80&w=1080",
        "dataAiHint": "modern wardrobe",
        "description": "Discover custom wardrobe solutions that maximize space and complement your decor."
      },
      {
        "name": "Bedroom",
        "href": "/products/bedroom",
        "imageSrc": "/b1.jpg",
        "dataAiHint": "modern bedroom",
        "description": "Create your dream sanctuary with our bespoke bedroom interior designs."
      },
      {
        "name": "Living Room",
        "href": "/products/living-room",
        "imageSrc": "/b2.jpg",
        "dataAiHint": "living room",
        "description": "Design inviting and functional living spaces for family and friends."
      },
      {
        "name": "Bathroom",
        "href": "/products/bathroom",
        "imageSrc": "/bath.jpg",
        "dataAiHint": "modern bathroom",
        "description": "Stylish and practical bathroom designs for a refreshing experience."
      },
      {
        "name": "Space Saving Furniture",
        "href": "/products/space-saving-furniture",
        "imageSrc": "/SlidingWardrobe.jpg",
        "dataAiHint": "space saving",
        "description": "Maximize your living area with our innovative and smart furniture solutions."
      },
      {
        "name": "Home Office",
        "href": "/products/home-office",
        "imageSrc": "/kitchen.jpg",
        "dataAiHint": "home office",
        "description": "Productive and comfortable home office setups tailored to your needs."
      }
    ]
}');
