-- ***********************
-- Name: Sahibpreet Singh
-- ID: 165338211
-- Date: 2 feb 2023
-- Purpose: Lab 3 DBS311
-- ***********************

-- Q1 SOLUTION --
select last_name as "last name", to_char(hire_date,'fmdd-MON-yy') as "hire date"
from employees 
where hire_date <
(select hire_date
from employees
where employee_id=107)
and hire_date>to_date('30-03-2016','dd-mm-yyyy')
order by  hire_date,employee_id;


--Q2 SOLUTION
select name as "customer name", credit_limit as "credit limit"
from customers
where credit_limit=
(select min(credit_limit)
from customers
)
order by customer_id;


--Q3 SOLUTION
select product_id,product_name,(list_price),category_id
from products
where category_id=any
(select category_id from products )
and list_price=any
(select max(list_price) from products
group by category_id)
order by category_id,product_id;

--Q4 SOLUTION
select pc.category_id,pc.category_name
from product_categories pc
left join products p
on pc.category_id=p.category_id
where list_price=
(select max(list_price) from products);

--Q5 SOLUTION
select product_name,list_price
from products
where category_id=1 and
list_price< any(select min(list_price) from 
products group by category_id)
order by list_price desc,product_id;

--Q6 SOLUTION   
SELECT product_id, product_name, category_id
FROM products
WHERE category_id = any(SELECT category_id
FROM products group by category_id)
and
list_price=any(SELECT MIN(list_price)
FROM products group by category_id)
order by product_id;
