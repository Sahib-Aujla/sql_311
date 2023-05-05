--Name: Sahibpreet Singh
--ID: 165338211
--email: sahibpreeet-singh1@myseneca.ca
--purpose: LAB 1


--Q1
--Write a query to display the tomorrow’s date in the following format:
 --    January 10th of year 2019
--the result will depend on the day when you RUN/EXECUTE this query.  Label the column “Tomorrow”.
--Q1 SOLUTION
SELECT to_char(sysdate+1,'Month" "fmddTH" of year "yyyy') AS "Tomorrow" FROM dual;


--Q2
-- For each product in category 2, 3, and 5, show product ID, product name, list price, and the new list price increased by 2%. Display a new list price as a whole number.
-- In your result, add a calculated column to show the difference of old and new list prices.
--Q2 SOLUTION
select PRODUCT_ID,PRODUCT_NAME,LIST_PRICE
,TRUNC((LIST_PRICE+(LIST_PRICE*0.02)),0) as "NEW_LIST",
(LIST_PRICE+(LIST_PRICE*0.02))-LIST_PRICE as "DIFFERENCE"
from products where category_id in('2','3','5') order by product_id;



--Q3
-- For employees whose manager ID is 2, write a query that displays the employee’s Full Name and Job Title in the following format:
-- SUMMER, PAYNE is Public Accountant.
--Q3 SOLUTION
select upper(last_name)|| ', '|| upper(first_name) || ' is '|| JOB_TITLE from employees where MANAGER_ID=2;



--Q4
-- For each employee hired before October 2016, display the employee’s last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
-- •	Label the column Years worked. 
-- •	Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.
--Q4 SOlution
select * from (select last_name,hire_date,round((sysdate-hire_date)/365,1) as years_worked
from employees where hire_date< to_date('01,10,2016','DD-MM-YYYY'));



--Q5
-- Display each employee’s last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016.  
-- •	Label the column REVIEW DAY. 
-- •	Format the dates to appear in the format like:
--     TUESDAY, August the Thirty-First of year 2016
-- •	Sort by review date
--Q5 SOLUTION
select last_name,hire_date,to_char(next_day((hire_date+365),'Tuesday'),
'DAY","MONTH" the "dd" of year "yyyy')as "Review Day"
from employees where hire_date>=to_date('2016-01-01','yyyy-mm-dd') order  by "Review Day";


--Q6
--  For all warehouses, display warehouse id, warehouse name, city, and state. For warehouses with the null value for the state column, display “unknown”.
--Q6 SOLUTION
select w.warehouse_id,w.warehouse_name,l.city,CASE WHEN l.state IS NULL then 'Unknown' else l.state end as "STATE"
From warehouses w inner join locations l on w.warehouse_id=l.location_id;