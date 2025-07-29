create database e_commerce;

create table customers(
	customer_id text,
    customer_unique_id text,
customer_zip_code_prefix text, 
       customer_city text,
       customer_state text
);


create table geolocation(
  geolocation_zip_code_prefix text,
  geolocation_lat double,
  geolocation_lng double,
  geolocation_city text,
  geolocation_state text
);


create table orders(
	order_id text,
    customer_id text,
    order_status text,
    order_purchase_timestamp datetime,
       order_approved_at datetime,
       order_delivered_carrier_date datetime,
       order_delivered_customer_date datetime,
       order_estimated_delivery_date datetime

);


create table order_items(
     order_id text,
     order_item_id  int, 
     product_id text,
     seller_id   text,
       shipping_limit_date datetime,
       price double,
       freight_value double
);


create table payments(
	order_id text,
    payment_sequential int,
    payment_type text ,
       payment_installments int,
       payment_value double

);


create table products(
   product_id text,
   product_category text,
   product_name_length int,
       product_description_length int,
       product_photos_qty int  ,
       product_weight_g int,
       product_length_cm  int, 
       product_height_cm int,
       product_width_cm int
       

);

create table sellers(
	seller_id text,
    seller_zip_code_prefix int,
    seller_city text,
    seller_state text
);
-- SELECTIMG SPECIFIC COLUMNS:
select order_id from payments;

-- WHERE STATEMENT TO GET NULL VALUES:
select order_approved_at, order_status from orders where order_approved_at is null;

-- AND, OR , NOT OPERATIORS:
select * from payments where payment_value <= 1 and payment_type="voucher"; -- dono conditions
-- fulfil hona zruri h AND m

select * from payments where payment_value >= 1 or payment_type="voucher"; -- koi ek conditions
-- fulfil ho gi to result show ho jay ga

select * from payments where (payment_type="voucher" and payment_value = 1) 
 or  payment_installments=1; 

-- BETWEEN OPRATOR
select * from payments where payment_value between 150 and 200;

-- IN OPEARTOR: (jab bhhtt saary or deny hoty to us ki jga hm in likh ka brcket 
-- m vo sab daal dety),
select * from customers where customer_city in ("franca", "campinas"); -- yani
-- in dono m s koi bhi state ho jay 

select * from customers where customer_city not in ("franca", "campinas"); -- yani
-- in dono k ilava koi state ho

--  LIKE OPARATOR: 
select * from customers where customer_city like "R%"; -- yani vo cities jo R s 
-- start hon or un k agy kafi ziada characters hon

select * from customers where customer_city like "_R"; -- vo cities jin k start m koi ek 
-- letter ho and then R ho

-- ORDER BY:
select * from payments order by payment_value desc, payment_installments desc;-- 
-- The result set is first sorted by the payment_value column and This means that 
-- within groups of equal payment_value, rows with higher payment_installments come
-- before rows with lower payment_installments.

-- limit:
select * from payments order by payment_value desc limit 2; -- just phli 2 rows
select * from payments order by payment_value desc limit 2,3; -- phli 2 rows ko chor kr
-- agli 3 rows show kry ga

-- -----  FUNCTIONS--------
select sum(payment_value) from payments;
select round(avg(payment_value),2) from payments;
select payment_value, ceil(payment_value) from payments;
select payment_value, floor(payment_value) from payments;
select min(payment_value) from payments;
select max(payment_value) from payments;
select count(order_id) from payments; -- y actually number of rows ko count krta h
select count(payment_type) from payments;
select count(distinct payment_type) from payments;

-- ------  text functions ---------------
select seller_city, length(seller_city) as length_of_city_word from sellers;
-- length(seller_city) y btay ga k hr city k kitny letters hn or spaces ko bhi count kia jay ga

select seller_city, trim(seller_city) from sellers;
-- trim(seller_city) string ki starting and ending white spaces ko remove krta h but 
-- it not remove white spaces that are present inside string.

select upper(seller_city) from sellers;  -- upper case m convert kry gi

select seller_city, replace(seller_city, "a","i") from sellers; -- ab seller_city m jhan
-- pr bhi "a" the vo replace ho jay ga "i" s 

select concat(seller_city," ", seller_state) as concatenated_columns_state_city from
 sellers;


-- -------------  DATE FUNCTIONS AND TIME FUNCTIONS 
select order_delivered_customer_date, 
day(order_delivered_customer_date),
dayname(order_delivered_customer_date),
date(order_delivered_customer_date),
month(order_delivered_customer_date),
monthname(order_delivered_customer_date),
year(order_delivered_customer_date)
from orders;

select order_delivered_customer_date,
hour(order_delivered_customer_date),
minute(order_delivered_customer_date),
second(order_delivered_customer_date)
 from orders;

