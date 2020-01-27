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


-- Big Query

SELECT 
ord.order_id
, ord.order_status
, ord.order_purchase_timestamp
, ord.order_delivered_customer_date
, ord.order_delivered_carrier_date
, ord.order_approved_at
, order_estimated_delivery_date
, ordIt.price orderItemPrice
, cust.customer_zip_code_prefix
, cust.customer_city
, cust.customer_state
, geoCust.geolocation_lat Cust_GeoLocation_Lat
, geoCust.geolocation_lng Cust_GeoLocation_Lng
, ordPay.payment_sequential
, ordPay.payment_type
, ordPay.payment_installments
, ordPay.payment_value
, prod.product_category_name
, prod.product_name_lenght
, prod.product_description_lenght
, prod.product_photos_qty
, sell.seller_zip_code_prefix
, sell.seller_city
, sell.seller_state
, geoSell.geolocation_lat Sell_GeoLocation_Lat
, geoSell.geolocation_lng Sell_GeoLocation_Lng
FROM orders ord
INNER JOIN order_items ordIt ON ord.order_id = ordIt.order_id
INNER JOIN customers cust ON cust.customer_id = ord.customer_id
INNER JOIN order_payments ordPay ON ordPay.order_id = ord.order_id
INNER JOIN product prod ON prod.product_id = ordIt.product_id
INNER JOIN sellers sell ON sell.seller_id = ordIt.seller_id
LEFT JOIN (
    select
        row_number() over(partition by geolocation_zip_code_prefix order by geolocation_zip_code_prefix) as rn,
        geolocation_zip_code_prefix, geolocation_lat
        , geolocation_lng, geolocation_city, geolocation_state
    from geolocation) geoSell ON geoSell.geolocation_zip_code_prefix = sell.seller_zip_code_prefix AND geoSell.rn = 1
LEFT JOIN (
    select
        row_number() over(partition by geolocation_zip_code_prefix order by geolocation_zip_code_prefix) as rn,
        geolocation_zip_code_prefix, geolocation_lat
        , geolocation_lng, geolocation_city, geolocation_state
    from geolocation) geoCust ON geoCust.geolocation_zip_code_prefix = cust.customer_zip_code_prefix AND geoCust.rn = 1    
;
