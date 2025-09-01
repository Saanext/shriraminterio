-- Create the appointments table if it doesn't exist
CREATE TABLE IF NOT EXISTS appointments (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    appointment_date DATE NOT NULL,
    time_slot VARCHAR(255),
    purpose VARCHAR(255),
    floorplan VARCHAR(255),
    services TEXT[],
    message TEXT
);
