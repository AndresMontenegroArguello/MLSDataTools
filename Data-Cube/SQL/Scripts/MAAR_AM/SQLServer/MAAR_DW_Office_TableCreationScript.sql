/* 
* 
* Data-Cube POC Office Table Creation Script (Transact-SQL)
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jul 10, 2019
* MLS Data Tools
* 
*/

CREATE TABLE [DimListingOffice] (
                        "ListOfficeID" VARCHAR PRIMARY KEY,
                        "OFFICE_OFFICENAME" VARCHAR,
                        "OFFICE_PHONE" VARCHAR,
                        "listOffice_MUI" VARCHAR,
                        "listOfficeNRDSOfficeID" VARCHAR
                    );


CREATE TABLE [DimSalesOffice] (
                        "SalesOfficeID" VARCHAR PRIMARY KEY,
                        "OFFICE_SELLINGOFFICE" VARCHAR,
                        "salesOffice_MUI" VARCHAR,
                        "salesOfficeNRDSOfficeID" VARCHAR
                    );
