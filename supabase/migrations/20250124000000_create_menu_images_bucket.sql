-- Create menu-images bucket if it doesn't exist
INSERT INTO storage.buckets (id, name, public)
VALUES ('menu-images', 'menu-images', true)
ON CONFLICT (id) DO NOTHING;

-- Policy to allow public viewing of images
CREATE POLICY "Give public access to menu-images" ON storage.objects
  FOR SELECT
  TO public
  USING (bucket_id = 'menu-images');

-- Policy to allow authenticated users to upload images
CREATE POLICY "Allow authenticated uploads to menu-images" ON storage.objects
  FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'menu-images');

-- Policy to allow authenticated users to update their own images (or all if admin)
-- For simplicity in this admin-focused app, allow auth users to update/delete
CREATE POLICY "Allow authenticated updates to menu-images" ON storage.objects
  FOR UPDATE
  TO authenticated
  USING (bucket_id = 'menu-images');

CREATE POLICY "Allow authenticated deletes to menu-images" ON storage.objects
  FOR DELETE
  TO authenticated
  USING (bucket_id = 'menu-images');
