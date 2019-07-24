/* 
* 
* Data-Cube POC ClosedListings Fact Table Creation Script (Transact-SQL)
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jul 11, 2019
* MLS Data Tools
* 
*/

CREATE TABLE [FactClosedListings] (
                        /* Keys */
                        [PropertyListingId] INTEGER FOREIGN KEY ([PropertyListingId]) REFERENCES [Property]([id]),
                        [ListDate] DATETIME FOREIGN KEY ([ListDate]) REFERENCES [DimDate]([PK_Date]),
                        [SalesCloseDate] DATETIME FOREIGN KEY ([SalesCloseDate]) REFERENCES [DimDate]([PK_Date]),
                        [OffMarketDate] DATETIME FOREIGN KEY ([OffMarketDate]) REFERENCES [DimDate]([PK_Date]),
                        /* Measures */
                        [SoldCount] INTEGER,
                        [SoldVolume] NUMERIC,
                        [SoldAveragePrice] MONEY,
                        [ActiveAveragePrice] MONEY,
                        [DaysOnMarket] INTEGER,
                        [CumulativeDaysOnMarket] INTEGER,
                        [SoldToListRatio] NUMERIC
                        );
