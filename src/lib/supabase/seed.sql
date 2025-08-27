
-- Create the 'public' storage bucket if it doesn't exist.
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('public', 'public', true, 5242880, ARRAY['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'video/mp4', 'video/webm'])
ON CONFLICT (id) DO NOTHING;

-- Set up Row Level Security (RLS) policies for storage.
-- These policies allow public access for viewing files and authenticated access for uploads.

-- Policy for viewing files in the 'public' bucket.
CREATE POLICY "Public Access" ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'public');

-- Policy for allowing authenticated users to upload files to the 'public' bucket.
CREATE POLICY "Authenticated Upload" ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'public');

-- Drop existing tables and types to start fresh.
-- This helps avoid conflicts when re-running the script.
DROP TABLE IF EXISTS "sections";
DROP TABLE IF EXISTS "pages";
DROP TABLE IF EXISTS "stories";
DROP TYPE IF EXISTS "section_type";

-- Create a custom type for different section types.
-- This allows for structured and predefined section categories.
CREATE TYPE "section_type" AS ENUM (
    'hero', 'welcome', 'about_company', 'why_us', 'work_gallery', 
    'comfort_design', 'what_we_do', 'testimonials', 'faq', 'partners',
    'header', 'featured_story', 'more_stories', 'story_details', 'gallery',
    'featured_testimonial', 'video_testimonials', 'text_testimonials',
    'our_services', 'detailed_services', 'projects_gallery', 'product_details',
    'process', 'get_started', 'mission_vision', 'team', 'journey', 'values', 'story'
);

-- Create the 'pages' table.
-- This table stores general information for each page of the website.
CREATE TABLE "pages" (
    "id" SERIAL PRIMARY KEY,
    "slug" TEXT NOT NULL UNIQUE,
    "title" TEXT NOT NULL,
    "meta_title" TEXT,
    "meta_description" TEXT,
    "created_at" TIMESTAMPTZ DEFAULT NOW()
);

-- Create the 'sections' table.
-- This table holds the content for different sections on each page,
-- linking back to the 'pages' table. It uses a JSONB column to store
-- flexible content structures.
CREATE TABLE "sections" (
    "id" SERIAL PRIMARY KEY,
    "page_id" INTEGER REFERENCES "pages"("id"),
    "type" "section_type" NOT NULL,
    "title" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "visible" BOOLEAN DEFAULT TRUE,
    "content" JSONB,
    "content_structure" JSONB,
    "created_at" TIMESTAMPTZ DEFAULT NOW()
);

-- Create the 'stories' table
-- This table will hold the content for customer stories.
CREATE TABLE "stories" (
    "id" SERIAL PRIMARY KEY,
    "slug" TEXT NOT NULL UNIQUE,
    "title" TEXT NOT NULL,
    "image" TEXT,
    "dataAiHint" TEXT,
    "category" TEXT,
    "excerpt" TEXT,
    "author" TEXT,
    "authorAvatar" TEXT,
    "date" TEXT,
    "clientImage" TEXT,
    "location" TEXT,
    "project" TEXT,
    "size" TEXT,
    "quote" TEXT,
    "content" TEXT,
    "gallery" JSONB,
    "created_at" TIMESTAMPTZ DEFAULT NOW()
);


