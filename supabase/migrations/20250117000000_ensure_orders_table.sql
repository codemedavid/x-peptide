-- Ensure orders table exists (re-run if needed)
-- This migration ensures the orders table is created even if the previous migration wasn't applied
-- Updated to include shipping fee, shipping location, payment proof, and contact method

CREATE TABLE IF NOT EXISTS orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  
  -- Customer Information
  customer_name TEXT NOT NULL,
  customer_email TEXT NOT NULL,
  customer_phone TEXT NOT NULL,
  
  -- Shipping Address
  shipping_address TEXT NOT NULL,
  shipping_barangay TEXT NOT NULL,
  shipping_city TEXT NOT NULL,
  shipping_state TEXT NOT NULL,
  shipping_zip_code TEXT NOT NULL,
  shipping_country TEXT,
  
  -- Shipping Details
  shipping_location TEXT, -- NCR, LUZON, VISAYAS_MINDANAO
  shipping_fee DECIMAL(10,2) DEFAULT 0, -- Shipping fee amount
  
  -- Order Details
  order_items JSONB NOT NULL, -- Array of {product_id, product_name, variation_id, variation_name, quantity, price}
  total_price DECIMAL(10,2) NOT NULL,
  
  -- Payment
  payment_method_id TEXT,
  payment_method_name TEXT,
  payment_proof_url TEXT, -- URL to uploaded payment proof screenshot
  payment_status TEXT DEFAULT 'pending', -- pending, paid, failed
  
  -- Contact Method
  contact_method TEXT, -- instagram, viber
  
  -- Promo Codes
  promo_code_id UUID,
  promo_code TEXT,
  discount_applied DECIMAL(10, 2) DEFAULT 0,

  -- Order Status
  order_status TEXT DEFAULT 'new', -- new, confirmed, processing, shipped, delivered, cancelled
  notes TEXT,
  tracking_number TEXT,
  shipping_provider TEXT DEFAULT 'jnt', -- jnt, spx
  shipping_note TEXT,
  
  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add new columns to existing table if they don't exist (for existing installations)
DO $$ 
BEGIN
  -- Add shipping_barangay column if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_barangay'
  ) THEN
    ALTER TABLE orders ADD COLUMN shipping_barangay TEXT;
    -- Update existing rows to have a default value if needed
    UPDATE orders SET shipping_barangay = '' WHERE shipping_barangay IS NULL;
    -- Make it NOT NULL after setting defaults
    ALTER TABLE orders ALTER COLUMN shipping_barangay SET NOT NULL;
  END IF;
  
  -- Make shipping_country nullable if it exists and is NOT NULL
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_country' AND is_nullable = 'NO'
  ) THEN
    ALTER TABLE orders ALTER COLUMN shipping_country DROP NOT NULL;
  END IF;
  
  -- Add shipping_location column if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_location'
  ) THEN
    ALTER TABLE orders ADD COLUMN shipping_location TEXT;
  END IF;
  
  -- Add shipping_fee column if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_fee'
  ) THEN
    ALTER TABLE orders ADD COLUMN shipping_fee DECIMAL(10,2) DEFAULT 0;
  END IF;
  
  -- Add payment_proof_url column if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'payment_proof_url'
  ) THEN
    ALTER TABLE orders ADD COLUMN payment_proof_url TEXT;
  END IF;
  
  -- Add contact_method column if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'contact_method'
  ) THEN
    ALTER TABLE orders ADD COLUMN contact_method TEXT;
  END IF;

  -- Add promo columns if they don't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'promo_code_id'
  ) THEN
    ALTER TABLE orders ADD COLUMN promo_code_id UUID;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'promo_code'
  ) THEN
    ALTER TABLE orders ADD COLUMN promo_code TEXT;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'discount_applied'
  ) THEN
    ALTER TABLE orders ADD COLUMN discount_applied DECIMAL(10, 2) DEFAULT 0;
  END IF;

  -- Add tracking columns if they don't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'tracking_number'
  ) THEN
    ALTER TABLE orders ADD COLUMN tracking_number TEXT;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_provider'
  ) THEN
    ALTER TABLE orders ADD COLUMN shipping_provider TEXT DEFAULT 'jnt';
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' AND column_name = 'shipping_note'
  ) THEN
    ALTER TABLE orders ADD COLUMN shipping_note TEXT;
  END IF;
END $$;

-- Create indexes for better query performance (only if they don't exist)
CREATE INDEX IF NOT EXISTS idx_orders_customer_email ON orders(customer_email);
CREATE INDEX IF NOT EXISTS idx_orders_customer_phone ON orders(customer_phone);
CREATE INDEX IF NOT EXISTS idx_orders_order_status ON orders(order_status);
CREATE INDEX IF NOT EXISTS idx_orders_payment_status ON orders(payment_status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);

-- Add updated_at trigger function (create if not exists)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add updated_at trigger (drop first if exists, then create)
DROP TRIGGER IF EXISTS update_orders_updated_at ON orders;
CREATE TRIGGER update_orders_updated_at
  BEFORE UPDATE ON orders
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Note: RLS is disabled by default to allow public inserts
-- If you need RLS, uncomment the following:
-- ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Anyone can create orders" ON orders
--   FOR INSERT
--   TO public
--   WITH CHECK (true);