-- -------------difference between 2 dates----------------
select datediff(order_delivered_customer_date, order_estimated_delivery_date) from
orders; -- yani dono dates m kitna difference h , agar order customer ko 5 date ko
-- deliver hua or expected tha k 10 ko deleiver ho to yani 5-10 hua yani -5 to -5 
-- ka matlab y hua k custimer ko order expected date s 5 din phly mila


-- -------------  group by ----
select order_status, count(order_status) from orders group by order_status;


select payment_type, round(sum(payment_value),2) from payments group by 
payment_type;

-- ---------  having  -----------------
-- having is used when "where" cannot be used with aggregate functions
select payment_type, round(sum(payment_value),2) as sum from payments
 where sum<=200 group by 
payment_type;     -- ab yhan m where ko use nhi kr skti q k where ko
-- aggregate functions k saath use nhi kia ja skta

select payment_type, round(sum(payment_value),2) as sum from payments
  group by payment_type having sum>=200; 

select payment_type, sum from  
(select payment_type, round(sum(payment_value),2) as sum from payments
 group by 
payment_type) as a where sum>=200; -- but now it will run

-- --------  joins -------------
select customers.customer_city, orders.order_id from orders join 
customers on orders.customer_id=customers.customer_id limit 5;

select customers.customer_city, orders.order_id from orders left join 
customers on orders.customer_id=customers.customer_id limit 5;


create table student(
name text,
roll_num int,
address text);

create table department(
dep_name text,
roll_num int,
course text);

INSERT INTO student (name, roll_num, address) VALUES
("nimra", 4, "block 4"),
("kinza", 5, "sgd"), 
("shiza", 6, "sill");

insert into department(dep_name, roll_num, course) values
("IT", 4 , "cpp"),("MRK",5,"bus"),("IT",3,"oop")
;

select * from student join department on 
student.roll_num=department.roll_num;

select * from student left join department on 
student.roll_num=department.roll_num;

select * from student cross join department on 
student.roll_num=department.roll_num;


-- -----------  subquery  -----------------------
-- calculate payment of each product and show name of product
-- that is on top
SELECT 
    product_category AS highest_soled_product
FROM
    (SELECT 
        products.product_category,
            ROUND(SUM(payments.payment_value), 2) AS total_payments
    FROM
        products
    JOIN order_items ON products.product_id = order_items.product_id
    JOIN payments ON payments.order_id = order_items.order_id
    GROUP BY products.product_category
    ORDER BY total_payments DESC) AS a
LIMIT 1; -- agar m yhan
-- subquery nhi lgati or inner_query m hi limit 1 likh deti to product a to jani thi but saath
-- us ki total_payments vala column bhi ana tha

-- -------------  CTE (common table expression )  ----------------------
-- jab hm subquery likhty hn to inner query valy ko ek table 
-- consoder krty hn or us ko name dety hn "as" k zrye, similary 
-- we can use cte here as :

with a as (SELECT 
        products.product_category,
            ROUND(SUM(payments.payment_value), 2) AS total_payments
    FROM
        products
    JOIN order_items ON products.product_id = order_items.product_id
    JOIN payments ON payments.order_id = order_items.order_id
    GROUP BY products.product_category
    ORDER BY total_payments DESC) 
select product_category from a;


-- --------------------  CASE OPERATOR  --------------------
with a as (SELECT 
        products.product_category,
            ROUND(SUM(payments.payment_value), 2) AS total_payments
    FROM
        products
    JOIN order_items ON products.product_id = order_items.product_id
    JOIN payments ON payments.order_id = order_items.order_id
    GROUP BY products.product_category
    ORDER BY total_payments DESC) 
SELECT 
    *,
    CASE
        WHEN total_payments <= 50000 THEN 'low'
        WHEN total_payments >= 100000 THEN 'high'
        ELSE 'medium'
    END AS 'sale_type'
FROM
    a;

-- -------------  window functions  ----------------
-- cumulative sum

with a as(select year(orders.order_purchase_timestamp) as year , sum(payments.payment_value) as 
total_payments from 
payments join orders on payments.order_id = orders.order_id group by 
year);

-- ---------------- view  ----------------
-- agar ap chahty ho k koi bhi table ap hamesha show krvana chaho alag s , yani
-- ek virtual table create krna chaho to vo kr skty hn:
create view my_table as select year(orders.order_purchase_timestamp) as year ,
 sum(payments.payment_value) as 
total_payments from 
payments join orders on payments.order_id = orders.order_id group by 
year; -- ab tables k neechy views m y virtual table add ho gya
select * from my_table;





-- agar direct join na lgy 2 tables ka to hm teesry table k zrye double join
-- lga kr kaam krty hn or Y BAAT YAAD RHY K US THIRD TABLE K ANDER 
-- UN DONO TABLES K COLUMNS MOJOOD HON JIN KO DIRECT JOIN NHI KR PA RHY TH
-- YANI THIRD TABLE KA DIRECT JOIN PHLY DONO TABLES S LAG SKTA HO


