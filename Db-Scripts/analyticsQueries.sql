--average ticket
select avg(ord.price) from (select sum(price) from order_items group by order_id) as ord(price);

--orders per hour
select date_trunc('hour', o.order_purchase_timestamp), count(distinct oi.order_id) from order_items oi INNER JOIN orders o ON oi.order_id = o.order_id group by date_trunc('hour', o.order_purchase_timestamp) order by date_trunc('hour', o.order_purchase_timestamp) desc limit 10;

--total per hour
select date_trunc('hour', o.order_purchase_timestamp), sum(oi.price) from order_items oi INNER JOIN orders o ON oi.order_id = o.order_id group by date_trunc('hour', o.order_purchase_timestamp) order by date_trunc('hour', o.order_purchase_timestamp) desc limit 10;

--order per city
select c.customer_city, count(o.order_id) from orders o INNER JOIN customers c ON o.customer_id = c.customer_id group by c.customer_city order by count(o.order_id) desc limit 10;

--value per city
select c.customer_city, sum(oi.price) from orders o INNER JOIN customers c ON o.customer_id = c.customer_id INNER JOIN order_items oi ON oi.order_id = o.order_id group by c.customer_city order by sum(oi.price) desc limit 10;

--best sellers
select p.product_category_name, count(oi.order_id) from order_items oi INNER JOIN product p ON oi.product_id = p.product_id group by p.product_category_name order by count(oi.order_id) desc limit 10;