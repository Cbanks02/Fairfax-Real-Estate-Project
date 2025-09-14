-- I added additional filters to both queries to exclude potential outliers that could skew the data, including price gaps exceeding $300,000 or below -$300,000, 
-- and total property (land and building) square footage exceeding 40,000. Due to minimal sample size, non valid sales, or missing data,
-- the sales between years between 2016 - 2025 were not inlcuded in calculations

---------------------------------------------------------------------------------
-- Joining sales, land, and assessed value tables into one dataset

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

-- What year did each property size category have the highest annual appreciation compared to their 2025 assessed value?

SELECT
EXTRACT(YEAR FROM saledt) AS Sale_year,
ROUND(AVG((aprtot - price )/price) * 100.0, 1) AS avg_appreciation_percent,
CASE
	WHEN (sf + (acres * 43560)) >= 15000 THEN 'large'
	WHEN (sf + (acres * 43560)) >= 5000 THEN 'medium'
		ELSE 'small'
END AS property_size_category
FROM fairfax_property_data
Where saledt between '2010-01-01' AND '2015-12-31'
AND ABS (price - aprtot) < 300000
GROUP BY sale_year, property_size_category
ORDER BY property_size_category DESC;


-- What property size category appreciated the most overall?

SELECT
CASE
	WHEN (sf + (acres * 43560)) >= 15000 THEN 'large'
	WHEN (sf + (acres * 43560)) >= 5000 THEN 'medium'
		ELSE 'small'
END AS property_size_category,
ROUND(AVG((aprtot - price )/price) * 100.0, 2) AS appreciation_percent
FROM fairfax_property_data
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND ABS (price - aprtot) < 300000
GROUP BY property_size_category
ORDER BY appreciation_percent;















