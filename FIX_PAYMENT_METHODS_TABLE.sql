-- FIX_PAYMENT_METHODS_TABLE.sql
-- This script resets the payment_methods table to allow text IDs (like "metrobank")

BEGIN;

-- 1. First, remove any foreign key links from 'orders' to 'payment_methods'
-- This prevents "cannot drop table referenced by foreign key" errors
DO $$ 
DECLARE
    r RECORD;
BEGIN
    FOR r IN (
        SELECT conname 
        FROM pg_constraint 
        WHERE conrelid = 'orders'::regclass 
        AND confrelid = 'payment_methods'::regclass
    ) LOOP
        EXECUTE 'ALTER TABLE orders DROP CONSTRAINT ' || quote_ident(r.conname);
    END LOOP;
END $$;

-- 2. Drop the incorrect table
DROP TABLE IF EXISTS payment_methods;

-- 3. Recreate the table with ID as TEXT (not UUID)
CREATE TABLE payment_methods (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  account_number TEXT NOT NULL,
  account_name TEXT NOT NULL,
  qr_code_url TEXT DEFAULT '',
  active BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Re-insert default payment methods
INSERT INTO payment_methods (id, name, account_number, account_name, qr_code_url, active, sort_order) VALUES
('gcash', 'GCash', '0917 123 4567', 'Peptide Store', '', true, 1),
('bdo', 'BDO Bank Transfer', '0012 3456 7890', 'Peptide Store Inc.', '', true, 2),
('maya', 'Maya', '0917 123 4567', 'Peptide Store', '', true, 3);

-- 5. Ensure 'orders' table payment_method_id is also TEXT
ALTER TABLE orders ALTER COLUMN payment_method_id TYPE TEXT;

COMMIT;
