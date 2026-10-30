-- Exercise 2.A Working with Joins

-- 1. Create a single query to list the product id, productname, unitprice and category name of all products. Order by category name and within that, by product nam
use northwind;
select p.ProductID, 
p.productname,
 p.unitprice,
 p.CategoryID, 
 c.CategoryName from products as p
inner join categories as c
on p.categoryid = c.categoryId
order by c.categoryname asc, p.productname asc;

-- 2. Create a single query to list the product id, product name, unit price and supplier name of all products that cost more than $75. Order by product name.
use northwind;
select p.productID, p.productName, p.unitprice, p.supplierID, s.companyname from products as p
inner join suppliers as s
on p.supplierID = s.supplierID
where unitprice > 75
order by productname; 

-- 3. Create a single query to list the product id, product name, unit price, category name, and supplier name of every product. Order by product name.
select p.productID, p.productName, p.unitprice, p.supplierID, s.companyname from products as p
INNER join suppliers as s
on p.supplierID = s.supplierID
order by productname; 

/* 4.Create a single query to list the order id, ship name, ship address, and shipping company name of every order that shipped to Germany. Assign the shipping company 
name the alias ‘Shipper.’ Order by the name of the shipper, then the name of who it  shipped to. */ 
select o.customerID, o.orderID, o.shipaddress, o.shipname, o.shipvia, o.shipcountry, s.companyname as shipperName from orders as o
inner join shippers as s
on o.shipvia = s.shipperID
where shipcountry ='Germany';

/* 5. Start from the same query as above (#4), but omit OrderID and add logic to group by
ship name, with a count of how many orders were shipped for that ship name */ 
select o.shipname , COUNT(*) as ordercount from orders as o 
inner join shippers as s
on o.shipvia = s.shipperID
where shipcountry ='Germany'
group by o.shipname;

-- 6. Createsingle query to list the order id, order date, ship name, ship address of all ordesrs that included Sasquatch Ale.      
select o.orderID, o.OrderDate, o.shipname, o.shipaddress, p.productname from orders as o
join `order details` as od
on o.orderID = od.orderID
join products as p
on od.productID = p.productID
where productname = 'Sasquatch Ale';

																																																												`1                                                                                                                                                                                                 