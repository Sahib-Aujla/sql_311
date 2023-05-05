-- *********
-- Group-7
-- Name: Sahibpreet Singh
-- ID: 165338211
-- Name: Lorenzo Alvin Tubo 
-- ID: 109934224
-- Name: Fausto Javier Zaruma
-- ID: 119758217
-- Date: 2023-02-23
-- Purpose: Assignment 1
-- *********

--Question-1--
--Displaying the employee number, full employee name, job title, and hire date of all employees hired in September with the most recently hired employees displayed first. 

SELECT employee_id AS "Employee Number",
(last_name||', ' || first_name) AS "Full Name",
job_title AS "Job Title",
to_char(hire_date, '[fmMonth ddth "of" yyyy]') AS "Start Date"
FROM employees
WHERE extract(MONTH FROM hire_date) IN (9)
ORDER BY hire_date DESC;

--Question-2--
--The company wants to see the total sale amount per sales person(salesman) for all
-- orders. Assume that online orders do not have any sales representative.For onlineorders (orders with no salesman ID),
-- consider the salesman ID as 0. Displaying the salesman ID and the total saleamount for each employee.Sorting the result
-- according to employee number.

SELECT
nvl(a.salesman_id, 0)AS "employee number",
SUM(b.unit_price*b.quantity) AS totalprice
FROM
 orders a,
 order_items b
WHERE
 a.order_id = b.order_id
GROUP BY
 a.salesman_id,
 nvl(a.salesman_id, 0)
ORDER BY
 nvl(a.salesman_id, 0);
 
--Question-3--
--Displaying customer Id, customer name and total number of orders for customers that the value of their customer ID is in values from 35 to 45.
--Includeing the customers with no orders in your report if their customer ID falls in the range 35 and 45.  
--Sorting the result by the value of total orders. 

SELECT
 c.customer_id,
 c.name AS "customer name",
 COUNT(o.order_id) AS "total number OF orders"
FROM
 customers c
 LEFT JOIN
 orders o
 ON c.customer_id = o.customer_id
WHERE
 c.customer_id BETWEEN 35 AND 45
GROUP BY
c.customer_id,
 c.name
ORDER BY
 COUNT(o.order_id);

--Question-4--
-- Displaying customer ID, customer name, and the order ID and the order date of
-- all orders for customer whose ID is 44.

SELECT
 c.customer_id,
 name,
 o.order_id,
 order_date,
 SUM(quantity) AS total_items,
 SUM(quantity * unit_price) AS total_amount
FROM
 customers c
 JOIN
 orders o
 ON c.customer_id = o.customer_id
 JOIN
 order_items oi
 ON o.order_id = oi.order_id
WHERE
 c.customer_id = 44
GROUP BY
 c.customer_id,
 name,
 o.order_id,
 order_date
ORDER BY
 SUM(quantity * unit_price) DESC;
 
--Question-5--
--Displaying customer Id, name, total number of orders, the total number of items ordered, and the total order amount for customers who have more than 30 orders. 
--Sorting the result based on the total number of orders.

SELECT
 c.customer_id,
 c.name,
 COUNT(o.order_id) AS "total number OF orders",
 SUM(oi.quantity) AS "total items",
 SUM(oi.quantity * oi.unit_price) AS "total amount"
FROM
 orders o,
 customers c,
 order_items oi
WHERE
 c.customer_id = o.customer_id
 AND o.order_id = oi.order_id
GROUP BY
 c.customer_id,
 c.name
HAVING
 COUNT(o.order_id) > 30
ORDER BY
 COUNT(o.order_id) ASC;
 
--Question-6--
--Displaying Warehouse Id, warehouse name, product category Id, product category name, and the lowest product standard cost for this combination.
--In our result, we have include the rows that the lowest standard cost is less then $200.
--We also, included the rows that the lowest cost is more than $500.
--Sorting the output according to Warehouse Id, warehouse name and then product category Id, and product category name.

SELECT
 w.warehouse_id,
 warehouse_name,
 p.category_id,
 category_name,
 MIN(standard_cost) AS lowest_cost
