use master 
go 
drop database if exists superstore_manual
go
create database superstore_manual
go
use superstore_manual 

drop table superstore_staging

select * from superstore_staging

-- create cust dim 
drop table if exists dimcust
create table dimcust(
custkey int identity(1,1) not null primary key, 
custid nvarchar(50) not null, 
custname varchar(50) not null,
segment varchar(50) not null,
createdate datetime not null,
updatedate datetime not null
)
--create surrogate key because in real life cust data could be coming from diff sources

select * from superstore_staging

--insert data from staging
insert into dimcust 
select distinct customer_id, customer_name, segment, 
current_timestamp as createdate,
current_timestamp as updatedate
from superstore_staging 

select * from dimcust

---create dimproduct
drop table if exists dimproduct
create table dimproduct(
productkey int identity(1,1) not null primary key, 
productid nvarchar(50) not null, 
category varchar(50) not null,
subcategory varchar(50) not null,
productname nvarchar(max) not null,
createdate datetime not null,
updatedate datetime not null
)
--- insert data from staging 

insert into dimproduct 
select distinct product_id, category, sub_category, product_name,
current_timestamp as createdate,
current_timestamp as updatedate
from superstore_staging 

select * from dimproduct

--create shipmodedim
drop table if exists dimshipmode
create table dimshipmode(
shipmodekey int identity(1,1) not null primary key, 
shipmode varchar(50) not null,
createdate datetime not null,
updatedate datetime not null
)

insert into dimshipmode
select distinct ship_mode, 
current_timestamp as createdate,
current_timestamp as updatedate
from superstore_staging

select * from dimshipmode


--create dimgeog
drop table if exists dimgeog
create table dimgeog(
geogkey int identity(1,1) not null primary key, 
postcode nchar(10) not null,
city varchar(50) not null,
[state] varchar(50) not null,
country varchar(50) not null,
region varchar(50) not null,
createdate datetime not null,
updatedate datetime not null
)

insert into dimgeog
select distinct postal_code,city,[state],country,region,
current_timestamp as createdate,
current_timestamp as updatedate
from superstore_staging

select * from dimgeog

--- dimdate 
--find out first and last dates 

select min(order_date), max(order_date) from superstore_staging
select min(ship_date), max(ship_date) from superstore_staging

--create table structure 

drop table if exists dimdate
create table dimdate(
datekey int identity(1,1) not null primary key, 
[date] datetime not null,
[day] int not null,
[week] int not null,
[month] int not null,
[quarter] int not null,
[year] int not null,
createdate datetime not null,
updatedate datetime not null
)


-- open date stored procedure, read through, amended params and execute to store it

exec createdimdate '2014-01-03','2018-01-05' --american format

select * from dimdate


--- alternative way to populate dim date - with query 
--- remember to run the full batch of the query in one go
declare @start datetime
declare @end datetime


select @start = min(order_date), @end = max(ship_date)
from superstore_staging

exec createdimdate @start, @end
------

---- create fact table - facts plus foreign keys 

drop table if exists factorderitem
create table factorderitem(
factkey int identity(1,1) primary key,
rowid int not null,
orderid nvarchar(50) not null,
sales float not null, 
qty int not null,
discount float not null,
profit float not null,
shipmodekey int foreign key references dimshipmode(shipmodekey),
custkey int foreign key references dimcust(custkey),
geogkey int foreign key references dimgeog(geogkey),
productkey int foreign key references dimproduct(productkey),
orderdatekey int foreign key references dimdate(datekey),
shipdatekey int foreign key references dimdate(datekey),
createdate datetime not null,
updatedate datetime not null
)

select * from superstore_staging

--- populate table using insert (facts) and joins (dims) (start by running select statement) 

insert into factorderitem
select ss.row_id, ss.order_id, ss.sales, ss.quantity, ss.profit, ss.discount,
sm.shipmodekey,c.custkey, g.geogkey, p.productkey, do.datekey, ds.datekey,
current_timestamp as createdate, current_timestamp as updatedate
from superstore_staging ss
inner join dimshipmode sm on ss.ship_mode = sm.shipmode
inner join dimcust c on ss.customer_id = c.custid
inner join dimgeog g on ss.postal_code = g.postcode and ss.city = g.city 
inner join dimproduct p on ss.product_id = p.productid and ss.product_name =p.productname
inner join dimdate do on ss.order_date =do.[date]
inner join dimdate ds on ss.ship_date = ds.[date]



