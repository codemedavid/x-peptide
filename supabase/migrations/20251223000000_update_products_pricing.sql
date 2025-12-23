-- ============================================
-- X PEPTIDE - PRODUCT & PRICE UPDATE
-- Date: December 23, 2025
-- ============================================
-- Each product has 2 variations:
-- 1. Complete Set (with Insulin Syringe, 3ml Syringe, Alcohol Pads, Manual)
-- 2. Vial Only (+500 pesos for 3ml bac water / +1000 for 10ml bac water)
-- ============================================

-- Delete existing variations first (foreign key constraint)
DELETE FROM product_variations;

-- Delete existing products
DELETE FROM products;

-- ============================================
-- SETUP CATEGORIES (UUID based)
-- ============================================
-- Insert specific categories
INSERT INTO categories (id, name, icon, sort_order, active)
VALUES 
    ('508db912-3286-444a-9589-923188590632', 'Research Peptides', 'FlaskConical', 1, true),
    ('6e520d2c-352b-4029-a1b7-a3f81907cb93', 'Weight Loss', 'Scale', 2, true),
    ('d9341490-9512-4279-b1d5-257a55fa356a', 'Cosmetic & Skincare', 'Sparkles', 3, true)
ON CONFLICT (id) DO UPDATE SET 
    name = EXCLUDED.name,
    icon = EXCLUDED.icon,
    sort_order = EXCLUDED.sort_order,
    active = EXCLUDED.active,
    updated_at = NOW();

-- Deactivate any other categories
UPDATE categories SET active = false 
WHERE id NOT IN (
    '508db912-3286-444a-9589-923188590632', 
    '6e520d2c-352b-4029-a1b7-a3f81907cb93', 
    'd9341490-9512-4279-b1d5-257a55fa356a'
);

-- ============================================
-- INSERT ALL PRODUCTS
-- ============================================

INSERT INTO products (
    name, description, category, base_price, 
    purity_percentage, storage_conditions, inclusions,
    stock_quantity, available, featured
) VALUES

-- CJC-1290 + Ipamorelin
(
    'CJC-1290 + Ipamorelin',
    'Premium blend of CJC-1295 and Ipamorelin for enhanced growth hormone release. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    2500.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 CJC-1290 + Ipamorelin Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, true
),

-- BPC-157 + TB-500
(
    'BPC-157 + TB-500',
    'Powerful healing and recovery blend combining BPC-157 and TB-500 peptides. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    2500.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 BPC-157 + TB-500 Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, true
),

-- Tirzepatide 15mg
(
    'Tirzepatide 15mg',
    'Premium Tirzepatide 15mg for effective weight management and metabolic health. Available as Complete Set with all supplies or Vial Only.',
    '6e520d2c-352b-4029-a1b7-a3f81907cb93',
    3500.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Tirzepatide 15mg Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, true
),

-- Tirzepatide 30mg
(
    'Tirzepatide 30mg',
    'Premium Tirzepatide 30mg for advanced weight management and metabolic optimization. Available as Complete Set with all supplies or Vial Only.',
    '6e520d2c-352b-4029-a1b7-a3f81907cb93',
    6500.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Tirzepatide 30mg Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, true
),

-- Retatrutide 15mg
(
    'Retatrutide 15mg',
    'Next-generation triple agonist peptide for comprehensive metabolic support. Available as Complete Set with all supplies or Vial Only.',
    '6e520d2c-352b-4029-a1b7-a3f81907cb93',
    4000.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Retatrutide 15mg Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, true
),

