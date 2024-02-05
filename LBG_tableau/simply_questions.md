# Lab A | Tableau Charts - Simply answering questions with charts

Build the following charts in a single tableau workbook, saving the workbook locally and pushing it to your github repo. Each question requires you to build a single tableau visualisation (chart or viz) (think : separate worksheet) which enables the end user to easily answer the given question in a visual way. 

Reminder : we are looking for individual views/charts for each task, not dashboards. 

## Challenge 1 

Using the data set [profitability.xlsx](profitability.xlsx) 
and Tableau Desktop or Tableau Public, create the following charts to visualise and answer the following questions: 

(Ensure each chart has the appropriate fit, mark type, title, axis labels and legend.) 

1) What company made the most **per second** in 2016? and which industry was that in? Which industry appears most often in the **top 5**? suggestion - use a horizontal bar plot but think about using colour deliberately
2) Is there any discernible relationship between the **Fortune 500 Rank** of a company and its **Net income** in 2016? suggestion -Use a scatter plot
3) In our data set, what does the breakdown (/composition) of the number of companies per industry look like? suggestion - Use a text table, packed bubble or treemap to display this sort of information- and give the tooltip some attention!

## Challenge 2

Using the data set [laureate.csv](laureate.csv) and Tableau Desktop  create the following charts to visualise and answer the following questions: 

(Ensure each chart has the appropriate fit, mark type, title, axis labels/legend or map layers.) 

1) Which country has produced the most nobel laureates up to 2016 (hint: **country of birth**)? suggestion -Use a map (note, some countries have changed names over this historical period)
2) Whats the % of male to female nobel laureates up to 2016? suggestion -Use a text table or pie chart to represent this 
3) For those laureates for whom we do know the **City** they lived in at the time of the award, what if any trend do you notice about the two cities of Cambridge to be found in the data. Which Cambridge produced most chemistry winners compared to medicine and physics?  suggestion : use a stacked bar chart and experiment with the sort order to discover this insight- or display the 3 bar charts separately next to eachother in one view and use the sort icon on the axis to explore the data further.
4) What are the 3 most popular mens names among nobel leaureates ? suggestion: use a text table, tree map, bar chart or highlight table

Bonus challenge: How many award **motivations** can we find in our data set that cite 'analysis' work? (create a calculated field, using the substring 'analy' with CONTAINS to look for either analysis or analyses, analyze) and use this field as a dimension on your chart. Suggestion -use a bar chart, and dont worry too much about the NULL values found in Motivation. 
  
 ## Challenge 3 
  
 Using the data set [500_YouTube_Games.xlsx](500_YouTube_Games.xlsx) and Tableau Desktop , create the following charts to visualise and answer the following questions: 
  
 1) is there a plausible linear relationship between the number of subscribers and the number of views for all 500 youtube game content creators? suggestion - scatter plot with trend line
 2) is there a plausible linear relationship between the number of subscribers and the rank of each youtube game content creator, or can you suggest a better representative trend line? suggestion - scatter plot with trend line
 3) are there any content creators who have a lower rating than you might expect, given their #views or #subscribers? suggestion - scatter plot circles, with rating on colour, use legend and labels to highlight outliers by rating colour
