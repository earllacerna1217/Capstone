-- Exercise 3.A Aggregate Functions and Grouping

-- 1. Write a query to find the price of the cheapest item that Northwind sells. Then write a second query to find the name of the product that has that price.
use northwind; 
select MIN(unitprice) from products;
select productname, MIN(unitprice) from products;


/* 2. Write a query to find the average price of all items that Northwind sells.
(Bonus: Once you have written a working query, try asking Claude or ChatGPT for help
using the ROUND function to round the average price to the nearest cent. */ 

select avg(unitprice) as average_price from products
group by productname; 

select round(avg(unitprice), 2) as average_price
from products; 

/* 3. What are the products that we carry where we have at least 100 units on hand? Order
them in descending order by price. If two or more have the same price, list those in
ascending order by product name. */ 

select productname, unitsinstock, unitprice from products
where unitsinstock > '100'
order by unitprice desc,
productname asc; 

-- 4. Write a query to find total monthly payroll (the sum of all the employees’ monthly salaries).
select sum(salary) from employees; 

-- 5. Write a query to identify the highest salary and the lowest salary amounts which any employee makes. (Just the amounts, not the specific employees!)
select max(salary), min(salary) from employees; 

-- 6. Write a query to find the name and supplier ID of each supplier and the number of items they supply. Hint: Join is your friend here.
select s.supplierID,
s.companyname,
 count(p.productId) numbe_of_items from suppliers as s 
left join products as p
on s.supplierID = p.supplierID
group by s.supplierId, s.companyname; 

-- 7. Write a query to find the list of all category names and the average price for items in each category. 
select c.categoryID, c.categoryname, avg(p.unitprice) average_category_price from categories as c
left join products as p
on c.categoryID = p.productID
group by c.categoryID, c.categoryname;

-- 8. Write a query to find, for all suppliers that provide at least 5 items to Northwind, what is the name of each supplier and the number of items they supply.
select s.supplierID,
s.companyname,
 count(p.productId) numbe_of_items from suppliers as s 
left join products as p
on s.supplierID = p.supplierID
group by s.supplierId, s.companyname
having count(p.productID) >= '5';

/* 9. Write a query to list products currently in inventory by the product id, product name,
and inventory value (calculated by multiplying unit price by the number of units on
hand). Sort the results in descending order by value. If two or more have the same
value, order by product name. If a product is not in stock, leave it off the list.
*/ 

select productID, productName, unitsinstock, unitprice,
unitprice * unitprice as TotalPrice
from products; 
