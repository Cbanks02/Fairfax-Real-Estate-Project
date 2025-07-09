-- which year has the biggest price gaps?
-- Due to minimal sample size, non valid sales, or missing data, 
-- the sales between years between 2016 - 2025 were not inlcuded in calculations

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














