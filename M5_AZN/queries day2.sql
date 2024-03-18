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