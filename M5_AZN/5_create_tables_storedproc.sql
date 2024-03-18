CREATE DATABASE [superstore]
GO

USE [superstore]
GO

-- table definition

CREATE TABLE [dbo].[dim_cust](
	[customerid] [nvarchar](50) NOT NULL,
	[customername] [nvarchar](50) NOT NULL,
	[segment] [nvarchar](50) NOT NULL,
	[cust_key] [smallint] NOT NULL,
 CONSTRAINT [PK_dim_cust] PRIMARY KEY CLUSTERED 
(
	[cust_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[dim_geog](
	[country] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NOT NULL,
	[postalcode] [int] NOT NULL,
	[region] [nvarchar](50) NOT NULL,
	[geog_key] [smallint] NOT NULL,
 CONSTRAINT [PK_dim_geog] PRIMARY KEY CLUSTERED 
(
	[geog_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[dim_prod](
	[productid] [nvarchar](50) NOT NULL,
	[category] [nvarchar](50) NOT NULL,
	[sub_category] [nvarchar](50) NOT NULL,
	[productname] [nvarchar](150) NOT NULL,
	[prod_key] [smallint] NOT NULL,
 CONSTRAINT [PK_dim_prod] PRIMARY KEY CLUSTERED 
(
	[prod_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[dim_shipmode](
	[shipmode] [nvarchar](50) NOT NULL,
	[shipmode_key] [tinyint] NOT NULL,
 CONSTRAINT [PK_dim_shipmode] PRIMARY KEY CLUSTERED 
(
	[shipmode_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[fact_orderitem](
	[cust_key] [smallint] NOT NULL,
	[prod_key] [smallint] NOT NULL,
	[shipmode_key] [tinyint] NOT NULL,
	[orderdate_key] [date] NOT NULL,
	[geog_key] [smallint] NOT NULL,
	[rowid] [smallint] NOT NULL,
	[orderid] [nvarchar](50) NOT NULL,
	[orderdate] [date] NOT NULL,
	[shipdate] [date] NOT NULL,
	[sales] [float] NOT NULL,
	[quantity] [tinyint] NOT NULL,
	[discount] [float] NOT NULL,
	[profit] [float] NOT NULL,
 CONSTRAINT [PK_fact_orderitem] PRIMARY KEY CLUSTERED 
(
	[rowid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[dim_date](
	[date_key] [date] NOT NULL,
	[date] [date] NOT NULL,
	[day] [tinyint] NOT NULL,
	[month] [tinyint] NOT NULL,
	[week] [tinyint] NOT NULL,
	[quarter] [tinyint] NOT NULL,
	[year] [smallint] NOT NULL,
 CONSTRAINT [PK_dim_date] PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


---- stored procedure 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateDimDate] 
@start datetime = '2014-01-01',
@end datetime = '2018-12-30' 
As
BEGIN
	-- declare variables to hold the start and end date
	DECLARE @StartDate datetime
	DECLARE @EndDate datetime

	--- assign values to the start date and end date we 
	-- want our reports to cover (this should also take
	-- into account any future reporting needs)
	SET @StartDate = @start
	SET @EndDate = @end

    -- using a while loop increment from the start date 
	-- to the end date
	DECLARE @LoopDate datetime
	SET @LoopDate = @StartDate

	WHILE @LoopDate <= @EndDate
	BEGIN
	 -- add a record into the date dimension table for this date
	INSERT INTO DimDate VALUES (
     @LoopDate,
     DATEPART(Day,@LoopDate), 
     DATEPART(Week,@LoopDate),
     DATEPART(Month,@LoopDate), 
     DATEPART(quarter,@LoopDate),
     DATEPART(Year,@LoopDate),
     CURRENT_TIMESTAMP,
     CURRENT_TIMESTAMP
     )  
 
	 -- increment the LoopDate by 1 day before
	 -- we start the loop again
	 SET @LoopDate = DateAdd(d, 1, @LoopDate)
	END
END
GO



