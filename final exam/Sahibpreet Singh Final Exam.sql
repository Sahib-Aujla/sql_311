/*
Name : Sahibpreet Singh
student id: 165338211
email: sahibpreet-singh1@myseneca.ca
date: 20 April 2023
Final Exam
*/

--Q1 Solution
CREATE OR REPLACE PROCEDURE find_employee(n_employee_id IN number) AS
findNum NUMBER;
e_first_name Employees.first_name%TYPE;
e_last_name Employees.last_name%TYPE;
e_email Employees.email%TYPE;
e_phone Employees.phone%TYPE;
e_hire_date Employees.hire_date%TYPE;
e_job_title Employees.job_title%TYPE;
BEGIN
SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE, HIRE_DATE, JOB_TITLE
INTO   e_first_name, e_last_name, e_email, e_phone, e_hire_date, e_job_title
FROM employees WHERE employee_id = n_employee_id;
DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || e_first_name);
DBMS_OUTPUT.PUT_LINE('LAST_NAMENAME: ' || e_last_name);
DBMS_OUTPUT.PUT_LINE('EMAIL: ' || e_email);
DBMS_OUTPUT.PUT_LINE('PHONE: ' || e_phone);
DBMS_OUTPUT.PUT_LINE('HIRE_DATE: ' || e_hire_date);
DBMS_OUTPUT.PUT_LINE('JOB_TITLE: ' || e_job_title);
EXCEPTION
  
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Employee not found.');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error occurred');     
END;   

--check
BEGIN
find_employee(82);
END;



--Q2 SOLUTION
CREATE OR REPLACE PROCEDURE update_price_tents(u_category_id IN products.category_id%TYPE, u_amount IN products.list_price%TYPE) AS
cnt NUMBER;
BEGIN
SELECT COUNT(category_id) INTO cnt FROM products WHERE category_id = u_category_id;
IF (u_amount > 0 and cnt > 0) THEN
UPDATE products SET LIST_PRICE = LIST_PRICE + u_amount WHERE category_id = u_category_id;
DBMS_OUTPUT.PUT_LINE('Rows updated :' || SQL%ROWCOUNT);   
ELSE
DBMS_OUTPUT.PUT_LINE('Either there are no CATEGORY matching or the input price is lesser than zero');  
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('product not found.');   
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error occurred');     
END;

DECLARE
u_category_id number := 2;
u_amount number := 10;
BEGIN
update_price_tents(u_category_id , u_amount );
END;

rollback;


--Q3 Solution
CREATE OR REPLACE PROCEDURE update_low_prices AS
u_avg products.list_price%TYPE;
u_rate NUMBER;
BEGIN
SELECT avg(LIST_PRICE) into u_avg from products ;
IF u_avg >= 1000 THEN u_rate := 1.02;         
ELSE u_rate := 1.01;
END IF;
UPDATE products SET LIST_PRICE = LIST_PRICE * u_rate WHERE LIST_PRICE <= u_avg;
DBMS_OUTPUT.PUT_LINE(' Updated rows: ' || SQL%ROWCOUNT);  
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Product not found.');   
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error ocurred ');     
END;

BEGIN
update_low_prices();
END;

-- Q4 SOLUTION

CREATE OR REPLACE PROCEDURE price_report AS
avg_price NUMBER;
min_price NUMBER;
max_price NUMBER;
cheap_count NUMBER;
fair_count NUMBER;
exp_count NUMBER;
BEGIN
SELECT AVG(list_price), MAX(list_price), MIN(list_price) INTO avg_price, max_price, min_price
FROM products;
SELECT COUNT(list_price) INTO cheap_count
FROM products
WHERE list_price < (avg_price - min_price) / 2;
SELECT COUNT(list_price) INTO fair_count
FROM products
WHERE list_price >= (avg_price - min_price) / 2 AND list_price <= (max_price - avg_price) / 2;
SELECT COUNT(list_price) INTO exp_count
FROM products
WHERE list_price > (max_price - avg_price) / 2;
dbms_output.put_line('Cheap: ' || cheap_count);
dbms_output.put_line('Fair: ' || fair_count);
dbms_output.put_line('Expensive: ' || exp_count);
END;

BEGIN
price_report();
END;



--Q5 SOLUTION
CREATE PROCEDURE warehouse_report IS
v_warehouse_id warehouses.warehouse_id % TYPE;
v_warehouse_name warehouses.warehouse_name % TYPE;
v_city locations.city % TYPE;
v_state locations.state % TYPE;
BEGIN
FOR i IN 1..9 LOOP 
SELECT
      w.warehouse_id,
      w.warehouse_name,
      l.city,
      nvl(l.state, 'no state')
      INTO 
      v_warehouse_id,
      v_warehouse_name,
      v_city,
      v_state 
FROM warehouses w 
INNER JOIN locations l 
ON (w.location_id = l.location_id) 
WHERE w.warehouse_id = i;
DBMS_OUTPUT.PUT_LINE('Warehouse ID: ' || v_warehouse_id);
DBMS_OUTPUT.PUT_LINE('Warehouse name: ' || v_warehouse_name);
DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
DBMS_OUTPUT.PUT_LINE('-----------------');
END
LOOP;
EXCEPTION 
WHEN OTHERS 
THEN DBMS_OUTPUT.PUT_LINE('Error Occured');
END;
--check
BEGIN 
warehouse_report();
END;



