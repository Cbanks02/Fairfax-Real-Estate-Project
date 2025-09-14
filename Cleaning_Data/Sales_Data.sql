--For this personal project, I deleted rows for simplicity. 
--In a professional setting, I would preserve raw data and filter instead. 


-- Removing zero and null values from the price column.
DELETE
FROM sales_data
WHERE price = '0'
OR price IS NULL;


-- Removing null values and those that do not contain the word 'verified'
-- in the sales validation description column.
DELETE
FROM sales_data
WHERE saleval_desc IS NULL 
OR LOWER (saleval_desc) NOT LIKE '%verified%';


--Removing duplicate parcel IDs and keeping the most recent.  
DELETE
FROM sales_data
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31' 
AND saledt < (SELECT MAX (sales_data2.saledt)
FROM sales_data AS sales_data2
WHERE (sales_data2.parid) = sales_data.parid 
AND sales_data2.saledt BETWEEN '2010-01-01' AND '2015-12-31'
);


--Removing additional non-verified rows.
DELETE 
FROM sales_data
WHERE saleval_desc IN(
'Atypical price - could not be verified',
'Valid and verified multi-parcel sale'
);