--should check 1:1 relationship custid to name
select custid, count(custname) from dimcust group by custid 
order by count(custname) desc

--- geog requires postcode and city join (its not very true to life but in this examply granularity works)
select postcode, count(city) from dimgeog
group by postcode
order by count(city) desc

--check prod table - companies often reuse product ids
select productid, count(productname) from dimproduct
group by productid
order by count(productname) desc

-- change permission to run diagram 
alter authorization on database::superstore_manual to sa

--- do diagram of schema 

--- testing : some queries for data validation

-- COUNTS FOR THE POPULATED TABLES

-- dimCust
SELECT COUNT(*) FROM dimCust
SELECT DISTINCT Customer_ID, Customer_Name, Segment FROM SuperstoreStaging

-- dimProd
SELECT COUNT(*) FROM dimProd
SELECT DISTINCT Product_ID, Product_Name, Category, Sub_Category
FROM SuperstoreStaging

-- uniqueness / duplication
SELECT ProdID, COUNT(ProdName) FROM dimProd
GROUP BY ProdID
HAVING COUNT(Prodname) > 1

SELECT PostCode, COUNT(City) FROM dimGeog
GROUP BY PostCode
HAVING COUNT(City) > 1

-- FREQUENCY COUNTS
-- dimProd
SELECT DISTINCT Category, COUNT(DISTINCT Sub_Category) AS NbSub
FROM SuperstoreStaging
GROUP BY Category

SELECT DISTINCT ProdCategory, COUNT(DISTINCT ProdSubCategory) AS NbSub
FROM dimProd
GROUP BY ProdCategory

-- counts between SuperstoreStaging and FACTOrderItem
SELECT Category, COUNT(Category) AS NbCat FROM SuperstoreStaging
GROUP BY Category

SELECT p.ProdCategory, COUNT(p.ProdCategory) AS NbCat
FROM FACTOrderItem f INNER JOIN dimProd p 
		ON f.ProdKey = p.ProdKey
GROUP BY p.ProdCategory

-- RANGES
SELECT MIN(Profit), MAX(Profit) FROM SuperstoreStaging
SELECT MIN(Profit), MAX(Profit) FROM FACTOrderItem



--- aggregation queries 

create view productview as
select category, subcategory, productid from dimproduct

--- part 6 

drop view if exists bi_agg_sales_qtr
go 

create view bi_agg_sales_qtr as
select sum(f.sales) as salestotal, concat(d.[year],'-',d.[quarter]) as qtr, 
c.custid, c.custname, g.region, g.city, g.[state]
from factorderitem f
inner join dimdate d on f.orderdatekey =d.datekey
inner join dimcust c on f.custkey=c.custkey
inner join dimgeog g on f.geogkey =g.geogkey
group by  concat(d.[year],'-',d.[quarter]), c.custid, c.custname, g.region, g.city, g.[state]


drop view if exists bi_agg_products_wk
go 

create view bi_agg_products_wk as
select sum(f.qty) as total_sold_products, concat(d.[week],'-',d.[year]) as wk, p.category as prodcategory, 
c.segment as custsegment, g.region
from factorderitem f
inner join dimdate d on f.orderdatekey =d.datekey
inner join dimcust c on f.custkey=c.custkey
inner join dimgeog g on f.geogkey =g.geogkey
inner join dimproduct p on f.productkey = p.productkey
group by concat(d.[week],'-',d.[year]), p.category,c.segment, g.region


create or alter view bi_rev_reg_qtr as 
select sum(f.sales) as totsales, sum(f.profit) as totprofit , g.region, concat(d.[year],'-',d.[quarter]) as qtr
from factorderitem f
join dimdate d on f.orderdatekey =d.datekey
join dimgeog g on f.geogkey =g.geogkey
group by g.region, concat(d.[year],'-',d.[quarter])

create or alter view bi_units_cat_month as 
select sum(f.qty) as units, p.category, concat(d.[year],'-',d.[month]) as month
from factorderitem f
join dimdate d on f.orderdatekey =d.datekey
join dimproduct p on f.productkey = p.productkey
group by p.category, concat(d.[year],'-',d.[month])

create or alter view bi_profit_segment_month as
select sum(f.profit) as totprofit, c.segment, concat(d.[year],'-',d.[month]) as month
from factorderitem f
join dimdate d on f.orderdatekey =d.datekey
inner join dimcust c on f.custkey=c.custkey
group by c.segment, concat(d.[year],'-',d.[month])





