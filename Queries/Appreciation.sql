-- I added additional filters to both queries to exclude potential outliers that could skew the data, including price gaps exceeding $300,000 or below -$300,000, 
-- and total property (land and building) square footage exceeding 40,000. Due to minimal sample size, non valid sales, or missing data,
-- the sales between years between 2016 - 2025 were not inlcuded in calculations

-- What year did each property size category have the highest annual appreciation compared to their 2025 assessed value?

SELECT
EXTRACT(YEAR FROM saledt) AS Sale_year,
ROUND(AVG((aprtot - price )/price) * 100.0, 1) AS avg_appreciation_percent,
CASE
	WHEN (sf + (acres * 43560)) >= 10000 THEN 'large'
	WHEN (sf + (acres * 43560)) >= 5000 THEN 'medium'
		ELSE 'small'
END AS property_size_category
FROM land_data
JOIN sales_data ON land_data.parid = sales_data.parid
JOIN assessed_values ON land_data.parid = assessed_values.parid
Where saledt between '2010-01-01' AND '2015-12-31'
AND (sf + (acres * 43660)) <= 40000
AND ABS (price - aprtot) < '750000'
GROUP BY sale_year, property_size_category
ORDER BY property_size_category DESC;


-- What property size category appreciated the most overall?

SELECT
CASE
	WHEN (sf + (acres * 43560)) >= 10000 THEN 'large'
	WHEN (sf + (acres * 43560)) >= 5000 THEN 'medium'
		ELSE 'small'
END AS property_size_category,
ROUND(AVG((aprtot - price )/price) * 100.0, 1) AS appreciation_percent
FROM land_data
JOIN sales_data ON land_data.parid = sales_data.parid
JOIN assessed_values ON land_data.parid = assessed_values.parid
WHERE saledt BETWEEN '2010-01-01' AND '2015-12-31'
AND (sf + (acres * 43660)) <= 40000
AND ABS (price - aprtot) < '750000'
GROUP BY property_size_category
ORDER BY appreciation_percent;















