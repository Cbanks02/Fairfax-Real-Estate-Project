-- I added additional filters to all queries to exclude potential outliers that could skew the data, including price gaps exceeding $750,000 or below -$750,000, 
-- Due to minimal sample size, non valid sales, or missing data, the sales between years between 2016 - 2025 were not inlcuded in calculations

-- which year has the biggest price gaps?

SELECT
EXTRACT (YEAR FROM saledt) AS sale_year,
Round(AVG(price::numeric - aprtot),0) AS avg_price_gap
FROM sales_data
JOIN assessed_values ON sales_data.parid = assessed_values.parid
JOIN land_data ON sales_data.parid = land_data.parid
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND ABS (price - aprtot) < '750000'
GROUP BY EXTRACT (YEAR FROM saledt)
ORDER BY avg_price_gap ASC;


--Trend Query for biggest price gaps.

SELECT
EXTRACT (YEAR FROM saledt) AS sale_year,
price,
aprtot,
Round((price::numeric - aprtot),0) AS price_gap,
code_desc
FROM sales_data
JOIN assessed_values ON sales_data.parid = assessed_values.parid
JOIN land_data ON sales_data.parid = land_data.parid
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND ABS (price - aprtot) < '750000'
GROUP BY EXTRACT (YEAR FROM saledt), Round((price - aprtot),0), price,
aprtot, code_desc
ORDER BY price_gap ASC;


-- What properties are more likely to sell further below or above their 2025 assessed values?
-- I used a CTE improve the readability of my SQL query.

SELECT
property_size_category,
COUNT(*) AS total_properties,
SUM (CASE WHEN price > aprtot THEN 1 ELSE 0 END) AS sold_above,
SUM (CASE WHEN price < aprtot THEN 1 ELSE 0 END) AS sold_below,
ROUND(100.0 * SUM(CASE WHEN price > aprtot THEN 1 ELSE 0 END) / COUNT(*), 1) AS percent_above,
ROUND(100.0 * SUM(CASE WHEN price < aprtot THEN 1 ELSE 0 END) / COUNT(*), 1) AS percent_below
FROM ( 
SELECT*,
CASE
	WHEN (sf + (acres * 43560)) >= 10000 THEN 'large'
	WHEN (sf + (acres * 43560)) >= 5000 THEN 'medium'
		ELSE 'small'
			END AS property_size_category
FROM land_data
JOIN assessed_values ON land_data.parid = assessed_values.parid
JOIN sales_data ON land_data.parid = sales_data.parid
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND (sf + (acres * 43660)) < 40000
AND ABS (price - aprtot) < '750000')
GROUP BY property_size_category;

















