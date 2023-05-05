-- ***********************
-- Name: Aditya Bhardwaj
-- ID: 166959213
-- Date: 16-03-2023
-- Purpose: Lab 6 DBS311
-- ***********************
 
-- Q1 SOLUTION 
CREATE OR REPLACE PROCEDURE CalculateFactorial(n IN NUMBER)
IS
  factorial NUMBER := 1;
BEGIN
  FOR i IN 1..n LOOP
    factorial := factorial * i;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE(n || '! = ' || factorial);
END;

--check
Begin
CalculateFactorial(&output);
End;

--Q2 Solution
CREATE OR REPLACE PROCEDURE calculate_salary(v_employee_id employees.employee_id%type) 
IS 
  v_salary    NUMBER := 10000; 
  v_year_worked NUMBER; 
  v_first_name employees.first_name%type; 
  v_last_name  employees.last_name%type; 
  i         INT := 0; 
BEGIN 
   SELECT
      first_name,
      last_name,
     TRUNC(TO_CHAR(SYSDATE - employees.hire_date) / 365) 
     INTO v_first_name,
      v_last_name,
      v_year_worked
   
    FROM   employees 
    WHERE  employees.employee_id = calculate_salary.v_employee_id; 

LOOP 
v_salary := v_salary * 1.05; 
i := i + 1; 
EXIT WHEN i = v_year_worked; 
END LOOP; 
 DBMS_OUTPUT.PUT_LINE('First Name: ' ||v_first_name); 
 DBMS_OUTPUT.PUT_LINE('Last Name: ' ||v_last_name); 
 DBMS_OUTPUT.PUT_LINE('Salary: $' ||v_salary); 
EXCEPTION 
  WHEN no_data_found 
  THEN DBMS_OUTPUT.PUT_LINE('Employee does not exist'); 
  WHEN
   others 
THEN
   DBMS_OUTPUT.PUT_LINE('Error!! Occured');
END;
--check
BEGIN 
calculate_salary(13); 
END;


--Q3 Solution
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