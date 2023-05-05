--Name: Sahibpreet Singh
--student id: 165338211
--email: sahibpreet-singh1@myseneca.ca

--Q1--
CREATE OR REPLACE PROCEDURE display_customer(n_customer_id IN number) AS
c_name CUSTOMERS.name%TYPE;
c_id CUSTOMERS.CUSTOMER_ID%TYPE;
c_address CUSTOMERS.ADDRESS%TYPE;
BEGIN
SELECT NAME, CUSTOMER_ID, ADDRESS
INTO   c_name,c_id,c_address
FROM customers WHERE customer_id = n_customer_id;
DBMS_OUTPUT.PUT_LINE('NAME : ' || c_name);
DBMS_OUTPUT.PUT_LINE('ID : ' || c_id);
DBMS_OUTPUT.PUT_LINE('ADRESS : ' || c_address);
EXCEPTION
  
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No Data Found!');
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('Too Many Rows Returned!');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error!');     
END;   
--CHECK--
BEGIN 
display_customer(&output);
end;


--Q2 Solution
select product_name,list_price
from products where list_price=(select max(list_price) from products);

--Q3 Solution
select * from products where product_name like 'C%';


--Q4 Solution
CREATE OR REPLACE PROCEDURE find_customer (
  c_id IN NUMBER,
  found OUT NUMBER
) AS
  c_count NUMBER;
BEGIN
  SELECT COUNT(customer_id) INTO c_count FROM customers WHERE customer_id = c_id;
    

  IF c_count = 1 THEN
    found := 1;
  ELSE
    found := 0;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    found := 0;
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Error: Multiple customers found with the same ID.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

--CHECK--
DECLARE
  isfound NUMBER;
BEGIN
  find_customer(&output, isfound);
  IF isfound = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Customer found!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Customer not found!');
  END IF;
END;

