/* 
* 
* Data-Cube POC ClosedListings Fact Table Population Script (Transact-SQL)
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jul 11, 2019
* MLS Data Tools
* 
*/

INSERT INTO [FactClosedListings] (
                        /* Keys */
                        [PropertyListingId],
                        [ListDate],
                        [SalesCloseDate],
                        [OffMarketDate],
                        /* Measures */
                        [SoldCount],
                        [SoldVolume],
                        [SoldAveragePrice],
                        [ActiveAveragePrice],
                        [DaysOnMarket],
                        [CumulativeDaysOnMarket],
                        [SoldToListRatio]
                        )
SELECT
                        [id],
                        CONVERT(DATETIME2, CONVERT(VARCHAR, [ListingAgreement])),
                        CONVERT(DATETIME2, CONVERT(VARCHAR, [CloseDate])),
                        CONVERT(DATETIME2, CONVERT(VARCHAR, [OffMarketDate])),
                        /* Measures */
                        dbo.SoldCountMeasure([id]),
                        dbo.SoldVolumeMeasure([id]),
                        dbo.SoldAveragePriceMeasure([id]),
                        dbo.ActiveAveragePriceMeasure([id]),
                        dbo.DaysOnMarketMeasure([id]),
                        dbo.CumulativeDaysOnMarketMeasure([id]),
                        dbo.SoldToListRatioMeasure([id])
FROM [Property];
