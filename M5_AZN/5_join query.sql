/****** Script for SelectTopNRows command from SSMS  ******/
SELECT o.quantity,o.sales,o.profit,c.segment,
s.shipmode, g.state, g.city, p.category, p.sub_category
FROM [superstore].[dbo].[fact_orderitem] AS o
INNER JOIN [superstore].[dbo].[dim_cust] AS c
ON o.cust_key=c.cust_key
INNER JOIN [superstore].[dbo].[dim_date] AS d
ON o.orderdate_key=d.date_key
INNER JOIN [superstore].[dbo].[dim_geog] AS g
ON o.geog_key=g.geog_key
INNER JOIN [superstore].[dbo].[dim_prod] AS p
ON o.prod_key=p.prod_key
INNER JOIN [superstore].[dbo].[dim_shipmode] AS s
ON o.shipmode_key=s.shipmode_key;