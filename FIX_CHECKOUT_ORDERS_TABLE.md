# Fix Checkout - Orders Table Issue

## Problem
The checkout is failing with error: "Could not find the table 'public.orders' in the schema cache"

## Solution

### Step 1: Apply the Migration

1. **Go to Supabase Dashboard**
   - Visit: https://supabase.com/dashboard
   - Select your project

2. **Open SQL Editor**
   - Click **"SQL Editor"** in the left sidebar
   - Click **"New Query"**

3. **Run the Migration**
   - Open the file: `supabase/migrations/20250117000000_ensure_orders_table.sql`
   - Copy ALL the contents
   - Paste into SQL Editor
   - Click **"Run"** (or Cmd/Ctrl + Enter)

4. **Verify It Worked**
   - You should see a success message
   - The orders table should now exist

### Step 2: Verify Table Exists

Run this SQL query to verify:

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name = 'orders';
```

You should see a row with `orders` in the result.

### Step 3: Test Checkout

1. Go to your website
2. Add items to cart
3. Go to checkout
4. Fill in the form
5. Place order
6. It should now work! ✅

---

## Alternative: If Migration Doesn't Work

If the migration doesn't work, you can manually create the table by running the SQL from `supabase/migrations/20250117000000_ensure_orders_table.sql` directly in the SQL Editor.

---

## What Was Fixed

1. ✅ Created a new migration file to ensure the orders table exists
2. ✅ Improved error handling in Checkout component to provide better error messages
3. ✅ The migration uses `CREATE TABLE IF NOT EXISTS` so it's safe to run multiple times

