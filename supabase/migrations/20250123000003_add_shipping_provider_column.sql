-- Add shipping_provider column to orders table
-- Run this in your Supabase SQL Editor

DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_provider'
  ) THEN
    ALTER TABLE orders ADD COLUMN shipping_provider TEXT DEFAULT 'jnt';
  END IF;
END $$;

-- Force schema cache reload to ensure API sees the new column
NOTIFY pgrst, 'reload schema';
