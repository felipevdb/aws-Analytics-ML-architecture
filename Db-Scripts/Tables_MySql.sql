USE ECommerce
 


CREATE TABLE IF NOT EXISTS sellers(
	seller_id VARCHAR(200) NOT NULL,
	seller_zip_code_prefix VARCHAR(100) NULL, 
	seller_city VARCHAR(200) NULL, 
	seller_state VARCHAR(10) NULL,
	PRIMARY KEY(seller_id)
);

CREATE TABLE IF NOT EXISTS product_category_name(
	product_category_name VARCHAR(500) NOT NULL,
	product_category_name_english VARCHAR(500) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
	customer_id VARCHAR(200) NOT NULL,
	customer_unique_id VARCHAR(200) NOT NULL,
	customer_zip_code_prefix VARCHAR(200) NULL,
	customer_city VARCHAR(400) NULL,
	customer_state VARCHAR(200) NULL,
	PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS geoLocation (
	geolocation_zip_code_prefix VARCHAR(300) NOT NULL,
	geolocation_lat VARCHAR(300) NULL,
	geolocation_lng VARCHAR(300) NULL,
	geolocation_city VARCHAR(300) NULL,
	geolocation_state VARCHAR(300) NULL,
	PRIMARY KEY (geolocation_zip_code_prefix)
);

CREATE TABLE IF NOT EXISTS order_items(
	order_id VARCHAR(300) NOT NULL,
	order_item_id VARCHAR(300) NULL,
	product_id VARCHAR(300) NULL,
	seller_id VARCHAR(300) NULL,
	shipping_limit_date VARCHAR(300) NULL,
	price VARCHAR(300) NULL,
	freight_value VARCHAR(300) NULL,
	PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS order_reviews(
	review_id VARCHAR(300) NOT NULL,
	order_id VARCHAR(300) NULL,
	review_score VARCHAR(300) NULL,
	review_comment_title VARCHAR(400) NULL,
	review_comment_message VARCHAR(700) NULL,
	review_creation_date VARCHAR(300) NULL,
	review_answer_timestamp VARCHAR(300) NULL,
	PRIMARY KEY (review_id)
);

CREATE TABLE IF NOT EXISTS orders(
	order_id VARCHAR(100) NOT NULL,
	customer_id VARCHAR(200) NULL,
	order_status VARCHAR(200) NULL,
	order_purchase_timestamp VARCHAR(200) NULL,
	order_approved_at VARCHAR(200) NULL,
	order_delivered_carrier_date VARCHAR(200) NULL,
	order_delivered_customer_date VARCHAR(200) NULL,
	order_estimated_delivery_date VARCHAR(200) NULL
);

CREATE TABLE IF NOT EXISTS products (
	product_id VARCHAR(200) NOT NULL,
    product_category_name VARCHAR(200) NULL,
    product_name_lenght	VARCHAR(200) NULL,
    product_description_lenght	VARCHAR(200) NULL,
    product_photos_qty	VARCHAR(200) NULL,
    product_weight_g	VARCHAR(200) NULL,
    product_length_cm	VARCHAR(200) NULL,
    product_height_cm	VARCHAR(200) NULL,
    product_width_cm VARCHAR(200) NULL
);

CREATE TABLE IF NOT EXISTS order_payments(
	order_id	VARCHAR(200) NOT NULL,
    payment_sequential	VARCHAR(200) NULL,
    payment_type	VARCHAR(200) NULL,
    payment_installments	VARCHAR(200) NULL,
    payment_value VARCHAR(200) NULL
);
