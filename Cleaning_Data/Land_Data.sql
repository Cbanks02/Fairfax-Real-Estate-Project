-- Removing zero values from the square footage and acres columns.
DELETE 
FROM land_data
WHERE sf = 0
AND acres = 0;


-- Removing null values from square foot, acres, and code description column.
DELETE 
FROM land_data
WHERE sf IS NULL 
AND acres IS NULL
AND code_desc IS NULL;


-- Removing duplicate rows.
DELETE
FROM land_data
WHERE (parid, sf, acres, code_desc) IN 
(SELECT parid, sf, acres, code_desc
FROM land_data
GROUP BY parid, sf, acres, code_desc
HAVING COUNT (*) > 1);


-- Removing values from the code description column that are not relevant to the analysis.
DELETE 
FROM land_data
WHERE Code_desc NOT IN (
'RESIDENTIAL',
'RESIDENTIAL STACKED TOWNHOUSE',
'RESIDENTIAL TOWNHOUSE',
'SINGLE DWELLING',
'TWNHSE END',
'TWNHSE INT'
);


-- Filling in missing values in the Square foot column.
UPDATE land_data
SET sf = ROUND(acres * 43560.0, 0)
WHERE sf = '0' AND acres > '0';


-- Filling in missing values in the acres column.
UPDATE land_data
SET acres = sf / 43560.0
WHERE acres = '0' AND sf > '0';


--Rounding the values in the acres column to four decimal places.
UPDATE land_data
SET acres = round(acres,4);


