-- Removing zero and null values from the price column.
DELETE
FROM sales_data
WHERE price = '0'
OR price IS NULL;

-- Removing null values and those that do not contain the word 'verified' in the sales validation description column.
DELETE
FROM sales_data
WHERE saleval_desc IS NULL 
OR LOWER (saleval_desc) NOT LIKE '%verified%';

--Removing duplicates from the sales data table.
DELETE
FROM sales_data
WHERE (parid, saledt, price, saleval_desc) IN 
(SELECT parid, saledt, price, saleval_desc
FROM sales_data
GROUP BY parid, saledt, price, saleval_desc
HAVING COUNT (*) > 1);

--Removing additional non-verified rows.
DELETE 
FROM sales_data
WHERE saleval_desc = 'Atypical price - could not be verified';





