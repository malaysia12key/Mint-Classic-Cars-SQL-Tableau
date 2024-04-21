Data Analysis/Visiualizations using SQL and Tableau

Project Scenario: 
Mint Classic Cars currently has 4 storage warehouses and is looking to close one of them. They need suggestions and recommendations on how to reorganize and/or reduce inventory and still maintain timely service.


Skills Demonstrated:
SQL
Data manipulation
Data analysis
Database management
Aggregate functions
Joins
Ranking
Tableau/Visualizations 


Summary: 
Mint Classic Cars is a retailer for miniature replica classic cars, vintage cars, ships, trains, motorcycles, planes, buses, trucks and trains. They have 4 warehouses (East, West, South and North) where they store inventory. The main goal of this project is to give insights into which warehouse they should close. Another problem to be solved is whether they should relocate inventory or stop selling certain product lines altogether. 


Approach: 
I was given a database with 9 tables with information ranging from product lines, inventory count, warehouse information, customer orders, company revenue, customer information, office location and employees. The information was sourced from Jan 2003-May 2005. I used MySQL Workbench to sort and mine data to see where I could draw the best insights. This involved data cleaning: checking for duplicates and missing data. The main tables I would be using were products, warehouses, order details. I used other tables to understand the customer market segment and the types of product that were sold (ie. miniature replicas, not actual vehicles). I wrote queries that delt with COUNT, SUM, RANK, JOINS, GROUP BY, ORDER BY and VIEWS. After creating views, I uploaded the CSV files into Excel, converted them to XLSX files and reformatted the data to the correct data type. The clean data was then uploaded to Tableau and I began creating visualizations to highlight insights, ending with a dashboard that summarized the data.


Solution:
The South warehouse is at 75% capacity and it stores 2/3 of the least productive item lines by revenue and orders (Ships and Trains). Mint Classic should close the South warehouse and move the stored items to either the North (72% capacity) or West (50% capacity). 
Trains have the least orders quarter over quarter and bring in the least revenue $188,532. They are also the least stock count. If Mint were to drop a product line, Trains should be it. 




