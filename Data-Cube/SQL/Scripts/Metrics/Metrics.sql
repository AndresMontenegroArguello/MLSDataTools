/* 
* 
* Basic Metrics Property Table - Initial Testing
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jun 07, 2019
* MLS Data Tools
* 
*/

/*
*---------------*
* Basic Metrics *
*---------------*
*/

/* Sold Count Metric */

SELECT 
COALESCE(COUNT("SalesCloseDate"), 0) 
AS "Sold Count"
FROM "propertyraw";

/* Sold Volume Metric */

SELECT 
SUM(COALESCE("SalesClosePrice", 0))
AS "Sold Volume"
FROM "propertyraw";

/* Sold Average Metric */

SELECT 
AVG("SalesClosePrice")
AS "Sold Avg"
FROM "propertyraw";

/* Sold Median Price Metric */

SELECT
QUANTILE(COALESCE("SalesClosePrice", 0), 0.5)
AS "Sold Median"
FROM "propertyraw";

/* Active Average Price Metric */

SELECT
AVG("LISTPRICE")
AS "Active Average"
FROM "propertyraw";

/* Days On Market Metric */

SELECT
AVG(COALESCE("DAYSONMARKET", 0)) 
AS "DOM"
FROM "propertyraw";

/* Cumulative Days on Market Metric */

SELECT
AVG(COALESCE("DaysOnMarketCumulative", 0))
AS "CDOM"
FROM "propertyraw";

/* Sold-To-List-Ratio Metric = Sold Average Price / Active Average Price */

SELECT 
AVG("SaleslosePrice")/AVG("LISTPRICE")
AS "Sold/List Ratio"
FROM "propertyraw";

/* Active Count Metric */

SELECT
COUNT(*)
AS "Active Count"
FROM "propertyraw"
WHERE
"MLSID" = 'RMLS'
AND
"offmarketdate" > '2009-01-01'
AND
"LISTDATE" < '2009-12-31';

/* Monthly Supply Metric */

SELECT
(SELECT
COUNT(*)
AS "Active Count"
FROM "propertyraw"
WHERE
(
"MLSID" = 'RMLS'
AND
"offmarketdate" > '2009-01-01'
AND
"LISTDATE" < '2009-12-31'
)
)/COUNT(*)
AS "Month Supply"


/*
*------------------------*
* Combined Metrics Query *
*------------------------*
*/

/* Combined Query */

SELECT *,
("Active Count"::FLOAT/"Sold Count"::FLOAT) AS "Month Supply"
FROM
(SELECT TO_CHAR("SalesCloseDate",'Mon-YYYY') AS "Month",
COALESCE(COUNT("SalesCloseDate"),0) AS "Sold Count",
AVG("LISTPRICE") AS "Active Average",
AVG("SalesClosePrice") AS "Sold Average",
AVG(COALESCE("DAYSONMARKET",0)) AS "DOM",
SUM(COALESCE("SalesClosePrice",0)) AS "Sold Volume",
QUANTILE(COALESCE("SalesClosePrice",0),0.5) AS "Sold Median Sold",
AVG(COALESCE("DaysOnMarketCumulative",0))  AS "CDOM",
result."Active Count" AS "Active Count",
AVG("SalesClosePrice")/AVG("LISTPRICE") AS "Sold/List"
FROM "propertyraw"
JOIN (SELECT TO_CHAR("SalesCloseDate",'Mon-YYYY') AS "Monthly",
COUNT(*) AS "Active Count"
FROM "propertyraw"
WHERE (( "MLSID" = 'RMLS'))
AND ("offmarketdate" > '2009-01-01')
AND ("LISTDATE" < '2009-12-31')
GROUP BY TO_CHAR("SalesCloseDate",'Mon-YYYY')) AS result ON result."Monthly"= TO_CHAR("SalesCloseDate",'Mon-YYYY')
WHERE date_part('year',  "SalesCloseDate") = 2009
GROUP BY to_char("SalesCloseDate",'Mon-YYYY'), result."Active Count") AS result;

/* Global Query */
/* Written by Andrés Montenegro */
SELECT
(
/* Sold Count Metric */
SELECT 
COALESCE(COUNT("SalesCloseDate"), 0) 
AS "Sold Count"
FROM "propertyraw"
),
(
/* Sold Volume Metric */
SELECT 
SUM(COALESCE("SalesClosePrice", 0))
AS "Sold Volume"
FROM "propertyraw"
),
(
/* Sold Average Metric */
SELECT 
AVG("SalesClosePrice")
AS "Sold Avg"
FROM "propertyraw"
),
(
/* Sold Median Price Metric */
SELECT
QUANTILE(COALESCE("SalesClosePrice", 0), 0.5)
AS "Sold Median"
FROM "propertyraw"
),
(
/* Active Average Price Metric */
SELECT
AVG("LISTPRICE")
AS "Active Average"
FROM "propertyraw"
),
(
/* Days On Market Metric */
SELECT
AVG(COALESCE("DAYSONMARKET", 0)) 
AS "DOM"
FROM "propertyraw"
),
(
/* Cumulative Days on Market Metric */
SELECT
AVG(COALESCE("DaysOnMarketCumulative", 0))
AS "CDOM"
FROM "propertyraw"
(
/* Sold-To-List-Ration Metric = Sold Average Price / Active Average Price */
SELECT 
AVG("SaleslosePrice")/AVG("LISTPRICE")
AS "Sold/List Ratio"
FROM "propertyraw"
),
(
/* Active Count Metric */
SELECT
COUNT(*)
AS "Active Count"
FROM "propertyraw"
WHERE
"MLSID" = 'RMLS-RETS'
AND
"offmarketdate" > '2009-01-01'
AND
"LISTDATE" < '2009-12-31'
),
/* Monthly Supply Metric */
(
SELECT
(SELECT
COUNT(*)
AS "Active Count"
FROM "propertyraw"
WHERE
(
"MLSID" = 'RMLS'
AND
"offmarketdate" > '2009-01-01'
AND
"LISTDATE" < '2009-12-31'
)
)/COUNT(*)
AS "Month Supply"
)
