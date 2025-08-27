
-- This file seeds the data for the Customer Stories page and the individual story pages.

-- Create Customer Stories Page
INSERT INTO public.pages (slug, title, meta_title, meta_description) VALUES
('customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio', 'Read inspiring stories from our happy customers.')
ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  meta_title = EXCLUDED.meta_title,
  meta_description = EXCLUDED.meta_description;

-- Customer Stories Page Sections
INSERT INTO public.sections (page_id, type, title, content, content_structure, "order", visible) VALUES
((SELECT id from pages where slug = 'customer-stories'), 'header', 'Header',
'{"title": "Customer Stories", "subtitle": "Discover how we''ve transformed houses into homes, told through the experiences of our valued clients."}',
'{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}}', 0, true),

((SELECT id from pages where slug = 'customer-stories'), 'featured_story', 'Featured Story',
'{"buttonText": "Read Full Story"}',
'{"buttonText": {"label": "Button Text", "type": "text"}}', 1, true),

((SELECT id from pages where slug = 'customer-stories'), 'more_stories', 'More Stories',
'{
    "title": "More Inspiring Stories",
    "stories": [
        {
            "slug": "manikandan-kruthhikka",
            "image": "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBwZXJzb258ZW58MHx8fHwxNzU2MTk0ODk1fDA&ixlib=rb-4.1.0&q=80&w=1080",
            "dataAiHint": "smiling person",
            "category": "Kitchen Renovation",
            "title": "A Kitchen That Breathes Life",
            "excerpt": "Manikandan & Kruthhikka were impressed by the experienced HomeLane designers and how they were able to understand their vision for their home.",
            "author": "Manikandan & Kruthhikka",
            "authorAvatar": "/avatar-1.png",
            "date": "2024-05-15"
        },
        {
            "slug": "anitha-mahendiran",
            "image": "https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080",
            "dataAiHint": "smiling woman",
            "category": "Full Home Interior",
            "title": "Bringing a Dream Home to Life",
            "excerpt": "HomeLane brought Anitha''s dream home to life for her, just the way she envisioned It. She got the best price and the quality she was looking for.",
            "author": "Anitha & Mahendiran",
            "authorAvatar": "/avatar-2.png",
            "date": "2024-04-22"
        }
    ]
}',
'{"title": {"label": "Section Title", "type": "text"}, "stories": {"label": "Stories", "type": "repeater"}}', 2, true),

((SELECT id from pages where slug = 'customer-stories'), 'work_gallery', 'Work Gallery',
'{
    "title": "Our Customers’ Homes",
    "subtitle": "Explore the stunning transformations we’ve delivered for our clients. Each project reflects a unique story of collaboration and craftsmanship, turning houses into personalized dream homes.",
    "items": [
        {"image": "/b2.jpg", "hint": "modern living room", "title": "Modern Living Room"},
        {"image": "/b1.jpg", "hint": "elegant kitchen", "title": "Elegant Kitchen Design"},
        {"image": "/kitchen.jpg", "hint": "cozy bedroom", "title": "Cozy Bedroom Interior"},
        {"image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe", "title": "Luxury Wardrobe"},
        {"image": "/kitchengallery.jpg", "hint": "contemporary space", "title": "Contemporary Space"}
    ]
}',
'{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "Gallery Items", "type": "repeater"}}', 3, true),

((SELECT id from pages where slug = 'customer-stories'), 'partners', 'Partners',
'{
    "title": "Our Trusted Partners",
    "subtitle": "QUALITY, OUR #1 PRIORITY",
    "items": [
        { "name": "Ebco", "logoSrc": "/ebco.jpg" },
        { "name": "Hettich", "logoSrc": "/hettich.png" },
        { "name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg" },
        { "name": "Hafele", "logoSrc": "/hafele.png" },
        { "name": "Godrej", "logoSrc": "/godrej.png" }
    ]
}',
'{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "items": {"label": "Partners", "type": "repeater"}}', 4, true),

((SELECT id from pages where slug = 'customer-stories'), 'faq', 'FAQ',
'{
    "title": "Frequently Asked Questions",
    "subtitle": "Find answers to common questions about our process, services, and how we can help you create your dream space.",
    "items": [
        {
            "question": "How do I get started with a project?",
            "answer": "The best way to start is by booking a free consultation through our website. Our design experts will connect with you to understand your requirements, budget, and vision."
        },
        {
            "question": "Can I see a design before I commit?",
            "answer": "Absolutely! We provide detailed 2D and 3D designs, along with live 3D visualization sessions. This allows you to see exactly how your space will look and make changes before we begin manufacturing."
        },
        {
            "question": "Do you handle projects outside of Pune?",
            "answer": "Currently, our primary focus is on projects within Pune and the surrounding areas. However, for large-scale projects, we may consider other locations. Please contact us to discuss your specific needs."
        }
    ]
}',
'{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "FAQ Items", "type": "repeater"}}', 5, true)
ON CONFLICT (page_id, type) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  content_structure = EXCLUDED.content_structure,
  "order" = EXCLUDED."order",
  visible = EXCLUDED.visible;

