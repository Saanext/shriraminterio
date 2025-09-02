
CREATE TABLE IF NOT EXISTS social_links (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    icon VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Pre-populate with default social links
INSERT INTO social_links (name, url, icon) VALUES
('Facebook', '#', 'Facebook'),
('Twitter', '#', 'Twitter'),
('Instagram', '#', 'Instagram'),
('Youtube', '#', 'Youtube')
ON CONFLICT (name) DO NOTHING;
