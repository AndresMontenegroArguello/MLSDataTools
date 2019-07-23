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
                        [ListDate] DATETIME2 FOREIGN KEY ([ListDate]) REFERENCES [DimDate]([PK_Date]),
                        [SalesCloseDate] DATETIME2 FOREIGN KEY ([SalesCloseDate]) REFERENCES [DimDate]([PK_Date]),
                        [OffMarketDate] DATETIME2 FOREIGN KEY ([OffMarketDate]) REFERENCES [DimDate]([PK_Date]),
                        /*
                        [ListingAgent1AgentID] VARCHAR(MAX) REFERENCES ]DimListingAgent1]([ListAgent1AgentID]),
                        [ListingAgent1AgentID] VARCHAR(MAX) REFERENCES ]DimListingAgent2]([ListAgent2AgentID]),
                        [SalesAgent1AgentID] VARCHAR(MAX) REFERENCES ]DimSalesAgent1]([SalesAgent1AgentID]),
                        [SalesAgent2AgentID] VARCHAR(MAX) REFERENCES ]DimSalesAgent2]([SalesAgent2AgentID]),
                        [ListOfficeID] VARCHAR(MAX) REFERENCES ]DimListingOffice]([ListOfficeID]),
                        [SalesOfficeID] VARCHAR(MAX) REFERENCES ]DimSalesOffice]([SalesOfficeID]),
                        */
                        /* Measures */
                        [SoldCount] INTEGER,
                        [SoldVolume] NUMERIC,
                        [SoldAveragePrice] MONEY,
                        [ActiveAveragePrice] MONEY,
                        [DaysOnMarket] INTEGER,
                        [CumulativeDaysOnMarket] INTEGER,
                        [SoldToListRatio] NUMERIC
                        );
