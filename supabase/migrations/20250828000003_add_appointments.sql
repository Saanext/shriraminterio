
CREATE TABLE appointments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    appointment_date DATE NOT NULL,
    time_slot TEXT NOT NULL,
    floorplan TEXT,
    purpose TEXT,
    message TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow authenticated users to insert appointments" ON appointments FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow service_role to manage appointments" ON appointments FOR ALL TO service_role WITH CHECK (true);
CREATE POLICY "Enable read access for authenticated users" ON appointments FOR SELECT TO authenticated USING (true);
