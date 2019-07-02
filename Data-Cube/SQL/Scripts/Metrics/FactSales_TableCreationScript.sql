/* FactSales_TableCreationScript.sql */

CREATE TABLE FactSales (
	SoldCount NUMERIC,
	SoldVolume NUMERIC,
	SoldAverage NUMERIC,
	/* SoldMedian NUMERIC, -- https://mlsdatatools.atlassian.net/browse/DC-176 --*/
	SoldAveragePrice NUMERIC,
	ActiveAveragePrice NUMERIC,
	DaysOnMarket NUMERIC,
	CumulativeDaysOnMarket NUMERIC,
	SoldToListRatio NUMERIC
);
