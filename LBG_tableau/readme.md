## Tableau Introduction + Working with Tableau + GCP

These are hands-on activities for working with financial and other data sets in Tableau. Tableau is a data visualisation ecosystem of multiple products: 

+ Tableau Public is available for free to use with non-confidential data to create vizzes and publish them. 

+ Tableau Desktop is the licensed version of the same software with more flexible end user functionality and is used for secure data.
  
+ Tableau desktop allows for the possible connection to GCP data sources including big query, if authentication and network has been configured


### Process

The end to end process you will follow in either case of using local files or GCP sources is: 
1. Connect to the data sources (local files or cloud) 
2. Customise the data source layer – relate tables, apply filters, create new
calculated columns, or extract information from existing fields
3. Configure tableau worksheets, or vizzes (one visual or table per worksheet) with filters 
4. Combine vizzes in dashboards
5. Add additional interactivity (dashboard actions)
6. Optionally, combine dashboards and worksheets into stories
7. Publish worksheets and dashboards, or stories


### Getting started 

First you will need to register the product as a trial or with the credentials provided by Lucy. Logging into Tableau requries MFA setup. 
If you experience any problems with logging in to your Tableau desktop you should contact Lucy at *lbgprogrammes@qa.com* and proceed to use the trial version

### Objective 

You will get comfortable creating Tableau workbooks in Tableau Desktop on your LOD, connecting to raw data sources and you will learn the basics of the data source layer, before seeing how to use the visual front end in Tableau to design charts and compile simple interactive dashboards.
Effective storytelling requires narrative, accompanying the visualisations, so we will also explore the ways Tableau allows us to add our own insights and narrative to the charts and dashboards, tuned to our audience.

## Demonstration A

instructor will use a [demonstration workbook](https://public.tableau.com/app/profile/sianedavies/viz/demo_NWind/Freight-productsdatesanddestinations) to demonstrate the following main features. You can download this workbook from tableau public and open it with Tableau desktop if you like!

+ connecting to data source file
+ show me menu
+ create a visual using Rows and columns
+ fit window controls
+ sorting
+ Marks card – colour, type, label, tooltip
+ Filtering
+ de-aggregation
+ string calculations
+ Dealing with nulls
+ analytics pane - trend lines

### Hands-on practice Lab A

over to you to work through the first practice lab - [simply answering questions with Tableau](https://github.com/siandav/clas_mat/blob/main/LBG_tableau/simply_questions.md)

if you get stuck - theres a suggested solutions workbook available on [tableau public](https://public.tableau.com/app/profile/sianedavies/viz/solutions-simplyansweringquestionswithcharts/frontpage) 


## Demonstration B 

Instructor will continue to use the [demonstration workbook](https://public.tableau.com/app/profile/sianedavies/viz/demo_NWind/Freight-productsdatesanddestinations)  which you can download and follow along with. The raw data for these Tableau vizzes is a single excel workbook [BI_NWind_All.xlsx](BI_NWind_All.xlsx) 

+ data source preparation including hierachies, grouping and saving 
+ reporting roles (dimensions v measures, discrete v continuous)
+ aggregation types
+ boolean calculations and aliases
+ table calculations 
+ value and axes formatting
+ assembling a simple dashboard
+ visual data storytelling tips 

### Hands-on practice Lab B

over to you to work through the second practice lab - [credit card fraud](https://github.com/siandav/clas_mat/blob/main/LBG_tableau/credit_card_fraud.md)

if you get stuck and need inspiration of what the end result can look like, theres an image on the repo of the [final review dashboard](https://github.com/siandav/clas_mat/blob/main/LBG_tableau/fraud%20dashboard.png)



## Demonstration C 

Instructor will continue to use the [demonstration workbook](https://public.tableau.com/app/profile/sianedavies/viz/demo_NWind/Freight-productsdatesanddestinations) and the NWind excel workbook [BI_NWind_All.xlsx](BI_NWind_All.xlsx), but this time will bring in the GCP hosted element. We will consider how to work with a multi table bank data source in GCP, and a large data set from Kaggle about [credit card applications](https://www.kaggle.com/datasets/rikdifos/credit-card-approval-prediction) before using both as remote sources for Tableau vizzes. 

+ connecting to a data source with multiple tables
+ relating and joining tables in Tableau
+ parsing dates using calculated fields
+ working with dates in tableau (parts and values)
+ dashboard interactivity via actions and filters 
+ connecting to non file data sources incl GCP/ Big Query
+ implications of Tableau & Big Query


### Hands-on practice Lab C

over to you to work through the third practice lab - [bank accounts and loans](https://github.com/siandav/clas_mat/blob/main/LBG_tableau/credit_card_fraud.md)

if you get stuck and need inspiration of what the end result can look like, theres an image on the repo of the [loan status dashboard](https://github.com/siandav/clas_mat/blob/main/LBG_tableau/fraud%20dashboard.png)