FROM
 inventories i
 JOIN
 warehouses w
 ON i.warehouse_id = w.warehouse_id
 JOIN
 products p
 ON i.product_id = p.product_id
 JOIN
 product_categories pc
 ON p.category_id = pc.category_id
GROUP BY
 w.warehouse_id,
 warehouse_name,
 p.category_id,
 category_name
HAVING
 MIN(standard_cost) < 200
 OR MIN(standard_cost) > 500
ORDER BY
 w.warehouse_id,
 warehouse_name,
 p.category_id,
 category_name;

--Question-7--
--Displaying the total number of orders per month. Sort the result from January to December.

SELECT
 to_char(to_date(the_month, 'MM'), 'Month') AS "MONTH",
 counts AS "number OF orders"
FROM
 (
 SELECT
 EXTRACT(MONTH
 FROM
 order_date) AS the_month,
 COUNT(*) AS counts
 FROM
 orders
 GROUP BY
 EXTRACT(MONTH
 FROM
 order_date)
 )
 sales
ORDER BY
 the_month;
 
--Question-8--
--Displaying product Id, product name for products that their list price is more than any highest product standard cost per warehouse outside Americas regions.
--Sorting the result according to list price from highest value to the lowest.

SELECT
 product_id AS "product id",
 product_name AS "product name",
 to_char(list_price, '$999,999.99') AS "price"
FROM
 products
WHERE
 list_price > ANY (
 SELECT
 MAX(standard_cost)
 FROM
 locations l
 JOIN
 countries c
 ON l.country_id = c.country_id
 JOIN
 regions r
 ON r.region_id = c.region_id
 JOIN
 warehouses w
 ON w.location_id = l.location_id
 JOIN
 inventories i
 ON i.warehouse_id = w.warehouse_id
 JOIN
 products p
 ON p.product_id = i.product_id
 WHERE
 region_name NOT LIKE 'Americas'
 GROUP BY
 w.warehouse_id)
 ORDER BY
 list_price DESC;
 
--Question-9--
--We wrote a SQL statement to display the most expensive and the cheapest product (list price). Display product ID, product name, and the list price.

SELECT
 product_id,
 product_name,
 list_price
FROM
 products
WHERE
 list_price =
 (
 SELECT
 MAX(list_price)
 FROM
 products
 )
 OR list_price =
 (
 SELECT
 MIN(list_price)
 FROM
 products
 )
;

--Question-10--
-- We wrote a SQL query to display the number of customers with total order amount over the average amount of all orders,
--the number of customers with total order amount under the average amount of all orders, number of customers with no orders, and the total number of customers.
SELECT
 'Number of customers with total purchase amount over average: ' || COUNT(*)
AS "customer report"
FROM
 (
 SELECT
 c.customer_id,
 SUM(oi.quantity*oi.unit_price) AS total_amount
 FROM
 customers c
 INNER JOIN
 orders o
 ON c.customer_id = o.customer_id
 INNER JOIN
 order_items oi
 ON oi.order_id = o.order_id
 GROUP BY
 c.customer_id
 )
WHERE
 total_amount > (
 SELECT
 AVG(quantity*unit_price)
 FROM
 order_items)
 UNION ALL
 SELECT
 'Number of customers with total purchase amount below average: ' ||
COUNT(*)
 FROM
 (
 SELECT
 c.customer_id,
 SUM(oi.quantity*oi.unit_price) AS total_amount
 FROM
 customers c
 INNER JOIN
 orders o
 ON c.customer_id = o.customer_id
 INNER JOIN
 order_items oi
 ON oi.order_id = o.order_id
 GROUP BY
 c.customer_id
 )
 WHERE
 total_amount < (
 SELECT
 AVG(quantity*unit_price)
 FROM
 order_items)
 UNION ALL
 SELECT
 'Number of customers with no orders: ' || COUNT(*)
 FROM
(
 SELECT
 customer_id
 FROM
 customers minus
 SELECT
 customer_id
 FROM
 orders
 )
 UNION ALL
 SELECT
 'Total number of customers: ' || COUNT(*)
 FROM
 (
 SELECT
 customer_id
 FROM
 customers
 UNION
 SELECT
 customer_id
 FROM
 orders
 )
;