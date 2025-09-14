--For this personal project, I deleted rows for simplicity. 
--In a professional setting, I would preserve raw data and filter instead. 


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


--Deleting appraisal totals over $800,000.
DELETE 
FROM assessed_values 
WHERE aprtot > '800000'