-- Insert data for the 'Home' page.
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(1, 'home', 'Home', 'Shriram Interio | Pune''s Premier Interior Designers', 'Transform your home with Shriram Interio, Pune''s leading interior design company. We specialize in modular kitchens, wardrobes, and full home interiors. Get a free quote today!')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'Home' page.
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(1, 'hero', 'Hero Section', 1, 
    '{
        "title": "Welcome to Pune''s Premier Interior Design Destination",
        "subtitle": "At Shriram Interio, we design and deliver beautiful, functional, and personalized home interiors. From stunning modular kitchens to elegant wardrobes and complete home makeovers, we bring your vision to life with passion, precision, and excellence.",
        "buttonText": "Explore Our Designs",
        "videoUrl": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-video.mp4",
        "slides": [
            {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-1.jpg"},
            {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-2.jpg"},
            {"image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/hero-3.jpg"}
        ]
    }',
    '{
        "title": {"type": "text", "label": "Main Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"},
        "buttonText": {"type": "text", "label": "Button Text"},
        "videoUrl": {"type": "text", "label": "Background Video URL"},
        "slides": {"type": "repeater", "label": "Image Slides"}
    }'
),
(1, 'welcome', 'Welcome Section', 2, 
    '{
        "paragraph1": "We are a creative-led, service-driven team that is passionate about interiors. Our work is powered by our vision: to create spaces that are timeless, personal, and which seamlessly enhance the lives of our clients.",
        "paragraph2": "We specialize in modular kitchens, wardrobes, and full-service residential interior design. From concept to completion, we are here to bring your dream home to life.",
        "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/welcome.jpg"
    }',
    '{
        "paragraph1": {"type": "textarea", "label": "First Paragraph"},
        "paragraph2": {"type": "textarea", "label": "Second Paragraph"},
        "image": {"type": "image", "label": "Welcome Image"}
    }'
),
(1, 'about_company', 'About Company Section', 3, 
    '{
        "title": "About Our Company",
        "text": "is a team of passionate creatives dedicated to designing spaces that resonate with your soul. Since 2016, we have been redefining interior design by infusing creativity, functionality, and a personalized touch into every project. Over the years, we have evolved, but our commitment to excellence remains unwavering."
    }',
    '{
        "title": {"type": "text", "label": "Section Title"},
        "text": {"type": "textarea", "label": "Company Description"}
    }'
),
(1, 'why_us', 'Why Us Section', 4,
    '{
      "title": "Why Shriram Interio?",
      "subtitle": "Discover the difference that quality, expertise, and passion can make in your home.",
      "items": [
        {
          "title": "Expert Design Team",
          "description": "Our team of skilled interior designers brings a wealth of experience and creativity to every project."
        },
        {
          "title": "Variety of Design Choices",
          "description": "We offer a wide range of design options, from modern and minimalist to classic and contemporary."
        },
        {
          "title": "Affordable Design Fees",
          "description": "We believe that great design should be accessible to everyone, which is why we offer competitive and transparent pricing."
        },
        {
          "title": "On-Time Project Delivery",
          "description": "We are committed to completing projects on time and within budget, ensuring a seamless and stress-free experience."
        }
      ]
    }',
    '{
      "title": {"type": "text", "label": "Section Title"},
      "subtitle": {"type": "text", "label": "Section Subtitle"},
      "items": {"type": "repeater", "label": "Feature Items"}
    }'
),
(1, 'work_gallery', 'Work Gallery', 5, 
    '{
        "title": "Our Work Gallery",
        "subtitle": "Explore our portfolio and get inspired by our latest projects.",
        "items": [
            {"title": "L-shaped kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "hint": "l-shaped kitchen"},
            {"title": "Island kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "hint": "island kitchen"},
            {"title": "U-shaped kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "hint": "u-shaped kitchen"},
            {"title": "Sliding wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "hint": "sliding wardrobe"},
            {"title": "Walk-in closet", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "hint": "walk-in closet"}
        ]
    }',
    '{
        "title": {"type": "text", "label": "Section Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"},
        "items": {"type": "repeater", "label": "Gallery Items"}
    }'
),
(1, 'comfort_design', 'Comfort Design Section', 6,
    '{
      "title": "Design At Your Comfort",
      "subtitle": "We have re-imagined our interior design process to put you first. Experience a new way of designing your home that is convenient, transparent, and tailored to your needs.",
      "items": [
        {
          "title": "Live 3D Designs",
          "description": "See your vision come to life with our interactive 3D design sessions."
        },
        {
          "title": "Contactless Experience",
          "description": "From consultation to final handover, enjoy a safe and seamless process."
        },
        {
          "title": "Instant Pricing",
          "description": "Get transparent and upfront pricing for your entire project."
        },
        {
          "title": "Expertise & Passion",
          "description": "Our team's dedication and passion shine through in every detail."
        }
      ]
    }',
    '{
      "title": {"type": "text", "label": "Section Title"},
      "subtitle": {"type": "text", "label": "Section Subtitle"},
      "items": {"type": "repeater", "label": "Feature Items"}
    }'
),
(1, 'what_we_do', 'What We Do Section', 7,
    '{
      "title": "What We Do",
      "subtitle": "Explore our curated collections of trending designs and best-selling products.",
      "trendingItems": [
        {"name": "Entertainment Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/t-1.jpg", "hint": "entertainment unit"},
        {"name": "Study Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/t-2.jpg", "hint": "study unit"},
        {"name": "Crockery Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/t-3.jpg", "hint": "crockery unit"},
        {"name": "Pooja Unit", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/t-4.jpg", "hint": "pooja unit"}
      ],
      "bestSellingKitchens": [
        {"name": "L-Shape Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "hint": "l-shaped kitchen"},
        {"name": "Island Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-2.jpg", "hint": "island kitchen"},
        {"name": "U-Shape Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "hint": "u-shaped kitchen"},
        {"name": "Parallel Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-4.png", "hint": "parallel kitchen"}
      ],
      "bestSellingWardrobes": [
        {"name": "Sliding Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "hint": "sliding wardrobe"},
        {"name": "Walk-in Closet", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "hint": "walk-in closet"},
        {"name": "Hinged Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-3.jpg", "hint": "hinged wardrobe"},
        {"name": "Free Standing Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-4.jpg", "hint": "freestanding wardrobe"}
      ]
    }',
    '{
      "title": {"type": "text", "label": "Section Title"},
      "subtitle": {"type": "text", "label": "Section Subtitle"},
      "trendingItems": {"type": "repeater", "label": "Trending Items"},
      "bestSellingKitchens": {"type": "repeater", "label": "Best Selling Kitchens"},
      "bestSellingWardrobes": {"type": "repeater", "label": "Best Selling Wardrobes"}
    }'
),
(1, 'testimonials', 'Testimonials Section', 8,
    '{
      "title": "Hear From Our Clients",
      "subtitle": "We take pride in our work and the relationships we build with our clients.",
      "buttonText": "View All Stories",
      "items": [
        {
          "name": "Rohan & Priya",
          "review": "The team at Shriram Interio transformed our house into a home. Their attention to detail and commitment to quality is commendable.",
          "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg"
        },
        {
          "name": "Anjali Sharma",
          "review": "From the initial consultation to the final handover, the process was seamless. I am thrilled with my new modular kitchen.",
          "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg"
        },
        {
          "name": "Vikram Singh",
          "review": "The designers understood our vision perfectly and delivered beyond our expectations. Highly recommended!",
          "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg"
        }
      ]
    }',
    '{
      "title": {"type": "text", "label": "Section Title"},
      "subtitle": {"type": "text", "label": "Section Subtitle"},
      "buttonText": {"type": "text", "label": "Button Text"},
      "items": {"type": "repeater", "label": "Testimonials"}
    }'
),
(1, 'faq', 'FAQ Section', 9, 
    '{
        "title": "Frequently Asked Questions",
        "subtitle": "Have questions? We have answers. Explore our FAQ section to find out more.",
        "items": [
            {
                "question": "What is the typical timeline for a project?",
                "answer": "A standard project, such as a modular kitchen or wardrobe, typically takes 4-6 weeks from design approval to installation. Full home interiors may take 8-12 weeks, depending on the scope of work."
            },
            {
                "question": "Do you offer a warranty on your products?",
                "answer": "Yes, we offer a comprehensive warranty on all our products and services. The warranty period varies depending on the product, but we stand behind the quality of our work."
            },
            {
                "question": "Can I see a 3D model of my design before it is finalized?",
                "answer": "Absolutely! We provide detailed 3D renderings of your design to help you visualize the final outcome. We work with you to make any necessary changes before we begin production."
            }
        ]
    }',
    '{
        "title": {"type": "text", "label": "Section Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"},
        "items": {"type": "repeater", "label": "FAQ Items"}
    }'
),
(1, 'partners', 'Partners Section', 10,
  '{
    "title": "Our Trusted Partners",
    "subtitle": "In Association With",
    "items": [
      {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-1.png"},
      {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-2.png"},
      {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-3.png"},
      {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-4.png"},
      {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-5.png"}
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Partner Logos"}
  }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;


-- Insert data for the 'About' page.
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(2, 'about', 'About Us', 'About Shriram Interio | Our Story, Mission, and Values', 'Learn about Shriram Interio, a leading interior design firm in Pune. Discover our story, our design philosophy, and the values that drive us to create beautiful and functional spaces.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'About' page.
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(2, 'hero', 'Hero Section', 1, 
    '{
        "title": "Crafting Spaces, Creating Stories",
        "subtitle": "We are more than just designers; we are storytellers, artists, and innovators.",
        "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/about-hero.jpg"
    }',
    '{
        "title": {"type": "text", "label": "Main Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"},
        "backgroundImage": {"type": "image", "label": "Background Image"}
    }'
),
(2, 'story', 'Our Story Section', 2, 
    '{
        "heading": "Our Story",
        "subheading": "Every great design begins with an even better story.",
        "paragraph1": "Founded in 2016 by a team of passionate and creative individuals, Shriram Interio was born out of a desire to transform ordinary spaces into extraordinary homes. Our journey began with a simple vision: to bring high-quality, innovative, and personalized interior design to Pune.",
        "paragraph2": "We started small, with a handful of projects and a dedicated team, but our commitment to excellence and our client-centric approach quickly set us apart. We believe that a home is a reflection of its owner''s personality, and our mission is to create spaces that are not only beautiful but also deeply personal and functional.",
        "paragraph3": "Over the years, we have grown into a full-service interior design firm, specializing in modular kitchens, wardrobes, and complete home interiors. Our portfolio is a testament to our versatility and our ability to adapt to different styles and requirements.",
        "paragraph4": "Today, we are proud to be one of Pune''s most trusted names in interior design, with a long list of satisfied clients and a portfolio of stunning projects. But our story is far from over. We continue to innovate, to learn, and to push the boundaries of design, always striving to create spaces that inspire and delight.",
        "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/our-story.jpg"
    }',
    '{
        "heading": {"type": "text", "label": "Heading"},
        "subheading": {"type": "text", "label": "Subheading"},
        "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
        "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
        "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
        "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
        "image": {"type": "image", "label": "Image"}
    }'
),
(2, 'journey', 'Our Journey Section', 3,
    '{
        "heading": "Our Journey",
        "paragraph1": "Our journey has been one of continuous growth and learning. From our humble beginnings in 2016, we have expanded our team, our services, and our portfolio, always staying true to our core values of quality, integrity, and customer satisfaction.",
        "paragraph2": "We have embraced new technologies and design trends, while also cherishing the timeless principles of good design. Our design process is collaborative and transparent, ensuring that our clients are involved every step of the way.",
        "paragraph3": "We have had the privilege of working on a diverse range of projects, from cozy apartments to luxurious villas, each with its own unique challenges and rewards. Every project has been a learning experience, helping us to hone our skills and refine our processes.",
        "paragraph4": "As we look to the future, we are excited about the new possibilities and challenges that lie ahead. We are committed to continuing our journey of growth and innovation, and to creating spaces that make a real difference in people''s lives.",
        "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/our-journey.jpg"
    }',
    '{
        "heading": {"type": "text", "label": "Heading"},
        "paragraph1": {"type": "textarea", "label": "Paragraph 1"},
        "paragraph2": {"type": "textarea", "label": "Paragraph 2"},
        "paragraph3": {"type": "textarea", "label": "Paragraph 3"},
        "paragraph4": {"type": "textarea", "label": "Paragraph 4"},
        "image": {"type": "image", "label": "Image"}
    }'
),
(2, 'values', 'Our Values Section', 4,
    '{
        "title": "Our Values",
        "subtitle": "The principles that guide us in everything we do.",
        "items": [
            {"title": "Expert Design Team", "description": "We are a team of experienced and talented designers who are passionate about creating beautiful and functional spaces."},
            {"title": "Variety of Design Choices", "description": "We offer a wide range of design options to suit every taste and budget."},
            {"title": "Affordable Design Fees", "description": "We believe that great design should be accessible to everyone."},
            {"title": "On-Time Project Delivery", "description": "We are committed to delivering our projects on time and within budget."}
        ]
    }',
    '{
        "title": {"type": "text", "label": "Title"},
        "subtitle": {"type": "text", "label": "Subtitle"},
        "items": {"type": "repeater", "label": "Value Items"}
    }'
),
(2, 'mission_vision', 'Mission and Vision Section', 5,
    '{
        "visionTitle": "Our Vision",
        "visionText": "To be the most trusted and sought-after interior design firm in Pune, known for our creativity, quality, and commitment to customer satisfaction.",
        "missionTitle": "Our Mission",
        "missionText": "To create beautiful, functional, and personalized spaces that enhance the lives of our clients and reflect their unique personalities and lifestyles."
    }',
    '{
        "visionTitle": {"type": "text", "label": "Vision Title"},
        "visionText": {"type": "textarea", "label": "Vision Text"},
        "missionTitle": {"type": "text", "label": "Mission Title"},
        "missionText": {"type": "textarea", "label": "Mission Text"}
    }'
),
(2, 'team', 'Meet the Team Section', 6,
    '{
        "title": "Meet the Team",
        "subtitle": "The creative minds behind Shriram Interio.",
        "members": [
            {
                "name": "Shriram",
                "role": "Founder & Principal Designer",
                "bio": "With over a decade of experience in the industry, Shriram leads the team with his passion for design and his commitment to excellence.",
                "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-1.jpg"
            },
            {
                "name": "Priya",
                "role": "Lead Interior Designer",
                "bio": "Priya brings a wealth of creativity and a keen eye for detail to every project. She specializes in creating spaces that are both beautiful and functional.",
                "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-2.jpg"
            },
            {
                "name": "Rajesh",
                "role": "Project Manager",
                "bio": "Rajesh ensures that every project is completed on time and within budget. His meticulous planning and execution are key to our success.",
                "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/team-3.jpg"
            }
        ]
    }',
    '{
        "title": {"type": "text", "label": "Title"},
        "subtitle": {"type": "text", "label": "Subtitle"},
        "members": {"type": "repeater", "label": "Team Members"}
    }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;


