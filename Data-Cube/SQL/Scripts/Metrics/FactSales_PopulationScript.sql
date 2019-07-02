/* FactSales_PopulationScript.sql */

INSERT INTO FactSales (
						SoldCount, 
						SoldVolume, 
						SoldAverage, 
						SoldAveragePrice, 
						ActiveAveragePrice, 
						DaysOnMarket, 
						CumulativeDaysOnMarket,
						SoldToListRatio
					)
					VALUES (
						SoldCountMetric(),
						SoldVolumeMetric(),
						SoldAverageMetric(),
						SoldAveragePriceMetric(),
						ActiveAveragePriceMetric(),
						DaysOnMarketMetric(),
						CumulativeDaysOnMarketMetric(),
						SoldToListRatioMetric()
						);