-- Individual Customer Stories
DROP TABLE IF EXISTS public.stories;
CREATE TABLE public.stories (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug text NOT NULL UNIQUE,
    category text,
    title text,
    image text,
    "dataAiHint" text,
    excerpt text,
    author text,
    "authorAvatar" text,
    date text,
    "clientImage" text,
    location text,
    project text,
    size text,
    quote text,
    content text,
    gallery jsonb
);

INSERT INTO public.stories (slug, category, title, image, "dataAiHint", excerpt, author, "authorAvatar", date, "clientImage", location, project, size, quote, content, gallery) VALUES
('jigar-and-ishita', 'Full Home Interior', 'A Vision of Modern Comfort in Mumbai', 'https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFuJTIwaW5kaWFufGVufDB8fHx8MTc1NjA0NjY0OHww&ixlib=rb-4.1.0&q=80&w=1080', 'smiling man', 'Jigar & Ishita partnered with Shriram Interio to create a home that was both intelligent and beautiful, making the most of every square foot.', 'Jigar & Ishita', '/avatar-4.png', '2024-06-12', 'https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFuJTIwaW5kaWFufGVufDB8fHx8MTc1NjA0NjY0OHww&ixlib=rb-4.1.0&q=80&w=1080', 'Mumbai', 'Tirumala Habitats', '4 BHK', 'Shriram Interio''s Design Expert made intelligent use of the available space to bring our dream home interiors to life.', '<p>Shriram Interio designed our dream home very efficiently. I was out-of-station while the work was going on, and yet the design experience was hassle-free and fast. We are happy with our home interiors. Our friends also have only good things to say about the designs.</p><p>From the initial consultation to the final handover, the team was professional and accommodating. They took our inputs seriously and came up with creative solutions that we wouldn''t have thought of on our own. The quality of the materials and the finish is excellent. We couldn''t be happier with our new home.</p>', '[{"src": "/kitchen.jpg", "alt": "Modern Kitchen", "dataAiHint": "modern kitchen"}, {"src": "/b1.jpg", "alt": "Cozy Bedroom", "dataAiHint": "cozy bedroom"}, {"src": "/b2.jpg", "alt": "Living Area", "dataAiHint": "living area"}, {"src": "/r1.jpg", "alt": "Wardrobe", "dataAiHint": "wardrobe"}, {"src": "/rv.jpg", "alt": "TV Unit", "dataAiHint": "tv unit"}, {"src": "/industrial.jpg", "alt": "Balcony", "dataAiHint": "balcony"}]'),
('manikandan-kruthhikka', 'Kitchen Renovation', 'A Kitchen That Breathes Life', 'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBwZXJzb258ZW58MHx8fHwxNzU2MTk0ODk1fDA&ixlib=rb-4.1.0&q=80&w=1080', 'smiling person', 'Manikandan & Kruthhikka were impressed by the experienced HomeLane designers and how they were able to understand their vision for their home.', 'Manikandan & Kruthhikka', '/avatar-1.png', '2024-05-15', 'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxpbmRpYW4lMjBwZXJzb258ZW58MHx8fHwxNzU2MTk0ODk1fDA&ixlib=rb-4.1.0&q=80&w=1080', 'Subramaniya Nagar, Chennai', 'Personal Residence', '3 BHK', 'The designers understood our vision perfectly. HomeLane made sure everything was personalised to match our requirements and comfort.', '<p>Manikandan & Kruthhikka were impressed by the experienced HomeLane designers and how they were able to understand their vision for their home. HomeLane made sure everything was personalised to match the requirements and comfort of the family. Book your free consultation today.</p>', '[{"src": "/kitchen2.jpg", "alt": "Renovated Kitchen", "dataAiHint": "renovated kitchen"}]'),
('anitha-mahendiran', 'Full Home Interior', 'Bringing a Dream Home to Life', 'https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080', 'smiling woman', 'HomeLane brought Anitha''s dream home to life for her, just the way she envisioned It. She got the best price and the quality she was looking for.', 'Anitha & Mahendiran', '/avatar-2.png', '2024-04-22', 'https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080', 'Parappalayam, Coimbatore', 'New Apartment', '2 BHK', 'HomeLane brought my dream home to life, just the way I envisioned it. The designer delivered everything on time and with the highest quality.', '<p>HomeLane brought Anitha''s dream home to life for her, just the way she envisioned It. After doing some research she chose HomeLane where she got the best price and the quality she was looking for. The HomeLane designer delivered all the requirements before time and with the highest quality possible.</p>', '[{"src": "/living-room.jpg", "alt": "Beautiful Living Room", "dataAiHint": "beautiful living room"}]');

ALTER TABLE public.stories ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public stories are viewable by everyone." ON public.stories FOR SELECT USING (true);
