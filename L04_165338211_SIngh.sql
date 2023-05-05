-- ***********************
-- Name: Sahibpreet Singh
-- ID: 165338211
-- Date: 09 Feb 2023
-- Purpose: Lab 4 DBS311
-- ***********************

-- Q2 SOLUTION --
select location_id,city from locations where location_id IN
(select Location_id from locations
minus select Location_id from warehouses) order by city;

-- Q3 SOLUTION
select pc.category_id,pc.category_name,
CoUNT(p.product_id) from
product_categories pc join
products p on pc.category_id=p.category_id
where pc.category_id in (5) group by pc.category_id,pc.category_name
union all 
select pc.category_id,pc.category_name,
CoUNT(p.product_id) from
product_categories pc join
products p on pc.category_id=p.category_id
where pc.category_id in (1) group by pc.category_id,pc.category_name
union all select pc.category_id,pc.category_name,
CoUNT(p.product_id) from
product_categories pc join
products p on pc.category_id=p.category_id
where pc.category_id in (2) group by pc.category_id,pc.category_name;

--Q4 SOLUTION
select product_id from products
intersect
select product_id from inventories where quantity> 5; 

--Q5 SOLUTION
select w.warehouse_name,l.state from warehouses w
left join locations l on w.location_id=l.location_id
union select w.warehouse_name,l.state from warehouses w
right join locations l on w.location_id=l.location_id;