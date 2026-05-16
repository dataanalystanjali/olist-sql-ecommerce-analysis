--11.Find monthly sales trend.--
select 
  TO_CHAR (o.order_purchase_timestamp,'yyyy-mm')
as month,
  round(sum(p.payment_value)::numeric,2) as
total_revenue
from orders o join payments p 
on o.order_id=p.order_id
group by month
order by month;

--12.Find top 10 customers by spending.--
select 
   c.customer_id,c.customer_unique_id,
   round(sum(p.payment_value)::numeric,2) as 
total_spending from customers c join orders o 
on c.customer_id=o.customer_id 
join payments p 
on o.order_id=p.order_id 
group by c.customer_id,c.customer_unique_id
order by total_spending desc limit 10;
   
--13.Find top 10 sellers by revenue--
select 
    s.seller_id,
	round(sum(oi.price)::numeric,2) as 
seller_revenue
from sellers s join order_items oi 
on s.seller_id=oi.seller_id
group by s.seller_id
order by seller_revenue desc limit 10;

--14.Find average order value--
select
    round(avg(payment_value)::numeric,2) as 
average_order_value
from payments;

--15.Find top 10 selling product categories--
select
    p.product_category_name,round(sum(oi.price)::numeric,2) as
category_total_sales
from products p join order_items oi on 
p.product_id=oi.product_id                     
group by p.product_category_name
order by category_total_sales
desc limit 10;

--16.Find Customers who placed multiple orders--
select 
    c.customer_unique_id,
	count(o.order_id) as total_orders 
from customers c join orders o 
on c.customer_id=o.customer_id
group by c.customer_unique_id
having count(o.order_id)>1
order by total_orders ;

--17.Find total revenue by state--
select
    c.customer_state,round(sum(p.payment_value)::numeric,2) as
state_total_revenue	
from customers c join orders o
on c.customer_id=o.customer_id
join payments p 
on o.order_id=p.order_id
group by c.customer_state
order by state_total_revenue;

--18.Find top 5 cities with highest customers--
select
    customer_city,count(*) as city_customer_total
from customers 
group by customer_city
order by city_customer_total
desc limit 5;

--19.Find most used payment type--
select
    payment_type,count(*) as payment_type_count
from payments 
group by payment_type
order by payment_type_count
desc limit 1;

--20.Find percentage of delievered orders--	
select
   round(
         (count(case
		          when order_status='delieverd'
				 then 1 end)
			 *100.0
			)/count(*),
		  2
		) as delievered_order_percentage
from orders;		
		
