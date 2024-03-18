USE master
GO 
Drop database IF EXISTS SalesDW
GO
Create Database SalesDW
GO
USE SalesDW
GO

--- diagram star schema into snow flake into aggreg tables / views 

SELECT * FROM ProductSales

--CREATE TABLE SALES CHANNEL

DROP TABLE IF EXISTS SalesChannel
GO
CREATE TABLE SalesChannel(
ChannelID INT IDENTITY(1,1) PRIMARY KEY,
ChannelName VARCHAR(50) not null, 
CREATETIMESTAMP DATETIME,
UPDATETIMESTAMP DATETIME
)
GO

--POPULATE TABLE SALES CHANNEL 

Insert INTO SalesChannel 
SELECT DISTINCT SalesChannel,
current_timestamp as CreateTimeStamp,
current_timestamp as UpdateTimeStamp
from ProductSales


select * from SalesChannel

---create region dim
DROP TABLE IF EXISTS Region
GO
CREATE TABLE Region(
RegionID INT IDENTITY(1,1) PRIMARY KEY,
RegionName VARCHAR(50) not null, 
CREATETIMESTAMP DATETIME,
UPDATETIMESTAMP DATETIME
)
GO

-- check length of region field
select max(len(region))from ProductSales

--check contents of field
-- add additional region clean column to product sales
ALTER TABLE ProductSales 
ADD RegionClean VARCHAR(50)

SELECT * FROM ProductSales

UPDATE ProductSales
SET RegionClean=
CASE 
	WHEN Region = 'Central America and the C'
		THEN 'Central America and Carribean'
	WHEN Region = 'Middle East and North Afr'
		THEN 'ME and NAfrica'
	ELSE Region
END

-- populate region table 
Insert INTO Region 
SELECT DISTINCT RegionClean,
current_timestamp as CreateTimeStamp,
current_timestamp as UpdateTimeStamp
from ProductSales


-- diagram proces from now until this point 


-- create customer dim
DROP TABLE IF EXISTS Customer
Create TABLE Customer(
CustID INT Primary Key,
CustName VARCHAR(50) NOT NULL,
CREATETIMESTAMP DATETIME,
UPDATETIMESTAMP DATETIME)

-- populate customer table 
INSERT INTO Customer
SELECT DISTINCT CustID, CustName,
current_timestamp as CreateTimeStamp,
current_timestamp as UpdateTimeStamp
 from ProductSales


 SELECT * From Customer

 -- check if the same cust id associated with >1 cust name

 SELECT COUNT(CustName) FROM Customer
 GROUP BY CustID 
 ORDER BY COUNT(CustName) DESC

 -- all 1s = good news


 --- dimension product

 select ProductID from ProductSales
 WHERE ProductID !=ProductSold 
 --- if no difference, we know one field is redundant

 --productid will be pk - find out length 
 select MIN(len(productID)), max(len(productid)) from Productsales
 SELECT MIN(stdcost), MAX(stdcost) FROM ProductSales
 SELECT MIN(stdprice), MAX(stdprice) FROM ProductSales

 DROP TABLE IF EXISTS Product
 CREATE TABLE Product(
 ProductID CHAR(7) PRIMARY KEY,
 ProductName VARCHAR(50) NOT NULL,
 stdCost     DECIMAL(5,2) NOT NULL, 
 stdPrice    DECIMAL(5,2) NOT NULL,  
 CreateTimestamp DATETIME,
 UpdateTimestamp DATETIME
 )
 ---fyi normally put sales facts in a fact table - allows for price to change

 --Insert Product Data
INSERT INTO Product
SELECT DISTINCT productID, productName, stdCost, stdPrice,
CURRENT_TIMESTAMP AS CreateTimestamp,
CURRENT_TIMESTAMP AS UpdateTimestamp
FROM ProductSales

select * from Product

SELECT * FROM ProductSales

--- explore potential snowflake 
select distinct custid, count(SalesChannel) from productsales
group by custid


-- diagram out change + scd or other method 
-- alter product / expand range 
-- new cust/ alter cust name 


-- create customer dim 
DROP TABLE IF EXISTS Country

CREATE TABLE Country 
( 
 	CountryID INT IDENTITY(1,1) PRIMARY KEY, 
 	CountryName VARCHAR(50) NOT NULL, 
   	RegionID INT FOREIGN KEY REFERENCES Region(RegionID),
	CreateTimestamp DATETIME,
	UpdateTimestamp DATETIME
) 


-- populate the table - use a join because regionid is in a separate table 
select distinct ps.country, r.regionid,
CURRENT_TIMESTAMP AS CreateTimestamp,
CURRENT_TIMESTAMP AS UpdateTimestamp
from productsales ps INNER JOIN Region r
on ps.RegionClean = r.RegionName

--run query and check it (how) before inserting 
insert into country 
select distinct ps.country, r.regionid,
CURRENT_TIMESTAMP AS CreateTimestamp,
CURRENT_TIMESTAMP AS UpdateTimestamp
from productsales ps INNER JOIN Region r
on ps.RegionClean = r.RegionName

-- check the matches are there 
select * from Country
select * from Region

select count(countryname), regionid from country
group by regionid

select* from region

select * from region where regionid=5

-- define fact table 
DROP Table if exists Sale
CREATE TABLE Sale 
( 
    SaleID INT IDENTITY(1,1) PRIMARY KEY, 
    DateSold Date NOT NULL, 
    ProductID CHAR(7) NOT NULL FOREIGN KEY REFERENCES Product(ProductID),
    CustID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustID), 
    CountryID INT NOT NULL FOREIGN KEY REFERENCES Country(CountryID), 
    ChannelID INT NOT NULL FOREIGN KEY REFERENCES SalesChannel(ChannelID), 
    UnitsSold INT NOT NULL,
    CreateTimestamp DATETIME,
    UpdateTimestamp DATETIME
)  

-- Insert Sale table
INSERT INTO Sale  
SELECT         
 	ps.DateSold,  
 	ps.ProductID,  
 	ps.CustID,  
	c.CountryID,
	sc.ChannelID,
	ps.UnitsSold,
	CURRENT_TIMESTAMP AS CreateTimestamp,
    CURRENT_TIMESTAMP AS UpdateTimestamp
FROM ProductSales ps 
INNER JOIN Country c ON ps.Country =c.CountryName 
INNER JOIN SalesChannel sc ON ps.SalesChannel = sc.ChannelName


alter authorization on database::salesdw to sa



