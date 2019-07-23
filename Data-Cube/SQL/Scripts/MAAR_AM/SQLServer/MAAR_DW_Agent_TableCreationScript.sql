/* 
* 
* Data-Cube POC Agent Tables Creation Script (Transact-SQL)
* Written by Andrés Montenegro <andres.m@mlsdatatools.com>
* Jul 10, 2019
* MLS Data Tools
* 
*/

CREATE TABLE [DimListingAgent1] (
                        "ListAgent1AgentID" VARCHAR PRIMARY KEY,
                        "listAgent1_MUI" VARCHAR,
                        "ListAgent1Name" VARCHAR,
                        "ListAgent1Phone" VARCHAR,
                        "listAgent1NRDSMemberID" VARCHAR
                    );


CREATE TABLE [DimListingAgent2] (
                        "ListAgent2AgentID" VARCHAR PRIMARY KEY,
                        "listagent2agentid" VARCHAR,
                        "listAgent2_MUI" VARCHAR,
                        "ListAgent2Name" VARCHAR,
                        "listagent2name" VARCHAR,
                        "listAgent2NRDSMemberID" VARCHAR
                    );


CREATE TABLE [DimSalesAgent1] (
                        "SalesAgent1AgentID" VARCHAR PRIMARY KEY,
                        "salesAgent1_MUI" VARCHAR,
                        "salesAgent1NRDSMemberID" VARCHAR,
                        "AGENT_SELLINGAGENT" VARCHAR
                    );


CREATE TABLE [DimSalesAgent2] (
                        "SalesAgent2AgentID" VARCHAR PRIMARY KEY,
                        "SalesAgent2_MUI" VARCHAR,
                        "SalesAgent2NRDSMemberID" VARCHAR,
                        "AGENT_FULLNAME" VARCHAR,
                        "AGENT_PREFERREDPHONE" VARCHAR
                    );

