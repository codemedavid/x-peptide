-- Forcefully fix the payment_method_id column type
-- We start by dropping any potential foreign key constraints that might block the type change

DO $$ 
DECLARE
    r RECORD;
BEGIN
    -- unique loop to find and drop constraints on payment_method_id
    FOR r IN (
        SELECT conname 
        FROM pg_constraint 
        WHERE conrelid = 'orders'::regclass 
        AND conkey = ARRAY[(SELECT attnum FROM pg_attribute WHERE attrelid = 'orders'::regclass AND attname = 'payment_method_id')]
    ) LOOP
        EXECUTE 'ALTER TABLE orders DROP CONSTRAINT ' || quote_ident(r.conname);
    END LOOP;
END $$;

-- Now forcefully change the column type to TEXT
ALTER TABLE orders ALTER COLUMN payment_method_id TYPE TEXT USING payment_method_id::text;

-- Force schema cache reload
NOTIFY pgrst, 'reload schema';