-- Insert data for the 'Customer Stories' page.
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(3, 'customer-stories', 'Customer Stories', 'Customer Stories | Shriram Interio Success Stories', 'Read inspiring stories from our clients. See how we transformed their houses into dream homes with our expert interior design services in Pune.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;


-- Insert sections for the 'Customer Stories' page.
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(3, 'header', 'Header Section', 1, 
    '{
        "title": "Our Customer Stories",
        "subtitle": "Discover how we have transformed homes and lives with our passion for design and commitment to excellence. Each story is a testament to our collaborative process and our dedication to bringing our clients'' visions to life."
    }',
    '{
        "title": {"type": "text", "label": "Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"}
    }'
),
(3, 'featured_story', 'Featured Story Section', 2, 
    '{
        "buttonText": "Read The Full Story"
    }',
    '{
        "buttonText": {"type": "text", "label": "Button Text"}
    }'
),
(3, 'more_stories', 'More Stories Section', 3,
    '{
        "title": "More Inspiring Stories"
    }',
    '{
        "title": {"type": "text", "label": "Title"}
    }'
),
(3, 'work_gallery', 'Work Gallery', 4, 
    '{
        "title": "Project Showcase",
        "subtitle": "A glimpse into the stunning transformations we have created for our clients.",
        "items": [
            {"title": "Modern Living Room", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-1.jpg", "hint": "living room"},
            {"title": "Elegant Bedroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-2.jpg", "hint": "bedroom interior"},
            {"title": "Functional Home Office", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-3.jpg", "hint": "home office"},
            {"title": "Spacious Modular Kitchen", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-4.jpg", "hint": "modular kitchen"},
            {"title": "Stylish Wardrobe", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-5.jpg", "hint": "wardrobe design"},
            {"title": "Luxury Bathroom", "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/gallery-6.jpg", "hint": "luxury bathroom"}
        ]
    }',
    '{
        "title": {"type": "text", "label": "Section Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"},
        "items": {"type": "repeater", "label": "Gallery Items"}
    }'
),
(3, 'partners', 'Partners Section', 5,
  '{
    "title": "Our Trusted Partners",
    "subtitle": "In Association With",
    "items": [
      {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-1.png"},
      {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-2.png"},
      {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-3.png"},
      {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-4.png"},
      {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-5.png"}
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Partner Logos"}
  }'
),
(3, 'faq', 'FAQ Section', 6, 
    '{
        "title": "Frequently Asked Questions",
        "subtitle": "Your questions, answered.",
        "items": [
            {
                "question": "How do you select stories to feature?",
                "answer": "We feature stories that showcase a range of styles, budgets, and project types. We look for projects that highlight our collaborative process and the positive impact of our designs on our clients'' lives."
            },
            {
                "question": "Can I submit my own story?",
                "answer": "We would love to hear from you! If you are a past client and would like to share your experience, please get in touch with us through our contact page. We are always looking for new stories to feature."
            },
            {
                "question": "How can I get a similar design for my home?",
                "answer": "If you are inspired by one of our customer stories, we would be happy to discuss how we can create a similar design for your home. Please book an appointment with us to get started."
            }
        ]
    }',
    '{
        "title": {"type": "text", "label": "Section Title"},
        "subtitle": {"type": "textarea", "label": "Subtitle"},
        "items": {"type": "repeater", "label": "FAQ Items"}
    }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;

-- Insert data into the 'stories' table.
INSERT INTO "stories" ("slug", "title", "image", "dataAiHint", "category", "excerpt", "author", "authorAvatar", "date", "clientImage", "location", "project", "size", "quote", "content", "gallery") VALUES
(
    'the-mehtas-dream-kitchen',
    'The Mehtas'' Dream Kitchen: A Culinary Haven',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-main.jpg',
    'modern kitchen',
    'Kitchen Renovation',
    'Discover how we transformed a cramped and outdated kitchen into a spacious, modern culinary haven for the Mehta family.',
    'Priya Mehta',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg',
    'August 15, 2024',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-client.jpg',
    'Koregaon Park, Pune',
    'Modular Kitchen',
    '150 sq. ft.',
    'Our new kitchen is not just beautiful; it’s incredibly functional. Shriram Interio understood our needs perfectly!',
    '<p>The Mehta family loves to cook and entertain, but their old kitchen was cramped, poorly lit, and lacked storage. They dreamed of a modern, open-concept kitchen that would be the heart of their home. Our team took on the challenge, completely redesigning the layout to maximize space and workflow.</p><p>We incorporated smart storage solutions, high-quality appliances, and a stunning quartz countertop. The result is a bright, airy, and highly functional kitchen that has become the family''s favorite gathering spot.</p>',
    '[
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-1.jpg", "alt": "Kitchen before renovation", "dataAiHint": "old kitchen"},
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-2.jpg", "alt": "Kitchen after renovation", "dataAiHint": "new kitchen"},
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-1-gallery-3.jpg", "alt": "Detailed view of the kitchen island", "dataAiHint": "kitchen island"}
    ]'
),
(
    'rohans-serene-bedroom-retreat',
    'Rohan''s Serene Bedroom Retreat',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-main.jpg',
    'serene bedroom',
    'Bedroom Interior',
    'A busy professional, Rohan wanted a bedroom that would be his personal sanctuary—a place to unwind and recharge.',
    'Rohan Sharma',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg',
    'July 22, 2024',
    'https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-client.jpg',
    'Baner, Pune',
    'Bedroom & Wardrobe',
    '200 sq. ft.',
    'They created a space that is not only stylish but also incredibly calming. It’s my perfect escape from the hustle and bustle of city life.',
    '<p>We used a soothing color palette of blues and grays, combined with natural wood tones and soft lighting, to create a tranquil atmosphere. A custom-designed wardrobe with smart storage solutions helps keep the space clutter-free. The result is a serene and sophisticated bedroom that perfectly reflects Rohan''s style and needs.</p>',
    '[
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-1.jpg", "alt": "Bedroom before makeover", "dataAiHint": "messy bedroom"},
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-2.jpg", "alt": "Bedroom after makeover", "dataAiHint": "organized bedroom"},
        {"src": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/story-2-gallery-3.jpg", "alt": "Custom wardrobe details", "dataAiHint": "custom wardrobe"}
    ]'
)
ON CONFLICT (slug) DO UPDATE SET
"title" = EXCLUDED.title,
"image" = EXCLUDED.image,
"dataAiHint" = EXCLUDED.dataAiHint,
"category" = EXCLUDED.category,
"excerpt" = EXCLUDED.excerpt,
"author" = EXCLUDED.author,
"authorAvatar" = EXCLUDED.authorAvatar,
"date" = EXCLUDED.date,
"clientImage" = EXCLUDED.clientImage,
"location" = EXCLUDED.location,
"project" = EXCLUDED.project,
"size" = EXCLUDED.size,
"quote" = EXCLUDED.quote,
"content" = EXCLUDED.content,
"gallery" = EXCLUDED.gallery;

-- Insert data for the 'Clients' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(4, 'clients', 'Clients', 'Our Valued Clients | Testimonials & Reviews', 'See what our clients have to say about their experience with Shriram Interio. Read testimonials and watch video reviews from satisfied homeowners in Pune.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'Clients' page
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(4, 'featured_testimonial', 'Featured Testimonial', 1,
  '{
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-featured.jpg",
    "name": "The Sharma Family",
    "location": "Wakad, Pune",
    "project": "Full Home Interior",
    "size": "3 BHK",
    "quote": "Shriram Interio turned our house into a dream home. The team was professional, creative, and incredibly patient with our requests. We couldn''t be happier with the result!",
    "review": "From the initial 3D designs to the final installation, every step of the process was handled with utmost care and precision. The quality of the materials and the craftsmanship is exceptional. Our home feels both luxurious and comfortable, a perfect reflection of our style. We highly recommend their services to anyone looking for a hassle-free and beautiful home transformation."
  }',
  '{
    "image": {"type": "image", "label": "Client Image"},
    "name": {"type": "text", "label": "Client Name"},
    "location": {"type": "text", "label": "Location"},
    "project": {"type": "text", "label": "Project Type"},
    "size": {"type": "text", "label": "Project Size"},
    "quote": {"type": "textarea", "label": "Quote"},
    "review": {"type": "textarea", "label": "Full Review"}
  }'
),
(4, 'video_testimonials', 'Video Testimonials', 2,
  '{
    "title": "Client Video Testimonials",
    "subtitle": "Watch our clients share their experiences working with Shriram Interio.",
    "videos": [
      {
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-video-1.jpg",
        "dataAiHint": "happy couple",
        "name": "Amit & Sunita Patel",
        "location": "Baner, Pune",
        "review": "Our kitchen is now the heart of our home, thanks to the amazing team at Shriram Interio.",
        "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      },
      {
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-video-2.jpg",
        "dataAiHint": "smiling woman",
        "name": "Neha Desai",
        "location": "Hinjewadi, Pune",
        "review": "They designed the perfect walk-in wardrobe for me. It''s functional, stylish, and exactly what I wanted.",
        "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      },
      {
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/client-video-3.jpg",
        "dataAiHint": "man in office",
        "name": "Rajiv Kapoor",
        "location": "Kharadi, Pune",
        "review": "The entire home interior project was managed beautifully. The result is simply stunning. Highly recommended!",
        "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      }
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "videos": {"type": "repeater", "label": "Video Items"}
  }'
),
(4, 'text_testimonials', 'Text Testimonials', 3,
  '{
    "title": "What Our Clients Are Saying",
    "subtitle": "Don''t just take our word for it. Read reviews from our happy clients.",
    "testimonials": [
      {
        "review": "The design process was so collaborative and fun. The team really listened to our ideas and brought them to life beautifully.",
        "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-1.jpg",
        "name": "Priya & Sameer",
        "avatar": "PS"
      },
      {
        "review": "Impeccable workmanship and on-time delivery. Shriram Interio exceeded all our expectations.",
        "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-2.jpg",
        "name": "Ananya Reddy",
        "avatar": "AR"
      },
      {
        "review": "A truly professional team that delivers on its promises. Our new home feels like a five-star resort!",
        "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/testimonial-3.jpg",
        "name": "Vikram Chauhan",
        "avatar": "VC"
      }
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "testimonials": {"type": "repeater", "label": "Testimonial Items"}
  }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;


-- Insert data for the 'Services' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(5, 'services', 'Services', 'Our Interior Design Services | Modular Kitchen, Wardrobes & More', 'Explore the wide range of interior design services offered by Shriram Interio in Pune. We specialize in modular kitchens, wardrobes, living area design, and full home interiors.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'Services' page
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(5, 'header', 'Header', 1,
  '{
    "title": "Our Services",
    "subtitle": "We offer a comprehensive range of interior design services to meet your needs."
  }',
  '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
  }'
),
(5, 'our_services', 'Our Services', 2,
  '{
    "services": [
      {
        "title": "Modular Kitchen Design",
        "description": "We design and build beautiful and functional modular kitchens that are tailored to your lifestyle."
      },
      {
        "title": "Wardrobe & Storage Solutions",
        "description": "Our custom wardrobes and storage solutions are designed to maximize space and enhance the aesthetics of your home."
      },
      {
        "title": "Bedroom Interiors",
        "description": "We create serene and stylish bedroom interiors that are a perfect retreat from the hustle and bustle of city life."
      },
      {
        "title": "Living Area Design",
        "description": "Our living area designs are a perfect blend of comfort and style, creating a warm and inviting space for your family."
      },
      {
        "title": "Exterior Design Services",
        "description": "We also offer exterior design services to enhance the curb appeal of your home."
      },
      {
        "title": "Full Home Interiors",
        "description": "From concept to completion, we offer end-to-end interior design services for your entire home."
      }
    ]
  }',
  '{
    "services": {"type": "repeater", "label": "Service Items"}
  }'
),
(5, 'detailed_services', 'Detailed Services', 3,
  '{
    "services": [
      {
        "title": "Living Room Design",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-living.jpg",
        "dataAiHint": "modern living room",
        "href": "/products/living-room"
      },
      {
        "title": "Bedroom Design",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-bedroom.jpg",
        "dataAiHint": "elegant bedroom",
        "href": "/products/bedroom"
      },
      {
        "title": "Bathroom Design",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-bathroom.jpg",
        "dataAiHint": "luxury bathroom",
        "href": "/products/bathroom"
      },
      {
        "title": "Home Office Design",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-office.jpg",
        "dataAiHint": "sleek home office",
        "href": "/products/home-office"
      },
      {
        "title": "Space Saving Furniture",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/service-space.jpg",
        "dataAiHint": "murphy bed",
        "href": "/products/space-saving-furniture"
      }
    ]
  }',
  '{
    "services": {"type": "repeater", "label": "Detailed Service Items"}
  }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;


-- Insert data for the 'Portfolio' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(6, 'portfolio', 'Portfolio', 'Our Portfolio | Interior Design Projects in Pune', 'Browse our portfolio of completed interior design projects in Pune. See examples of our work in modular kitchens, wardrobes, living rooms, and full home interiors.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'Portfolio' page
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(6, 'projects_gallery', 'Projects Gallery', 1,
  '{
    "projects": [
      {"id": 1, "title": "Modern Kitchen", "category": "Kitchens", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-1.jpg", "dataAiHint": "modern kitchen"},
      {"id": 2, "title": "Living Room", "category": "Living Areas", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/living-1.jpg", "dataAiHint": "cozy living room"},
      {"id": 3, "title": "Bedroom", "category": "Bedrooms", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bedroom-1.jpg", "dataAiHint": "elegant bedroom"},
      {"id": 4, "title": "Wardrobe", "category": "Wardrobes", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-1.jpg", "dataAiHint": "sliding wardrobe"},
      {"id": 5, "title": "U-Shaped Kitchen", "category": "Kitchens", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/kitchen-3.jpg", "dataAiHint": "u-shaped kitchen"},
      {"id": 6, "title": "Walk-in Closet", "category": "Wardrobes", "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/wardrobe-2.jpg", "dataAiHint": "walk-in closet"}
    ]
  }',
  '{
    "projects": {"type": "repeater", "label": "Projects"}
  }'
),
(6, 'partners', 'Partners Section', 2,
  '{
    "title": "Our Trusted Partners",
    "subtitle": "In Association With",
    "items": [
      {"name": "Partner 1", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-1.png"},
      {"name": "Partner 2", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-2.png"},
      {"name": "Partner 3", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-3.png"},
      {"name": "Partner 4", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-4.png"},
      {"name": "Partner 5", "logoSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/p-5.png"}
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "items": {"type": "repeater", "label": "Partner Logos"}
  }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;


-- Insert data for the 'How It Works' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(7, 'how-it-works', 'How It Works', 'Our Design Process | From Concept to Completion', 'Learn about our simple and transparent interior design process. From initial consultation to final installation, see how Shriram Interio brings your vision to life.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'How It Works' page
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(7, 'hero', 'Hero Section', 1,
  '{
    "title": "Our Simple & Transparent Process",
    "subtitle": "From your initial idea to the final installation, we make the journey to your dream home seamless and enjoyable.",
    "backgroundImage": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/how-it-works-hero.jpg"
  }',
  '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "backgroundImage": {"type": "image", "label": "Background Image"}
  }'
),
(7, 'process', 'Our Process Section', 2,
  '{
    "title": "How We Work",
    "subtitle": "Your dream home is just a few steps away.",
    "steps": [
      {
        "icon": "Handshake",
        "title": "Consultation & Requirement Analysis",
        "description": "We start by understanding your vision, needs, and budget. Our experts will discuss your lifestyle and preferences to create a personalized design brief."
      },
      {
        "icon": "PencilRuler",
        "title": "Design & 3D Visualization",
        "description": "Our designers craft a concept and bring it to life with realistic 3D models. You can review and refine the design until it''s perfect."
      },
      {
        "icon": "Truck",
        "title": "Production & On-site Execution",
        "description": "Once the design is approved, we begin manufacturing using high-quality materials. Our skilled team then handles the on-site installation with precision."
      },
      {
        "icon": "ShieldCheck",
        "title": "Quality Check & Handover",
        "description": "We conduct a thorough quality check to ensure everything is flawless. After your final approval, we hand over your newly designed space."
      },
      {
        "icon": "Star",
        "title": "Post-Installation Support",
        "description": "Our relationship doesn''t end at handover. We provide excellent post-installation support and warranty services to ensure your complete satisfaction."
      }
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "steps": {"type": "repeater", "label": "Process Steps"}
  }'
),
(7, 'why_us', 'Why Our Process Works', 3,
  '{
    "title": "Why Our Process Works",
    "subtitle": "We have designed our process to be client-centric, ensuring a smooth and transparent experience.",
    "benefits": [
      {
        "icon": "ThumbsUp",
        "title": "Client-Centric Approach",
        "description": "Your needs and preferences are at the heart of our design process."
      },
      {
        "icon": "Wallet",
        "title": "Transparent Pricing",
        "description": "No hidden costs. We provide a detailed quote upfront."
      },
      {
        "icon": "Smile",
        "title": "Hassle-Free Experience",
        "description": "We take care of everything, from design to execution."
      }
    ]
  }',
  '{
    "title": {"type": "text", "label": "Section Title"},
    "subtitle": {"type": "text", "label": "Section Subtitle"},
    "benefits": {"type": "repeater", "label": "Benefit Items"}
  }'
),
(7, 'get_started', 'Get Started Section', 4,
  '{
    "title": "Ready to Start Your Project?",
    "subtitle": "Let''s build the home of your dreams, together.",
    "buttonText": "Book a Free Consultation"
  }',
  '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"},
    "buttonText": {"type": "text", "label": "Button Text"}
  }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;


-- Insert data for the 'Products' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(8, 'products', 'Products', 'Our Products | Modular Kitchens, Wardrobes, & More', 'Explore our range of high-quality interior design products, including modular kitchens, custom wardrobes, TV units, and more. All made with premium materials in Pune.')
ON CONFLICT ("id") DO UPDATE SET
"slug" = EXCLUDED.slug,
"title" = EXCLUDED.title,
"meta_title" = EXCLUDED.meta_title,
"meta_description" = EXCLUDED.meta_description;

-- Insert sections for the 'Products' page
INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(8, 'header', 'Header Section', 1,
  '{
    "title": "Our Products",
    "subtitle": "Crafted with precision, designed for life. Explore our range of high-quality interior solutions."
  }',
  '{
    "title": {"type": "text", "label": "Title"},
    "subtitle": {"type": "textarea", "label": "Subtitle"}
  }'
),
(8, 'product_list', 'Product List', 2,
  '{
    "products": [
      {
        "name": "Modular Kitchens",
        "description": "The heart of your home, designed for functionality and style.",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-kitchen.jpg",
        "dataAiHint": "modular kitchen",
        "href": "/products/kitchen"
      },
      {
        "name": "Wardrobes",
        "description": "Customized storage solutions that blend seamlessly with your space.",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-wardrobe.jpg",
        "dataAiHint": "modern wardrobe",
        "href": "/products/wardrobe"
      },
      {
        "name": "Living Room Furniture",
        "description": "Create a warm and inviting space with our stylish living room furniture.",
        "imageSrc": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/product-living.jpg",
        "dataAiHint": "stylish living room",
        "href": "/products/living-room"
      }
    ]
  }',
  '{
    "products": {"type": "repeater", "label": "Products"}
  }'
)
ON CONFLICT (page_id, type) DO UPDATE SET
"title" = EXCLUDED.title,
"order" = EXCLUDED.order,
"content" = EXCLUDED.content,
"content_structure" = EXCLUDED.content_structure;

-- Insert data for the 'Product - Living Room' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(9, 'product-living-room', 'Living Room', 'Living Room Furniture | Shriram Interio', 'Explore our living room furniture collection.')
ON CONFLICT ("id") DO UPDATE SET "slug" = EXCLUDED.slug, "title" = EXCLUDED.title;

INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(9, 'product_details', 'Product Details', 1,
  '{
    "title": "Living Room Furniture",
    "description": "Comfortable and stylish furniture for your living space.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/living-room-details.jpg"
  }',
  '{
    "title": {"type": "text", "label": "Product Title"},
    "description": {"type": "textarea", "label": "Product Description"},
    "image": {"type": "image", "label": "Product Image"}
  }'
) ON CONFLICT (page_id, type) DO UPDATE SET "content" = EXCLUDED.content;


-- Insert data for the 'Product - Bedroom' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(10, 'product-bedroom', 'Bedroom', 'Bedroom Furniture | Shriram Interio', 'Explore our bedroom furniture collection.')
ON CONFLICT ("id") DO UPDATE SET "slug" = EXCLUDED.slug, "title" = EXCLUDED.title;

INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(10, 'product_details', 'Product Details', 1,
  '{
    "title": "Bedroom Furniture",
    "description": "Create a peaceful retreat with our elegant bedroom furniture.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bedroom-details.jpg"
  }',
  '{
    "title": {"type": "text", "label": "Product Title"},
    "description": {"type": "textarea", "label": "Product Description"},
    "image": {"type": "image", "label": "Product Image"}
  }'
) ON CONFLICT (page_id, type) DO UPDATE SET "content" = EXCLUDED.content;


-- Insert data for the 'Product - Bathroom' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(11, 'product-bathroom', 'Bathroom', 'Bathroom Fittings | Shriram Interio', 'Explore our bathroom fittings collection.')
ON CONFLICT ("id") DO UPDATE SET "slug" = EXCLUDED.slug, "title" = EXCLUDED.title;

INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(11, 'product_details', 'Product Details', 1,
  '{
    "title": "Bathroom Fittings",
    "description": "Modern and durable fittings for your bathroom.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/bathroom-details.jpg"
  }',
  '{
    "title": {"type": "text", "label": "Product Title"},
    "description": {"type": "textarea", "label": "Product Description"},
    "image": {"type": "image", "label": "Product Image"}
  }'
) ON CONFLICT (page_id, type) DO UPDATE SET "content" = EXCLUDED.content;


