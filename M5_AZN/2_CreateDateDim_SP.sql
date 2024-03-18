CREATE PROCEDURE CreateDimDate 
@start datetime = '2014-01-03',
@end datetime = '2017-12-30' 
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
	INSERT INTO DimDate VALUES (     @LoopDate,     DATEPART(Day,@LoopDate),      DATEPART(Week,@LoopDate),     DATEPART(Month,@LoopDate),      DATEPART(quarter,@LoopDate),     DATEPART(Year,@LoopDate),     CURRENT_TIMESTAMP,     CURRENT_TIMESTAMP     )  
 
	 -- increment the LoopDate by 1 day before
	 -- we start the loop again
	 SET @LoopDate = DateAdd(d, 1, @LoopDate)
	END
END