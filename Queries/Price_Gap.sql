-- I added additional filters to both queries to exclude potential outliers that could skew the data, including price gaps exceeding $300,000 or below -$300,000, 
-- and total property (land and building) square footage exceeding 40,000. Due to minimal sample size, non valid sales, or missing data,
-- the sales between years between 2016 - 2025 were not inlcuded in calculations

---------------------------------------------------------------------------------
-- Joining sales, land, and assessed values into one dataset

CREATE TABLE fairfax_property_data AS
SELECT 
sales_data.parid, sales_data.saledt, sales_data.price,
land_data.sf, land_data.acres,
assessed_values.aprland, assessed_values.aprbldg, assessed_values.aprtot,
sales_data.saleval_desc, land_data.code_desc, assessed_values.description
FROM sales_data
JOIN land_data ON sales_data.parid = land_data.parid
JOIN assessed_values ON sales_data.parid = assessed_values.parid;
---------------------------------------------------------------------------------


-- which year has the biggest price gaps?

SELECT
EXTRACT (YEAR FROM saledt) AS sale_year,
Round(AVG(price - aprtot),0) AS avg_price_gap
FROM fairfax_property_data
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND ABS (price - aprtot) < 300000
GROUP BY EXTRACT (YEAR FROM saledt)
ORDER BY avg_price_gap ASC;


-- What properties sold further below their 2025 assessed values?
-- Propety sizes are categorized by total square footage (Property + Land).

SELECT
CASE
	WHEN (sf + (acres * 43560)) >= 15000 THEN 'large'
	WHEN (sf + (acres * 43560)) >= 5000 THEN 'medium'
		ELSE 'small'
			END AS property_size_category,
COUNT(*) AS total_properties,
SUM (CASE WHEN price > aprtot THEN 1 ELSE 0 END) AS sold_above,
SUM (CASE WHEN price < aprtot THEN 1 ELSE 0 END) AS sold_below,
ROUND(100.0 * SUM(CASE WHEN price > aprtot THEN 1 ELSE 0 END) / COUNT(*), 1) AS percent_above,
ROUND(100.0 * SUM(CASE WHEN price < aprtot THEN 1 ELSE 0 END) / COUNT(*), 1) AS percent_below
FROM fairfax_property_data
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND ABS (price - aprtot) < 300000
GROUP BY property_size_category;

















