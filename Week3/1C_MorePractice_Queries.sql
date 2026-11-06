-- Exercise 1C More practice with queries. 
use northwind; 

-- 1. Write a query to list the product id, product name, and unit price of every product. This time, display them in ascending order by price.
select productid, productname, unitprice from products
order by unitprice asc;

-- 2. What are the products that we carry where we have at least 100 units on hand? Order them in descending order by price
select productname, unitsinstock from products
where unitsinstock >= 100;

/* 3. What are the products that we carry where we have at least 100 units on hand? 
Order them in descending order by price. If two or more have the same price, list those in
ascending order by product name. */

select productname, unitprice, unitsinstock from products
 where unitsinstock >= 100
 order by unitprice desc, productname asc; 
 
 /* 4. Write a query against the orders table that displays the total number of distinct
customers who have placed orders, based on customer ID. Use an alias to label the
count calculation as CustomerCount. */

SELECT COUNT(DISTINCT customerID) AS CustomerCount
FROM customers;

/* 5. Write a query against the orders table that displays the total number of distinct
customers who have placed orders, by customer ID, for each country where orders
have been shipped. Again, use an alias to label the count as CustomerCount. Order
the list by the CustomerCount, largest to smallest. */

select country,
COUNT(distinct customerID) as customerCount
from customers
group by country; 

/* 6.What are the products that we carry where we have less than 25 units on hand, but 1
or more units of them are on order? Write a query that orders them by quantity on
order (high to low), then by product name.
*/
use northwind;
select productname, unitsinstock, unitsonorder from products 
where unitsinstock <= '25' and unitsonorder >= '1';

-- 7. Write a query to list each of the job titles in employees, along with a count of how many employees hold each job title
select title,
 count(title) as NumberOfEmployees from employees
 group by title; 

