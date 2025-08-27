
-- Create the pages table to store page-level information
CREATE TABLE IF NOT EXISTS public.pages (
    id SERIAL PRIMARY KEY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    meta_title TEXT,
    meta_description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the sections table to store content for different sections of a page
CREATE TABLE IF NOT EXISTS public.sections (
    id SERIAL PRIMARY KEY,
    page_id INTEGER REFERENCES public.pages(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    visible BOOLEAN DEFAULT TRUE,
    content JSONB,
    content_structure JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create the stories table for customer stories
CREATE TABLE IF NOT EXISTS public.stories (
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
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- Upsert page data for 'customer-stories'
INSERT INTO public.pages (slug, title, meta_title, meta_description)
VALUES ('customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio', 'Read inspiring stories from our happy clients and see how we transformed their homes.')
ON CONFLICT(slug) DO UPDATE SET
  title = EXCLUDED.title,
  meta_title = EXCLUDED.meta_title,
  meta_description = EXCLUDED.meta_description;

DO $$
DECLARE
  page_id INTEGER;
BEGIN
  -- Get the ID of the 'customer-stories' page
  SELECT id INTO page_id FROM public.pages WHERE slug = 'customer-stories';

  -- Upsert sections for 'customer-stories' page
  INSERT INTO public.sections (page_id, type, title, "order", visible, content, content_structure)
  VALUES
    (page_id, 'header', 'Header', 1, TRUE,
      '{"title": "Customer Stories", "subtitle": "Discover how we''ve transformed homes and lives with our passion for design and commitment to quality."}',
      '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}}'
    ),
    (page_id, 'featured_story', 'Featured Story', 2, TRUE,
      '{"buttonText": "Read Their Story"}',
      '{"buttonText": {"label": "Button Text", "type": "text"}}'
    ),
    (page_id, 'more_stories', 'More Stories', 3, TRUE,
      '{"title": "More Success Stories"}',
      '{"title": {"label": "Title", "type": "text"}}'
    ),
    (page_id, 'work_gallery', 'Work Gallery', 4, TRUE,
      '{"title": "Our Work Gallery", "subtitle": "Explore our portfolio of stunning interior designs, showcasing our commitment to quality and style.", "items": [{"title": "Modern Living Room", "image": "/b2.jpg", "hint": "modern living room"}, {"title": "Elegant Kitchen Design", "image": "/b1.jpg", "hint": "elegant kitchen"}, {"title": "Cozy Bedroom Interior", "image": "/kitchen.jpg", "hint": "cozy bedroom"}, {"title": "Luxury Wardrobe", "image": "/SlidingWardrobe.jpg", "hint": "luxury wardrobe"}, {"title": "Contemporary Space", "image": "/kitchengallery.jpg", "hint": "contemporary space"}]}',
      '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "Gallery Items", "type": "repeater"}}'
    ),
    (page_id, 'partners', 'Partners', 5, TRUE,
      '{"title": "Our Trusted Partners", "subtitle": "QUALITY ASSURANCE", "items": [{"name": "Ebco", "logoSrc": "/ebco.jpg"}, {"name": "Hettich", "logoSrc": "/hettich.png"}, {"name": "Royale Touche", "logoSrc": "/Royal-Touch.jpg"}, {"name": "Hafele", "logoSrc": "/hafele.png"}, {"name": "Godrej", "logoSrc": "/godrej.png"}]}',
      '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "text"}, "items": {"label": "Partner Logos", "type": "repeater"}}'
    ),
    (page_id, 'faq', 'FAQ', 6, TRUE,
      '{"title": "Frequently Asked Questions", "subtitle": "Find answers to common questions about our services and processes.", "items": [{"question": "How do I start a project with Shriram Interio?", "answer": "Simply book a free consultation through our website. Our team will get in touch with you to discuss your requirements and get the project started."}, {"question": "Can I see the designs before they are finalized?", "answer": "Absolutely! We provide detailed 3D visualizations of your space, allowing you to see exactly how it will look and make any necessary changes before we begin manufacturing."}, {"question": "What is the expected timeline for a project?", "answer": "The timeline depends on the scope of the project. A standard modular kitchen may take 4-6 weeks, while a full home interior project can take longer. We provide a detailed schedule before we start."}, {"question": "Do you offer a warranty on your work?", "answer": "Yes, we offer a one-year warranty on all our interior work, giving you complete peace of mind."}]}',
      '{"title": {"label": "Title", "type": "text"}, "subtitle": {"label": "Subtitle", "type": "textarea"}, "items": {"label": "FAQ Items", "type": "repeater"}}'
    )
  ON CONFLICT (page_id, type) DO UPDATE SET
    title = EXCLUDED.title,
    "order" = EXCLUDED.order,
    visible = EXCLUDED.visible,
    content = EXCLUDED.content,
    content_structure = EXCLUDED.content_structure;
END $$;


-- Insert stories
INSERT INTO public.stories (slug, title, category, excerpt, image, "dataAiHint", author, "authorAvatar", date, "clientImage", location, project, size, quote, content, gallery)
VALUES
  ('the-mehtas-dream-kitchen', 'The Mehtas’ Dream Kitchen', 'Kitchens', 'See how we transformed a cramped kitchen into a spacious, functional, and beautiful culinary haven for the Mehta family.', 'https://images.unsplash.com/photo-1599693496536-435ebb353712?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2MTk0OTMwfDA&ixlib=rb-4.1.0&q=80&w=1080', 'indian couple', 'The Mehta Family', '/avatar-1.png', 'June 15, 2024', 'https://images.unsplash.com/photo-1599693496536-435ebb353712?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxpbmRpYW4lMjBjb3VwbGV8ZW58MHx8fHwxNzU2MTk0OTMwfDA&ixlib=rb-4.1.0&q=80&w=1080', 'Koregaon Park, Pune', 'Kitchen Renovation', '120 sq ft', 'Shriram Interio understood our needs perfectly and delivered a kitchen that is both stunning and incredibly practical.', '<p>The Mehta family''s kitchen was a classic case of a space that had outgrown its purpose. With a growing family and a passion for cooking, they needed a kitchen that was more than just a place to prepare meals; they needed a hub for family life.</p><p>Our design team worked closely with them to create a modern, open-plan kitchen. We knocked down a non-structural wall to merge the kitchen with the dining area, creating a seamless flow. The new layout features a central island, ample storage with floor-to-ceiling cabinets, and state-of-the-art appliances.</p><p>The result is a bright, airy space that has become the heart of their home. "We spend more time together as a family now," says Mrs. Mehta. "The kids do their homework at the island while I cook, and we love hosting friends. Shriram Interio didn''t just give us a new kitchen; they gave us a new way of living."</p>', '[{"src": "/kitchen.jpg", "alt": "The new spacious kitchen island", "dataAiHint": "kitchen island"}, {"src": "/kitchen2.jpg", "alt": "Smart storage solutions", "dataAiHint": "kitchen cabinets"}, {"src": "/kitchn1.jpg", "alt": "The happy Mehta family in their new kitchen", "dataAiHint": "happy family kitchen"}]'),
  ('anjalis-wardrobe-wonder', 'Anjali’s Wardrobe Wonder', 'Wardrobes', 'A walk-in wardrobe that balances luxury, organization, and style, creating a personal boutique experience for Anjali.', 'https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080', 'smiling woman', 'Anjali Rao', '/avatar-2.png', 'May 28, 2024', 'https://images.unsplash.com/photo-1543165384-245f3a093754?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw0fHxzbWlsaW5nJTIwd29tYW58ZW58MHx8fHwxNzU2MDQ2NTYxfDA&ixlib=rb-4.1.0&q=80&w=1080', 'Baner, Pune', 'Walk-in Wardrobe', '80 sq ft', '"My wardrobe is now my favorite room in the house! It’s so organized and beautiful, it feels like my own private boutique."', '<p>Anjali, a fashion blogger, needed a wardrobe that could keep up with her dynamic collection of clothes, shoes, and accessories. Her existing closet was a chaotic space that stifled her creativity. She dreamed of a walk-in wardrobe that was both highly organized and aesthetically pleasing.</p><p>Our team designed a custom walk-in closet with dedicated zones for different items. We used a mix of open shelving, glass-fronted drawers, and hanging spaces to create a visually appealing and functional layout. A central vanity with a large, well-lit mirror adds a touch of glamour and provides the perfect spot for her to get ready.</p><p>The use of light wood finishes and soft, ambient lighting makes the space feel warm and inviting. "It’s a dream come true," Anjali says. "Getting dressed in the morning is now a joyful experience. The team at Shriram Interio was brilliant."</p>', '[{"src": "/r1.jpg", "alt": "The organized walk-in wardrobe", "dataAiHint": "walk-in wardrobe"}, {"src": "/SlidingWardrobe.jpg", "alt": "Detail of the shoe storage", "dataAiHint": "shoe storage"}, {"src": "/b1.jpg", "alt": "The central vanity unit", "dataAiHint": "vanity mirror"}]'),
  ('rohans-serene-sanctuary', 'Rohan’s Serene Sanctuary', 'Bedroom', 'From a cluttered room to a minimalist sanctuary, this bedroom transformation focuses on tranquility and style.', 'https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFuJTIwaW5kaWFufGVufDB8fHx8MTc1NjA0NjY0OHww&ixlib=rb-4.1.0&q=80&w=1080', 'smiling man', 'Rohan Desai', '/avatar-3.png', 'April 19, 2024', 'https://images.unsplash.com/photo-1557862921-37829c790f19?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxfHxzbWlsaW5nJTIwbWFuJTIwaW5kaWFufGVufDB8fHx8MTc1NjA0NjY0OHww&ixlib=rb-4.1.0&q=80&w=1080', 'Hinjewadi, Pune', 'Bedroom Interior', '150 sq ft', '"They transformed my chaotic bedroom into a peaceful retreat. I sleep so much better now. The attention to detail is incredible."', '<p>Rohan wanted a bedroom that felt like a escape from his busy work life. His room was functional but lacked personality and a sense of calm. He wanted a minimalist design that was clean, uncluttered, and conducive to relaxation.</p><p>We focused on a neutral color palette of soft greys, whites, and natural wood tones. The furniture is simple and functional, with clean lines and a low profile. A statement headboard with integrated lighting adds a touch of sophistication, while a cozy reading nook by the window provides a perfect spot to unwind.</p><p>Storage was a key consideration. We designed a sleek, built-in wardrobe that blends seamlessly with the wall, providing ample storage without visually cluttering the space. "I never thought my room could feel this spacious and calming," says Rohan. "The team at Shriram Interio really listened to what I wanted and created the perfect sanctuary for me."</p>', '[{"src": "/industrial.jpg", "alt": "The minimalist bedroom design", "dataAiHint": "minimalist bedroom"}, {"src": "/b2.jpg", "alt": "The cozy reading nook", "dataAiHint": "reading nook"}, {"src": "/kitchen2.jpg", "alt": "The integrated headboard lighting", "dataAiHint": "bedroom lighting"}]')
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
