# Fairfax-Real-Estate-Project


##Project Objective
-

In this project I compare 2010 to 2015 single-family home sales data with their 2025 assessed values.
My analysis covers the following questions:

-- What year did each property size category have the highest annual appreciation compared to their 2025 assessed value by year?
-- What property size category appreciated the most overall?
-- which year has the biggest price gaps?
-- What properties sold furthest below their 2025 assessed values?



##Dataset
-
Source: I recieved my datasets from https://data.virginia.gov/

Raw Data: I worked with three large CSV files containing 2025 assessed property values, land information, and property sales data for Fairfax County, Virginia. Together, these files held over one million rows of raw records, with missing values, outliers, and historical entries extending back before 1990. Using PostgreSQL, I cleaned, standardized, and joined the data by matching parcel IDs into a unified fairfax_property_data table, ensuring accuracy across sources. Once the data was prepared, I performed exploratory analysis and ran queries to reveal meaningful patterns and insights.



##Technology 
-

-- *SQL(PostGRE)* - Data cleaning, filtering, joins, case, writing queries, and analysis
-- *Tableau* - Dashboards, data vizualizations, trends,
-- *GitHub* - Project sharing
-- *Excel* - Preliminary Cleaning

##Findings
-

-- Small properties experienced the highest peak appreciation. Annual appreciation was highest on average in the small property category. Property sizes were defined using total square footage, including both the home and the land. Property size categories were defined by total square footage: small is less than 5,000 sq ft, medium is 5,000–9,999 sq ft, and large is 10,000 - 40,000 sq ft or more.

--	The largest average price gap occurred in 2010. The difference between the 2025 assessed value and actual sale price was highest in 2010 across all property sizes. The average price gap decreased over time, with 2015 showing the smallest gap.

-- Large properties were most likely to sell below their assessed value. When comparing assessed values to actual sales, large single-family homes on average had the biggest percentage below their 2025 assessed values, followed by small properties. Medium-sized homes had the smallest percentage, which indicates a closer alignment with 2025 assessed value.


## About Me
Hi, I am Cameron Banks, a current grad student studying analytics with a concentration in computational data (data science) at Georgia Tech. I hold a B.S. in Information Logistics Technology from Virginia State University and have experience in data analytics, IT, and project analysis. I am passioniate about all aspects of data and its use to solve problems and make strategic descisions. This project showcases my skills in SQL, data analysis, and business intelligiance focused analysis.
