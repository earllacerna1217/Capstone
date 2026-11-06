-- Teritory Assigned: State of Maine
/* What is total revenue overall for sales in the assigned territory, plus the start date and end date
that tell you what period the data covers?

-- Total Maine online reveue: 863839.80 +  Total Maine in store revenue:  '1877249.75' = '2741089.55'
*/  
use sample_sales;
 select
(select sum(salestotal) from online_sales
where ShiptoState = 'Maine')
+
(select sum(s.sale_amount)
from store_sales as s
where s.store_ID  in (select storeID from store_locations as sl
where sl.state = 'Maine'
)) as Maine_Total_Revenue;

-- Start date and End date covered for online sales: 
SELECT * FROM sample_sales.online_sales 
order by date asc; -- 2022-01-01
SELECT * FROM sample_sales.online_sales 
order by date desc; -- 2025-12-31
-- Start and end date covered for in-store sales: 
SELECT * FROM sample_sales.store_sales
order by Transaction_Date asc; -- 2022-01-01
SELECT * FROM sample_sales.store_sales
order by Transaction_Date desc; -- 2025-12-31

-- What is the revenue breakdown by year and month for the sales territory?

-- Monthly breakdown for online:
select month(date) as month, year(date), sum(salestotal) as Maine_total_revenue from online_sales
where shiptostate = 'Maine'
group by year(date), month(date)
order by year(date), month(date);

-- Yearly breakdown for online: 
select year(date) as year , sum(salestotal) as Maine_total_revenue from online_sales
where shiptostate = 'Maine'
group by year(date)
order by year(date);

-- In-store 

-- Monthly breakdown for In-store:
select month(transaction_date), year(transaction_date) as year , sum(sale_amount) as Maine_monthly_revenue from store_sales
where store_ID in (select storeID from store_locations
where state = 'Maine')
group by year(transaction_date), month(transaction_date)
order by year(transaction_date), month(transaction_date);

-- Yearly breakdown for In-store: 
select year(transaction_date) as year , sum(sale_amount) as Maine_yearly_revenue from store_sales
where store_ID in (select storeID from store_locations
where state = 'Maine')
group by year(transaction_date)
order by year(transaction_date);

-- Provide a comparison of total revenue for the specific sales territory and the region it belongs to.
-- Maine total revenue: '2,741,089.55'
 select
(select sum(salestotal) from online_sales
where ShiptoState = 'Maine')
+
(select sum(sale_amount)
from store_sales
where store_ID  in (select storeID from store_locations
where state = 'Maine'
)) as Maine_Total_Revenue;

-- Northeast region total revenue: '32,846,960.65'
 select sum(NE_Revenue) as NE_Region_revenue from (
 select sl.state, sum(s.sale_amount) as NE_Revenue from store_sales as s
 join store_locations as sl
 on s.Store_Id = sl.storeID
 where sl.state in ('Maryland', 'Massachusetts', 'Maine', 'New Jersey')
 group by sl.state

union all

select o.shiptostate, sum(o.salestotal) as NE_Revenue from online_sales as o
 where o.shiptostate in ('Maryland', 'Massachusetts', 'Maine', 'New Jersey')
 group by o.shiptostate ) as combined_sales; 

-- Maine's pecentage contribution to Northeast region: 8.35% 
select round((2741089.55 / 32846960.65) * 100,2) as Maine_percentage_cotribution;

-- What is the number of transactions per month and average transaction amount by product category for the sales territory?

-- In store Maine's number of transactions per month and average transaction amount by product category 
select year(s.transaction_date) as transaction_year, month(s.transaction_date) as transaction_month, ic.category as Category,
count(s.id) as transactions_count, round(avg(sale_amount),2) as average_transaction_amount from store_sales as s
join products as p
on s.prod_num = p.prodnum
join store_locations as sl
on s.store_ID = sl.storeID
join inventory_categories as ic
on p.categoryID = ic.categoryID
where sl.state = 'Maine' 
group by year(s.transaction_date), month(s.transaction_date), ic.category
order by year(s.transaction_date), month(s.transaction_date);

-- Online Maine's number of transactions per month and average transaction amount by product category 
select year(o.date) as transaction_year, month(o.date) as transaction_month, ic.category as Category,
count(o.id) as transactions_count, round(avg(salestotal),2) as average_transaction_amount from online_sales as o
join products as p
on o.prodnum = p.prodnum
join inventory_categories as ic
on p.categoryID = ic.categoryID
where o.shiptostate = 'Maine' 
group by year(o.date), month(o.date), ic.category
order by year(o.date), month(o.date);

-- Store ranking in sales performance from top highest to bottom lowest
select s.store_Id, sl.StoreLocation, sum(s.sale_amount) as store_revenue from store_sales as s
join store_locations as sl
on s.store_Id = sl.storeID
where state = 'Maine'
group by storelocation, store_ID
order by sum(sale_amount) desc; 

-- What is your recommendation for where to focus sales attention in the next quarter?
-- 2025 in store ranking
select year(s.transaction_date), s.store_Id, sl.StoreLocation, sum(s.sale_amount) as store_revenue from store_sales as s
join store_locations as sl
on s.store_Id = sl.storeID
where state = 'Maine' and year(s.transaction_date) = '2025'
group by year(s.transaction_date), storelocation, store_ID
order by sum(sale_amount) desc; 

-- 2025 Q4 store ranking: 
select year(s.transaction_date) as Year , month(s.transaction_date) as Month, s.store_Id, sl.StoreLocation, sum(s.sale_amount) as Store_revenue from store_sales as s
join store_locations as sl
on s.store_Id = sl.storeID
where state = 'Maine' and year(s.transaction_date) = 2025 and month(s.transaction_date) in (10, 11, 12)
group by storelocation, store_ID, year(s.transaction_date), month(s.transaction_date)
order by month(s.transaction_date), sum(sale_amount) desc; 

-- Bar Harbor Q4 Performance 
select year(s.transaction_date), month(s.transaction_date) as Month, s.store_Id, sl.StoreLocation, sum(s.sale_amount) as store_revenue from store_sales as s
join store_locations as sl
on s.store_Id = sl.storeID
where storelocation = 'Bar Harbor'and state = 'Maine' and year(s.transaction_date) = 2025 and month(s.transaction_date) in (10, 11, 12)
group by storelocation, store_ID, year(s.transaction_date), month(s.transaction_date)
order by month(s.transaction_date), sum(sale_amount) desc; 

-- Recommendation Analysis for Q1 2026 from 2025 Q4: I would recommend investigating Bar Harbor steady decline in Q4 2024.  It shows the for each month of the quarter the revenue declines each month.
