--intermediate_queries_sql--

--21.Find delayed orders where delivery happened after estimated delivery dtae.--
select * 
from orders
where order_estimated_delivery_date<order_delivered_customer_date;

--22.Find order delivered before estimated date.--
select *
from orders
where order_estimated_delivery_date>order_delivered_customer_date;

--23.Find products with highest freight value--
select * 
from order_items
order by freight_value 
desc limit 10;

--24.Find sellers with highest number of order--
select 
s.seller_id,count(distinct oi.order_id) as order_count
from sellers s join order_items oi 
on s.seller_id=oi.seller_id
group by s.seller_id
order by order_count
desc limit 10;

--25.Find average payment installments by payment type.--
select
   payment_type,round(avg(payment_installments),2)
   as avg_installment
from payments group by payment_type;

--26.Find top revenue generating month--
select
   To_Char (o.order_purchase_timestamp,'yyyy-mm') as month,
round(sum(p.payment_value)::numeric,2) 
as total_revenue
from orders o 
join payments p on
o.order_id=p.order_id
group by month
order by total_revenue desc 
limit 10;

--27.Find inactive customers who ordered only once--
select 
   c.customer_unique_id,count(o.order_id) as order_count
from customers c join orders o on
c.customer_id=o.customer_id
group by c.customer_unique_id
having count(o.order_id)=1;
 