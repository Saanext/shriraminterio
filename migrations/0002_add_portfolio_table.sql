
CREATE TABLE portfolio (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    content TEXT,
    main_image TEXT,
    gallery JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
