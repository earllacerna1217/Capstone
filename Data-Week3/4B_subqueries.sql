-- Exercise 4.A 

-- 1. What is the product name(s) of the most expensive products? Cte de Blaye
use northwind;
select productname, unitprice from products
order by unitprice desc
limit 1;


-- 2. What is the product name(s) and categories of the least expensive products? Geitost 
use northwind;
select productname, unitprice from products
order by unitprice asc
limit 1;

-- 3. What is the order id, shipping name and shipping address of all orders shipped via "Federal Shipping"?
select o.orderid, o.shipname, o.shipvia, shipaddress, s.shipperID, s.companyname from orders as o
left join shippers as s
on o.shipvia = s.shipperID
group by o.orderID, s.companyname
having companyname = 'Federal Shipping';

-- 4. What are the order ids of the orders that included "Sasquatch Ale"?
select p.productname, o.orderID, o.productID from `order details` as o
join products as p
on o.productID = p.productID
where p.productname = 'Sasquatch Ale';

-- 5. What is the name of the employee that sold order 10266? Janet Leverling
select o.orderID, o.employeeID, e.firstname, e.lastname from orders as o
left join employees as e
on o.employeeID = e.employeeID
having orderID = '10266';

-- 6. What is the name of the customer that bought order 10266? 
select o.orderID, o.customerID, c.contactname from orders as o
left join customers as c
on o.customerID = c.customerID
having orderID = '10266';