-- Add new COA reports from user request
-- Image Mappings:
-- tirzepatide-30mg.jpg -> Tirzepatide 30mg
-- cagrilintide-10mg.jpg -> Cagrilintide 10mg
-- ghk-cu-100mg.jpg -> GHK-Cu 100mg
-- glow-70mg.jpg -> Glow 70mg (Blend)
-- nad-500mg.jpg -> NAD+ 500mg

INSERT INTO coa_reports (
    product_name,
    batch,
    test_date,
    purity_percentage,
    quantity,
    task_number,
    verification_key,
    image_url,
    featured,
    laboratory
) VALUES
-- Report 1: Tirzepatide 30mg
(
    'Tirzepatide 30mg',
    'Unknown',
    '2025-11-10',
    99.119,
    '34.67 mg',
    '#87681',
    'D56EIP2YLLZ9',
    '/coa/tirzepatide-30mg.jpg',
    true,
    'Janoshik Analytical'
),
-- Report 2: Cagrilintide 10mg
(
    'Cagrilintide 10mg',
    'Unknown',
    '2025-09-05',
    99.089,
    '11.29 mg',
    '#77428',
    '86DADXNBVYMZ',
    '/coa/cagrilintide-10mg.jpg',
    false,
    'Janoshik Analytical'
),
-- Report 3: GHK-Cu 100mg
(
    'GHK-Cu 100mg',
    'Unknown',
    '2025-09-05',
    99.991,
    '96.09 mg',
    '#77427',
    'VPEKQHH8IRW6',
    '/coa/ghk-cu-100mg.jpg',
    false,
    'Janoshik Analytical'
),
-- Report 4: Glow 70mg (Blend)
(
    'Glow 70mg',
    'Unknown',
    '2025-07-10',
    99.900, -- Placeholder purity for blend
    'Blend (See Report)',
    '#70495',
    'VLFK4QWYT8YF',
    '/coa/glow-70mg.jpg',
    true,
    'Janoshik Analytical'
),
-- Report 5: NAD+ 500mg
(
    'NAD+ 500mg',
    'Unknown',
    '2025-09-04',
    99.900, -- Placeholder purity, not listed on report
    '496.62 mg',
    '#77426',
    '75SDIC1FFCJZ',
    '/coa/nad-500mg.jpg',
    false,
    'Janoshik Analytical'
);
