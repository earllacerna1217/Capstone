use northwind;
-- 1. Write a query to list the product id, product name, and unit price of every product that Northwind sells
select productID, productName, unitPrice 
from products;

-- 2. Write a query to identify the products where the unit price is $7.50 or less.
select productName, unitPrice from products
where unitprice > 7.50;

-- 3. What are the products that we carry where we have no units on hand, but 1 or more units are on backorder? Write a query that answers this question.
select productname, Unitsinstock, unitsonorder from products
where unitsinstock = 0 
and unitsonorder >= 1; 

-- 4. Examine the products table. How does it identify the type (category) of each item sold? Where can you find a list of all categories?
-- 4. Answer: The table categorize items that has been sold by listing the units in stock 0 which shows that all the stocks has been sold. 
select * from products; 

/*  Examine the products table again. How do you know what supplier each productcomes from? Where can you find info on suppliers?
 Write a set of queries to find the specific identifier for "Tokyo Traders" and then find all products from that supplier. 
*/ 
-- 5. Asnwer and quries that shows it:
select products.productname, products.productID, suppliers.supplierid, suppliers.companyname 
from products
left join suppliers
on products.supplierid = suppliers.supplierid; 

-- 6. How many employees work at northwind? What employees have "manager" somewhere in their job title? Write queries to answer each question.
select count(*) from employees; 
select firstname, lastname, title from employees
where title like "%manager%"; 