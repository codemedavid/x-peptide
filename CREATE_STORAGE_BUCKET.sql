-- 1. Create the 'menu-images' bucket (if it doesn't exist)
INSERT INTO storage.buckets (id, name, public)
VALUES ('menu-images', 'menu-images', true)
ON CONFLICT (id) DO NOTHING;

-- 2. Drop existing policies to avoid conflicts
DROP POLICY IF EXISTS "Give public access to menu-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated uploads to menu-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated updates to menu-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow authenticated deletes to menu-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow public uploads to menu-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow public updates to menu-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow public deletes to menu-images" ON storage.objects;

-- 3. Enable public access (VIEWING)
CREATE POLICY "Give public access to menu-images" ON storage.objects
  FOR SELECT
  TO public
  USING (bucket_id = 'menu-images');

-- 4. Enable public upload access (REQUIRED for the current Admin Login system)
-- Since the Admin Dashboard uses a simple password check (not Supabase Auth),
-- the database sees the user as "public" (anon). We must allow public uploads.
CREATE POLICY "Allow public uploads to menu-images" ON storage.objects
  FOR INSERT
  TO public
  WITH CHECK (bucket_id = 'menu-images');

-- 5. Enable public update/delete access
CREATE POLICY "Allow public updates to menu-images" ON storage.objects
  FOR UPDATE
  TO public
  USING (bucket_id = 'menu-images');

CREATE POLICY "Allow public deletes to menu-images" ON storage.objects
  FOR DELETE
  TO public
  USING (bucket_id = 'menu-images');
