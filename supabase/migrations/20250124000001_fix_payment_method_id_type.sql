-- Fix payment_method_id column type in orders table
-- It should be TEXT to match payment_methods.id, not UUID

DO $$ 
BEGIN
  -- Check if column exists and is UUID
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'orders' 
    AND column_name = 'payment_method_id' 
    AND data_type = 'uuid'
  ) THEN
    -- Change column type to TEXT
    ALTER TABLE orders ALTER COLUMN payment_method_id TYPE TEXT;
  END IF;
END $$;

-- Also check promo_code_id, just in case (though it is usually UUID)
-- If promo codes use text IDs (like 'SALE2025'), this should be TEXT too.
-- Based on error "uuid: metrobank", it is definitely payment_method_id.
