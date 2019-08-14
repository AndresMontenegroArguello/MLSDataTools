/* 
* 
* Data-Cube Metrics Parameterized Stored Procedures For Closed Listings Fact Table Script (Transact-SQL)
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jul 18, 2019
* MLS Data Tools
* 
*/


/*
*-------------------*
* Sold Count Metric *
*-------------------*
*/

IF OBJECT_ID (N'dbo.SoldCountMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [SoldCountMeasure];  
GO  

CREATE FUNCTION [SoldCountMeasure](@PropertyId INT)
RETURNS INT   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	COALESCE(COUNT([CLOSEDATE]), 0)
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;


/* Excecution */

SELECT [SoldCountMeasure](1);


/*
*--------------------*
* Sold Volume Metric *
*--------------------*
*/


IF OBJECT_ID (N'dbo.SoldVolumeMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [SoldVolumeMeasure];  
GO  

CREATE FUNCTION [SoldVolumeMeasure](@PropertyId INT)
RETURNS NUMERIC   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	SUM(COALESCE([CLOSEPRICE], 0))
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [SoldVolumeMeasure] @PropertyId = 1;

/*
*--------------------------*
* Sold Median Price Metric *
*--------------------------*
*/

IF OBJECT_ID (N'dbo.SoldMedianPriceMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [SoldMedianPriceMeasure];  
GO  

CREATE FUNCTION [SoldMedianPriceMeasure](@PropertyId INT)
RETURNS MONEY   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	PERCENTILE_CONT(0.5) 
  	WITHIN GROUP (ORDER BY [CLOSEPRICE]) OVER (PARTITION BY [CLOSEPRICE])
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [SoldMedianPriceMeasure] @PropertyId = 1;

/*
*-----------------------------*
* Sold Average Price Metric *
*-----------------------------*
*/

IF OBJECT_ID (N'dbo.SoldAveragePriceMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [SoldAveragePriceMeasure];  
GO  

CREATE FUNCTION [SoldAveragePriceMeasure](@PropertyId INT)
RETURNS MONEY   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	AVG(CAST([CLOSEPRICE] AS INT))
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [SoldAveragePriceMeasure] @PropertyId = 1;

/*
*-----------------------------*
* Active Average Price Metric *
*-----------------------------*
*/

IF OBJECT_ID (N'dbo.ActiveAveragePriceMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [ActiveAveragePriceMeasure];  
GO  


CREATE FUNCTION [ActiveAveragePriceMeasure](@PropertyId INT)
RETURNS MONEY   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	AVG(CAST([LISTPRICE] AS INT))
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [ActiveAveragePriceMeasure] @PropertyId = 1;

/*
*-----------------------------*
* Days On Market (DOM) Metric *
*-----------------------------*
*/

IF OBJECT_ID (N'dbo.DaysOnMarketMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [DaysOnMarketMeasure];  
GO  

CREATE FUNCTION [DaysOnMarketMeasure](@PropertyId INT)
RETURNS INT   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	AVG(COALESCE(CAST([DAYSONMARKET] AS INT), 0)) 
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [DaysOnMarketMeasure] @PropertyId = 1;


/*
*----------------------------------*
* Cumulative Days On Market (CDOM) *
*----------------------------------*
*/

IF OBJECT_ID (N'dbo.CumulativeDaysOnMarketMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [CumulativeDaysOnMarketMeasure];  
GO  

CREATE FUNCTION [CumulativeDaysOnMarketMeasure](@PropertyId INT)
RETURNS INT   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	AVG(COALESCE(CAST([DaysOnMarketCumulative] AS INT), 0))
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [CumulativeDaysOnMarketMeasure] @PropertyId = 1;

/*
*---------------------------*
* Sold-To-List Ratio Metric *
*---------------------------*
*/

IF OBJECT_ID (N'dbo.SoldToListRatioMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [SoldToListRatioMeasure];  
GO  

CREATE FUNCTION [SoldToListRatioMeasure](@PropertyId INT)
RETURNS NUMERIC   
AS 
BEGIN
	DECLARE @ret INT;
	SELECT @ret =  
	AVG(CAST([CLOSEPRICE] AS INT))/ NULLIF(AVG(CAST([LISTPRICE] AS INT)), 0)
	FROM [Property]
	WHERE [LISTINGID] = @PropertyId;
RETURN @ret;
END;

/* Excecution */

EXECUTE [SoldToListRatioMeasure] @PropertyId = 1;


/*
*---------------------*
* Active Count Metric *
*---------------------*
*/

IF OBJECT_ID (N'dbo.ActiveCountMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [ActiveCountMeasure];  
GO  

CREATE FUNCTION [ActiveCountMeasure](@PropertyId INT)
RETURNS INT
AS
BEGIN
	DECLARE @ret INT;
	SELECT @ret = 
	COUNT(*)
	FROM [Property]
	WHERE
	[LISTINGID] = @PropertyId
	AND
	[MLSID] = 'RMLS'
	AND
	[offmarketdate] > '1990-01-01'
	AND
	[LISTDATE] < '2020-12-31';
RETURN @ret;
END;

/* Excecution */

EXECUTE [ActiveCountMeasure] @PropertyId = 1;


/*
*-----------------------*
* Monthly Supply Metric *
*-----------------------*
*/

IF OBJECT_ID (N'dbo.MonthlySupplyMeasure', N'FN') IS NOT NULL  
    DROP FUNCTION [MonthlySupplyMeasure];  
GO  

CREATE FUNCTION [MonthlySupplyMeasure](@PropertyId INT)
RETURNS INT
AS
BEGIN
	DECLARE @ret INT;
	SELECT @ret =
	(SELECT
	COUNT(*)
	FROM [Property]
	WHERE
	[LISTINGID] = @PropertyId
	AND
	[MLSID] = 'RMLS'
	AND
	[offmarketdate] > '1990-01-01'
	AND
	[LISTDATE] < '2020-12-31'
	)/COUNT(*)
RETURN @ret;
END;

/* Excecution */

EXECUTE [MonthlySupplyMeasure] @PropertyId = 1;

