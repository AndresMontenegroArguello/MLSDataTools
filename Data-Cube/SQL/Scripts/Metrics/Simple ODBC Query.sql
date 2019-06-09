/* 
 * 
 * Simple Query Script for Excel ODBC Pivot Table POC Testing 
 * Written by Andrés Montenegro <andres.m@mlsdatatools.com>
 * Jun 05, 2019
 * MLS Data Tools
 * 
 * */

SELECT 
	"SalesClosePrice", 
	"PostalCode", 
	"YearBuilt" 
FROM 
	"Property" 
WHERE 
	"YearBuilt" IS NOT NULL AND 
	"SalesClosePrice" IS NOT NULL AND
	"PostalCode" IS NOT NULL 
ORDER BY 
	"YearBuilt" 
    DESC 
LIMIT 2000;

