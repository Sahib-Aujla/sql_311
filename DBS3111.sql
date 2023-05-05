-- ***********************
-- Name: Sahibpreet Singh
-- ID: 165338211
-- Date: 26 Jan 2023
-- Purpose: Lab 2 DBS311
-- ***********************




-- Q1 
 SELECT JOB_TITLE, COUNT(EMPLOYEE_ID)
 FROM EMPLOYEES
 GROUP BY JOB_TITLE
 ORDER BY COUNT(EMPLOYEE_ID);
 
 -- Q2
 SELECT MAX(CREDIT_LIMIT) AS "HIGH", MIN(CREDIT_LIMIT) AS "LOW", 
 ROUND(AVG(CREDIT_LIMIT),2) AS "AVERAGE", 
 MAX(CREDIT_LIMIT) - MIN(CREDIT_LIMIT) AS "HIGH AND LOW DIFFERENCE"
 FROM CUSTOMERS;
 
 -- Q3 
 SELECT ORDER_ID, SUM(QUANTITY),SUM(QUANTITY * UNIT_PRICE)
 FROM ORDER_ITEMS
 GROUP BY ORDER_ID
 HAVING SUM(QUANTITY * UNIT_PRICE) > 1000000
 ORDER BY SUM(QUANTITY * UNIT_PRICE) DESC;
 
 --Q4 
 SELECT W.WAREHOUSE_ID, W.WAREHOUSE_NAME, SUM(I.QUANTITY) AS TOTAL_PRODUCTS FROM WAREHOUSES W
 INNER JOIN INVENTORIES I
 ON W.WAREHOUSE_ID = I.WAREHOUSE_ID
 GROUP BY W.WAREHOUSE_ID, W.WAREHOUSE_NAME
 ORDER BY W.WAREHOUSE_ID;
 
 --Q5
 select c.customer_id as "customer_number",c.name as "fullname",count(o.order_id)
 from customers c
 left join orders o
 on c.customer_id=o.customer_id
 where c.name like '%t'
 group by c.customer_id,c.name
 order by count(o.order_id)desc;
 
 --Q6 SOLUTION
select p.category_id,sum(o.quantity*o.unit_price) as "TOTAL_AMMOUNT",
Round(avg(o.quantity*o.unit_price),2) as "Average amount"
from products p
join order_items o
on p.product_id=o.product_id
group by p.category_id;

