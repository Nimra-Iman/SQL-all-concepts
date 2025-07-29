# create database e_commerce;

# create table customers(
# 	customer_id text,
#     customer_unique_id text,
# customer_zip_code_prefix text, -- -----------------------
#        customer_city text,
#        customer_state text
# );


# create table geolocation(
#   geolocation_zip_code_prefix int,
#   geolocation_lat double,
#   geolocation_lng double,
#   geolocation_city text,
#   geolocation_state text
# );

# create table orders(
# 	order_id text,
#     customer_id text,
#     order_status text,
#     order_purchase_timestamp datetime,
#        order_approved_at datetime,
#        order_delivered_carrier_date datetime,
#        order_delivered_customer_date datetime,
#        order_estimated_delivery_date datetime

# );

# create table order_items(
#      order_id text,
#      order_item_id  int, 
#      product_id text,
#      seller_id   text,
#        shipping_limit_date datetime,
#        price double,
#        freight_value double
# );
# create table payments(
# 	order_id text,
#     payment_sequential int,
#     payment_type text ,
#        payment_installments int,
#        payment_value double

# );

# create table products(
#    product_id text,
#    product_category text,
#    product_name_length int,
#        product_description_length int,
#        product_photos_qty int  ,
#        product_weight_g int,
#        product_length_cm  int, 
#        product_height_cm int,
#        product_width_cm int
       

# );

# create table sellers(
# 	seller_id text,
#     seller_zip_code_prefix int,
#     seller_city text,
#     seller_state text
# );

