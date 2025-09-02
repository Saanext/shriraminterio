-- Add the video_gallery column to the stories table
-- This allows storing a list of video URLs and thumbnails for each story.
ALTER TABLE stories
ADD COLUMN video_gallery jsonb;
