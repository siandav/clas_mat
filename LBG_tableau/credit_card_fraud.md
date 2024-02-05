## Credit Card Fraud Transactions 

### About the data 

A single csv file card_transdata_sample_10pcnt contains 100k anonymised credit card transaction data records. 
Each record contains attributes of the transactions including how it compares to the median transaction value on that account, how far from home or the last transaction this one is, whether it is online, a repeat retailer and if a pin or chip was used. The transactions are flagged as to whether it was identified as fraudulent. 
For data storytelling purposes you should consider that although most transactions are not fraudulent, those which are fraudulent, and any behaviours which correlate with fraudulent transactions, pose a high risk to the business. Your challenge will be to communicate to stakeholders by highlighting the proportion of transactions which are fraudulent. 
At the same time, you will want to identify any standout trends or patterns observed in the data. 

### Step by Step instructions 

1. create a new tableau workbook, add the new data source, text file type, browsing to where you have saved the data *card_transdata_sample_10pct.csv*
2. in the Data Source Page, you could optionally rename the Boolean columns as questions using reasonable language (e.g., “Did they use the Pin?” , “Fraudulent flag”)
3. in a new worksheet, modify the assigned role of the columns by assigning all boolean fields to blue Dimensions instead of green Measures. You can do this with a right click on the data fields in the data table panel on the left or by dragging each column into the Dimensions area.
4. add an informative title to your worksheet : "Proportion of Online Transactions that are found to be Fraudulent"
5. drag the count of rows to the columns shelf and online order discrete column to the rows shelf. Add your fraudulent flag to the colour tab on the Marks card to complete this viz
6. assign colours that are intuitive - fraudulent transactions might be red, for example
7. take a duplicate of this viz, and change it so that the rows are for new or repeat retailers. Update the title of the viz but you can keep everything else the same
8. add a third new worksheet, which plots Distance from Home and Distance from Last Transaction on a scatter chart (opposite axes) with both measures set to Median aggregation. Fraudulent flag should again be on the Colour tab of the Marks card.
9. arrange the 3 worksheets onto a New Dashboard, placing the sheets together per a logical layout of your choice
10. save your workbook 



#### Now, you will work to improve the dashboard visually for better data storytelling, to filter out the noise and highlight the proportion of fraudulent transactions of each type, enabling the audience to see subtle patterns revealed in the data.
From inside the dashboard view of Tableau:
+ select the online frauds bar chart and go into the worksheet using the go to sheet navigation button. From the worksheet view you can change the bar chart to a stacked 100% bar chart by adding a quick table calculation to the measure CNT(card_transaction…) on the Columns shelf. Select the green measure pill and from the menu, add quick table calculation > Percent of Total. The default scope of the table calculation will be Table down, so the next step is to change the scope to Table Across from the Compute Using > Table Across option in the same drop-down menu. Alternatively, you can choose to add a table calculation to the green measure pill and configure the table calculation scope and direction from the menu
+ now the bar chart will be stacked 100% across the page. To show the labels either drag a copy of the measure from the Columns shelf to the Label on the Marks Card or, from the toolbar, select the T symbol to Show Mark Labels
+ From the green pill on the Columns shelf, using the menu, untick Show Header to hide the % axis, as this is no longer visually useful.
+ if you havent already, edit the alisases of the Fraud field to show 1 as Fraudulent, 0 as Normal transactions
+ similarly you can change the labels of the Online Order and Repeat Retailer fields in the data pane as Online/Offline, Repeat/ New- by right clicking on the fields in the data pane and choosing Aliases.
+ Return to the dashboard, select the retailer view in the same manner as before and, following the same steps, convert this view to a stacked 100% bar chart.
+ Return to the card transactions dashboard, go to the scatter plot view about distances. On this view, add the field Online Order to Shape on the Marks Card – this adds more detail and a different shape for online/offline. 
+ Returning to the dashboard, choose Show dashboard title from the dashboard menu, editing the title to be “Fraudulent Credit Card Transactions Review” with font size 18, bold, centre aligned and underlined.
+ Double click to edit the individual visualisations titles to questions in font size 12, allowing you to then hide the field label for rows on the bar charts eg "Proportion of online transactions that were fraudulent" , "Proportion of new retailer transactions that were fraudulent", "Compared to normal : where did the transaction occur and how much was it?"
+ Select the bar chart title and change the colour of the word frauds to a similar shade to the colour assigned to the fraud label, format it as bold. After this you can hide the legend from the dashboard.
+ Change the axis titles on both x and y axis of the scatter plot for more clarity around what is shown, using the Edit Axis option on the menu (available when you right click on the axis label) as, for example : 'distance from cardholders home', 'difference from regular transaction value'
+ modify all tooltips to display meaningful sentences
+ save your changes in the workbook 
