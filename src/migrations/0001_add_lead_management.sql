
-- Create sales_persons table
CREATE TABLE IF NOT EXISTS sales_persons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    profile_image_url TEXT,
    contact_number TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create leads table
CREATE TABLE IF NOT EXISTS leads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT,
    mobile TEXT NOT NULL,
    services TEXT[],
    message TEXT,
    assigned_to_id UUID REFERENCES sales_persons(id) ON DELETE SET NULL,
    status TEXT DEFAULT 'new', -- e.g., new, contacted, qualified, lost, won
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Allow all access for authenticated users for simplicity in admin panel
-- In production, you might want more restrictive policies.
ALTER TABLE sales_persons ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow authenticated users to manage sales persons" ON sales_persons FOR ALL TO authenticated USING (true) WITH CHECK (true);

ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow authenticated users to manage leads" ON leads FOR ALL TO authenticated USING (true) WITH CHECK (true);