-- AOD-9604
(
    'AOD-9604',
    'Advanced fat metabolism peptide fragment for targeted body composition improvement. Available as Complete Set with all supplies or Vial Only.',
    '6e520d2c-352b-4029-a1b7-a3f81907cb93',
    6000.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 AOD-9604 Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- MOTS-C
(
    'MOTS-C',
    'Mitochondrial-derived peptide for enhanced metabolic regulation and exercise capacity. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    2000.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 MOTS-C Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- GHK-Cu
(
    'GHK-Cu',
    'Copper peptide for skin regeneration, wound healing, and anti-aging benefits. Available as Complete Set with all supplies or Vial Only.',
    'd9341490-9512-4279-b1d5-257a55fa356a',
    2000.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 GHK-Cu Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- Epithalon
(
    'Epithalon',
    'Telomerase-activating peptide for longevity and cellular health support. Available as Complete Set with all supplies or Vial Only.',
    'd9341490-9512-4279-b1d5-257a55fa356a',
    2500.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 Epithalon Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- Semax Inhaler
(
    'Semax Inhaler',
    'Neuroprotective peptide in convenient inhaler format for cognitive enhancement. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    2500.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Semax Inhaler', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- Semax Injectable
(
    'Semax Injectable',
    'Premium injectable Semax for maximum absorption and cognitive benefits. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    3000.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Semax Injectable Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- Selank Inhaler
(
    'Selank Inhaler',
    'Anti-anxiety peptide in inhaler format for convenient daily use and stress relief. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    2500.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Selank Inhaler', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- Selank Injectable
(
    'Selank Injectable',
    'Premium injectable Selank for optimal anti-anxiety and nootropic effects. Available as Complete Set with all supplies or Vial Only.',
    '508db912-3286-444a-9589-923188590632',
    3000.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Selank Injectable Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- PT-141
(
    'PT-141',
    'Peptide for enhanced intimate wellness and libido support. Available as Complete Set with all supplies or Vial Only.',
    '6e520d2c-352b-4029-a1b7-a3f81907cb93',
    1300.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 PT-141 Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- Glutathione
(
    'Glutathione',
    'Master antioxidant for detoxification, skin brightening, and immune support. Available as Complete Set with all supplies or Vial Only.',
    'd9341490-9512-4279-b1d5-257a55fa356a',
    1800.00,
    99.0,
    'Store at 2-8°C',
    ARRAY['🧬 Glutathione Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
),

-- SS-31
(
    'SS-31',
    'Mitochondria-targeted antioxidant peptide for cellular energy and aging support. Available as Complete Set with all supplies or Vial Only.',
    'd9341490-9512-4279-b1d5-257a55fa356a',
    1800.00,
    99.0,
    'Store at -20°C',
    ARRAY['🧬 SS-31 Vial', '💉 Insulin Syringe (Complete Set)', '💉 3ml Syringe (Complete Set)', '🧴 Alcohol Pads (Complete Set)', '📖 Manual (Complete Set)'],
    100, true, false
);

-- ============================================
-- INSERT PRODUCT VARIATIONS
-- Each product has 2 variations: Vial Only and Complete Set
-- ============================================

-- CJC-1290 + Ipamorelin variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2500.00, 100 FROM products WHERE name = 'CJC-1290 + Ipamorelin';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3500.00, 100 FROM products WHERE name = 'CJC-1290 + Ipamorelin';

-- BPC-157 + TB-500 variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2500.00, 100 FROM products WHERE name = 'BPC-157 + TB-500';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3500.00, 100 FROM products WHERE name = 'BPC-157 + TB-500';

-- Tirzepatide 15mg variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 15, 3500.00, 100 FROM products WHERE name = 'Tirzepatide 15mg';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 15, 4500.00, 100 FROM products WHERE name = 'Tirzepatide 15mg';

-- Tirzepatide 30mg variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 30, 6500.00, 100 FROM products WHERE name = 'Tirzepatide 30mg';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 30, 7500.00, 100 FROM products WHERE name = 'Tirzepatide 30mg';

-- Retatrutide 15mg variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 15, 4000.00, 100 FROM products WHERE name = 'Retatrutide 15mg';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 15, 5000.00, 100 FROM products WHERE name = 'Retatrutide 15mg';

-- AOD-9604 variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 6000.00, 100 FROM products WHERE name = 'AOD-9604';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 7000.00, 100 FROM products WHERE name = 'AOD-9604';

-- MOTS-C variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2000.00, 100 FROM products WHERE name = 'MOTS-C';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3000.00, 100 FROM products WHERE name = 'MOTS-C';

-- GHK-Cu variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2000.00, 100 FROM products WHERE name = 'GHK-Cu';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3000.00, 100 FROM products WHERE name = 'GHK-Cu';

-- Epithalon variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2500.00, 100 FROM products WHERE name = 'Epithalon';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3500.00, 100 FROM products WHERE name = 'Epithalon';

-- Semax Inhaler variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2500.00, 100 FROM products WHERE name = 'Semax Inhaler';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3500.00, 100 FROM products WHERE name = 'Semax Inhaler';

-- Semax Injectable variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 3000.00, 100 FROM products WHERE name = 'Semax Injectable';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 4000.00, 100 FROM products WHERE name = 'Semax Injectable';

-- Selank Inhaler variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 2500.00, 100 FROM products WHERE name = 'Selank Inhaler';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 3500.00, 100 FROM products WHERE name = 'Selank Inhaler';

-- Selank Injectable variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 3000.00, 100 FROM products WHERE name = 'Selank Injectable';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 4000.00, 100 FROM products WHERE name = 'Selank Injectable';

-- PT-141 variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 1300.00, 100 FROM products WHERE name = 'PT-141';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 1800.00, 100 FROM products WHERE name = 'PT-141';

-- Glutathione variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 1800.00, 100 FROM products WHERE name = 'Glutathione';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 2500.00, 100 FROM products WHERE name = 'Glutathione';

-- SS-31 variations
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Vial Only', 1, 1800.00, 100 FROM products WHERE name = 'SS-31';
INSERT INTO product_variations (product_id, name, quantity_mg, price, stock_quantity)
SELECT id, 'Complete Set', 1, 2500.00, 100 FROM products WHERE name = 'SS-31';


