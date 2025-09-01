
-- Add the services column to the appointments table if it doesn't exist.
ALTER TABLE appointments
ADD COLUMN IF NOT EXISTS services text[];

-- Add the time_slot column to the appointments table if it doesn't exist.
ALTER TABLE appointments
ADD COLUMN IF NOT EXISTS time_slot text;
