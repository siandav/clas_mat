# Bank Accounts and Loans 

## about the data 
Three csv files from a real Czech bank database, account, district and loan. It is quite old data but very rare to find actual financial data being shared widely. 

You have been provided with a schema showing the full set of tables in this data source but we are only working with three of the tables shown in the [bank data folder](https://github.com/siandav/clas_mat/blob/main/LBG_tableau/bank_data.zip)
+ account
+ district
+ loan

![image](https://github.com/siandav/clas_mat/assets/71644535/05242bcd-c0d3-40b9-a911-43f9dc9b0237)


## objective 

In this scenario it is important to understand the trend over time of loans being borrowed from the bank – particularly we want to communicate if that trend for the average value of loans taken is going up or down. Secondly, we will use a dashboard style report to provide an overview of all the active loans in the bank by status , per geographic area (region and district). It is useful to have some demographic information about the districts which can be used to tell a contextual story about the loans in that area - in the data, note that all loans are flagged with a status at the time the data snapshot was captured: 

A- loan completed, fully paid 
B- loan period has completed, loan was not repaid 
C- loan is running, no issues 
D- loan is in default, payments have been missed 

Also, note that the loan data (including loan amount, status, loan date) and the geographical information (district, region, demographic facts) cannot be joined directly together, so the third table, account, is needed. 

## step by step instructions 
1. in a new workbook, add the bank data tables (you will need two data connection types in Tableau) EITHER as local files or from your workign GCP connection to Big Query
2. relate or join the tables using the appropriate keys
3. create a new calculated column in the data source view, a derived loan start date, as **DATE(DATEPARSE("yyMMdd",str([Date])))**
4. in the loan table, amend the status aliases to match data description given at the start of this scenario
5. Create a new worksheet ‘loan dates’. Consider how a report view could be set up, with clear visual data storytelling, to highlight changes in the average loan amount taken out at each quarter and year, to see whether over time that total amount has been rising or falling. To build this time series line chart you will need loan amount on rows, aggregated to AVG(), and the derived loan start date on columns, from which you can select the date value **Quarter** to display the quarters in each year. If your chart only shows marks for Q1, Q2, Q3, Q4 then pay attention to the date type you have on columns
6. optionally, drag a linear trend to the line chart from the analytics pane
7. create a second worksheet, 'demographics' which indicates with clear visual data storytelling the urban ratio and average salary of the residents in each district the bank operates. To build this scatter plot you will need the average urban ratio column on one axis (eg columns) and average salary column on the other (eg rows), per district, with the size of the circle representing the number of inhabitants in each district and colour representing region name. add the district name to the label of the marks or tooltip. 
8. create a final worksheet 'loans by region'- the aim of this viz is to display the breakdown per region and district of loans by status. Ie, what proportion of the total loan value in the Trebic district are now in the red? This can be achieved with a stacked 100% bar chart with status on colour of the Marks Card.
9. compile your 3 vizzes into a dashboard called 'loan status review' using an appropriate layout
10. consider how this dashboard could be modified for engaging and interactive data storytelling with stakeholders on this topic, to highlight the proportion of the bank loans in each loan status and how this picture is linked to the demographics of the district and region of those account holders. Add filters and interactivity between charts in the dashboard that are engaging, not confusing to use.
11. add a text box to your dashboard, to share your own narrative appropriate to what the dashboard demonstrates, indicating anything you have observed in the data, such as trends, outliers, skewing and correlation (negative or positive), the proportion of x that relates to y, or any outstanding concerns you recommend the Bank investigate about their loans and account holders.
12. save your tableau workbook and get ready to share what youve done today via tableau public, screenshare or pdf. 