-- Insert data for the 'Product - Home Office' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(12, 'product-home-office', 'Home Office', 'Home Office Furniture | Shriram Interio', 'Explore our home office furniture collection.')
ON CONFLICT ("id") DO UPDATE SET "slug" = EXCLUDED.slug, "title" = EXCLUDED.title;

INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(12, 'product_details', 'Product Details', 1,
  '{
    "title": "Home Office Furniture",
    "description": "Productive and ergonomic furniture for your home office.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/office-details.jpg"
  }',
  '{
    "title": {"type": "text", "label": "Product Title"},
    "description": {"type": "textarea", "label": "Product Description"},
    "image": {"type": "image", "label": "Product Image"}
  }'
) ON CONFLICT (page_id, type) DO UPDATE SET "content" = EXCLUDED.content;


-- Insert data for the 'Product - Space Saving Furniture' page
INSERT INTO "pages" ("id", "slug", "title", "meta_title", "meta_description") VALUES
(13, 'product-space-saving-furniture', 'Space Saving Furniture', 'Space Saving Furniture | Shriram Interio', 'Explore our space saving furniture collection.')
ON CONFLICT ("id") DO UPDATE SET "slug" = EXCLUDED.slug, "title" = EXCLUDED.title;

INSERT INTO "sections" ("page_id", "type", "title", "order", "content", "content_structure") VALUES
(13, 'product_details', 'Product Details', 1,
  '{
    "title": "Space Saving Furniture",
    "description": "Maximize your living area with our innovative space-saving furniture.",
    "image": "https://gzlakbpbhhxxpzbbifus.supabase.co/storage/v1/object/public/public/space-saving-details.jpg"
  }',
  '{
    "title": {"type": "text", "label": "Product Title"},
    "description": {"type": "textarea", "label": "Product Description"},
    "image": {"type": "image", "label": "Product Image"}
  }'
) ON CONFLICT (page_id, type) DO UPDATE SET "content" = EXCLUDED.content;

-- Sequence updates
SELECT setval('pages_id_seq', (SELECT MAX(id) FROM pages));
SELECT setval('sections_id_seq', (SELECT MAX(id) FROM sections));
SELECT setval('stories_id_seq', (SELECT MAX(id) FROM stories));

