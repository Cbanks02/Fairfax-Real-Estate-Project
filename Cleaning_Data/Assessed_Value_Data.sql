-- Dropping prior assessed colomns. 
ALTER TABLE assessed_values
DROP COLUMN priland,
DROP COLUMN pribldg,
DROP COLUMN pritot;

-- Deleting rows with "tax exempt" under the description column.
Delete 
FROM assessed_values
WHERE description = 'Tax Exempt';

-- Deleting rows with zero values.
DELETE
FROM assessed_values
WHERE aprland = '0' 
OR aprbldg = '0' 
OR aprtot = '0'
OR description = '0';

--Deleting rows with null values.
DELETE
FROM assessed_values
WHERE aprland IS NULL
OR aprbldg IS NULL
OR aprtot IS NULL;


