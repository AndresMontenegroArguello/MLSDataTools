/* 
* 
* Data-Cube Metrics Stored Procedures Script
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jun 10, 2019
* MLS Data Tools
* 
*/


/*
*-------------------*
* Sold Count Metric *
*-------------------*
*/

CREATE OR REPLACE FUNCTION SoldCountMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	SoldCount NUMERIC;
BEGIN
	SELECT 
	COALESCE(COUNT("SalesCloseDate"), 0)
	INTO SoldCount
	FROM "propertyraw";
RETURN SoldCount;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT SoldCountMetric() AS "Sold Count"


/*
*--------------------*
* Sold Volume Metric *
*--------------------*
*/

CREATE OR REPLACE FUNCTION SoldVolumeMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	SoldVolume NUMERIC;
BEGIN
	SELECT 
	SUM(COALESCE("SalesClosePrice", 0))
	INTO SoldVolume
	FROM "propertyraw";
RETURN SoldVolume;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT SoldVolumeMetric() AS "Sold Volume"


/*
*---------------------*
* Sold Average Metric *
*---------------------*
*/

CREATE OR REPLACE FUNCTION SoldAverageMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	SoldAverage NUMERIC;
BEGIN
	SELECT 
	COALESCE(COUNT("SalesCloseDate"), 0)
	INTO SoldAverage
	FROM "propertyraw";
RETURN SoldAverage;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT SoldAverageMetric() AS "Sold Average"


/*
*--------------------------*
* Sold Median Price Metric *
*--------------------------*
*/


/* https://mlsdatatools.atlassian.net/browse/DC-176 */



/*
*-----------------------------*
* Sold Average Price Metric *
*-----------------------------*
*/

CREATE OR REPLACE FUNCTION SoldAveragePriceMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	SoldAveragePrice NUMERIC;
BEGIN
	SELECT 
	AVG("SalesClosePrice")
	INTO SoldAveragePrice
	FROM "propertyraw";
RETURN SoldAveragePrice;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT SoldAveragePriceMetric() AS "Sold Average Price"


/*
*-----------------------------*
* Active Average Price Metric *
*-----------------------------*
*/

CREATE OR REPLACE FUNCTION ActiveAveragePriceMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	ActiveAveragePrice NUMERIC;
BEGIN
	SELECT 
	AVG("LISTPRICE")
	INTO ActiveAveragePrice
	FROM "propertyraw";
RETURN ActiveAveragePrice;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT ActiveAveragePriceMetric() AS "Active Average Price"


/*
*-----------------------------*
* Days On Market (DOM) Metric *
*-----------------------------*
*/

CREATE OR REPLACE FUNCTION DaysOnMarketMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	DOM NUMERIC;
BEGIN
	SELECT 
	AVG(COALESCE("DAYSONMARKET", 0)) 
	INTO DOM
	FROM "propertyraw";
RETURN DOM;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT DaysOnMarketMetric() AS "DOM"


/*
*----------------------------------*
* Cumulative Days On Market (CDOM) *
*----------------------------------*
*/

CREATE OR REPLACE FUNCTION CumulativeDaysOnMarketMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	CDOM NUMERIC;
BEGIN
	SELECT 
	AVG(COALESCE("DaysOnMarketCumulative", 0))
	INTO CDOM
	FROM "propertyraw";
RETURN CDOM;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT CumulativeDaysOnMarketMetric() AS "CDOM"


/*
*---------------------------*
* Sold-To-List Ratio Metric *
*---------------------------*
*/

CREATE OR REPLACE FUNCTION SoldToListRatioMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	SoldToListRatio NUMERIC;
BEGIN
	SELECT 
	AVG("SalesClosePrice")/AVG("LISTPRICE")
	INTO SoldToListRatio
	FROM "propertyraw";
RETURN SoldToListRatio;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT SoldToListRatioMetric() AS "Sold-To-List-Ratio"


/*
*---------------------*
* Active Count Metric *
*---------------------*
*/

CREATE OR REPLACE FUNCTION ActiveCountMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	ActiveCount NUMERIC;
BEGIN
	SELECT 
	COUNT(*)
	INTO ActiveCount
	FROM "propertyraw"
	WHERE
	"MLSID" = 'RMLS'
	AND
	"offmarketdate" > '2009-01-01'
	AND
	"LISTDATE" < '2009-12-31';
RETURN ActiveCount;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT ActiveCountMetric() AS "Active Count"

/*
*-----------------------*
* Monthly Supply Metric *
*-----------------------*
*/

CREATE OR REPLACE FUNCTION MonthlySupplyMetric()
RETURNS NUMERIC AS $RESULT$
DECLARE
	MonthlySupply NUMERIC;
BEGIN
	SELECT 
	/* *,("Active Count"::FLOAT/"Sold Count"::FLOAT) */
	ActiveCountMetric()/SoldCountMetric()
	INTO MonthlySupply
	FROM "propertyraw"
	WHERE
	(
	"MLSID" = 'RMLS'
	AND
	"offmarketdate" > '2009-01-01'
	AND
	"LISTDATE" < '2009-12-31'
	);
RETURN MonthlySupply;
END;
$RESULT$ LANGUAGE plpgsql;


/* Excecution */

SELECT MonthlySupplyMetric() AS "Monthly Supply"
