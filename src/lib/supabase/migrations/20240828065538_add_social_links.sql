
-- src/lib/supabase/migrations/20240828065538_add_social_links.sql

-- Create the social_links table
CREATE TABLE IF NOT EXISTS social_links (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    url TEXT NOT NULL,
    icon VARCHAR(50) NOT NULL
);

-- Pre-populate with some default links
INSERT INTO social_links (name, url, icon) VALUES
('Facebook', 'https://facebook.com', 'Facebook'),
('Instagram', 'https://instagram.com', 'Instagram'),
('Twitter', 'https://twitter.com', 'Twitter'),
('Youtube', 'https://youtube.com', 'Youtube')
ON CONFLICT (name) DO NOTHING;
