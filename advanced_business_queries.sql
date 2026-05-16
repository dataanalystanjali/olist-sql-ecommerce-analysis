--ADVANCED QUERIES SQL--

--28.Rank sellers based on total revenue--
select 
s.seller_id,
round(sum(oi.price)::numeric,2)
as total_revenue,
rank() over (order by sum(oi.price) desc
) as seller_rank
from sellers s join order_items oi
on s.seller_id=oi.seller_id
group by s.seller_id;


--29.Create customer segmentation based on spending--
select 
     c.customer_unique_id,
	 round(sum(p.payment_value)::numeric,2)
	 as total_spending,
	 case
	     when sum(p.payment_value)>=10000
		 then 'high_value'
		 when sum (p.payment_value)>=5000
		 then 'medium value'
		 else 'low value'
END AS customer_segment
from customers c join orders o
on c.customer_id=o.customer_id 
join payments p on 
o.order_id=p.order_id

group by c.customer_unique_id
order by total_spending desc;


--30.Find the most profitable category--
select 
    p.product_id,p.product_category_name,
    round(sum(oi.price)::numeric,2)
	as total_revenue
from products p	join order_items oi
on p.product_id=oi.product_id
group by p.product_id,p.product_category_name
order by total_revenue desc
limit 10;
	
--31.Create a complete business summary KPI query--
select 
    count(distinct c.customer_unique_id)
	as total_customers,
	count(distinct o.order_id)
	as total_orders,
	round (sum(p.payment_value)::numeric,2)
	as total_revenue,
	round(sum(p.payment_value)/count(distinct o.order_id)
	::numeric,2)
	as average_order_value,
	count (distinct s.seller_id) as total_sellers

	from customers c 
	join orders o 
	on c.customer_id=o.order_id
	join payments p 
	on o.order_id=p.order_id
	join order_items oi 
	on o.order_id=oi.order_id
	join sellers s
	on oi.seller_id=s.seller_id;
	

















