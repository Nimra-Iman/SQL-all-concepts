create database pizzahut;

-- ab is database m hm un csv files ko import kry gy jo k asal m is db
-- k tables hon gy, to import krny k liye isi db k tables pr 
-- right click kr k "table data import wizard" pr click kryn gy then
-- browse then select that csv file you wanna import then next next etc.
-- vesy csv files ko indrustry m support nhi kia jata k sql m import 
-- kr k kaam kia jay hm esa is liye kr rhy q k csv files kaafi ziada 
-- tadad m hn hmary pas.

-- isi trah baki k tables ko bhi import kr len gy but problem is that k 
-- jab bhhhttt bri csv files ho to hm nhi kr skty esa q k vo import hi nhi
-- hon gi, is liye hm khud table bnay gy or us table m csv valy
-- data ko daaly gy: like below::::
create table orders (
	order_id int not null,
    order_date date not null,
    order_time time not null,
    primary key (order_id)
);  -- ab is k ander csv file ka data lay gy by right clicking on table 
-- and then click table data import wizard then browse and use existing table
-- 
create table order_details(
	order_details_id int not null,
    order_id int not null,
    pizza_id text not null,
    quantity int not null,
    primary key(order_details_id)
);

select * from order_details;

-- ANALYSIS-1: The total number of orders placed. -------------------------------
select count(order_id) from orders;

-- ANALYSIS-2: The total revenue generated from pizza sales.  --------------------------------------
select round(sum(order_details.quantity * pizzas.price),2)
as revenue
from order_details join pizzas on
order_details.pizza_id=pizzas.pizza_id order by revenue desc ;
-- round lgany s 2 decimal places tak round ho jay ga

-- ANALYSIS-3: The highest-priced pizza -----------------------------------
select max(price) from pizzas;

select pizza_id, price from pizzas order by price desc limit 1;

select pizza_types.name, pizzas.price from pizzas join pizza_types 
on pizzas.pizza_type_id=pizza_types.pizza_type_id order by price desc
limit 1;

-- ANALYSIS-4:  The most common pizza size ordered. --------------------------------
select 
pizzas.size , count(pizzas.size) as total_order
from order_details join pizzas 
on order_details.pizza_id=pizzas.pizza_id 
group by pizzas.size 
order by  total_order desc;

-- ANALYSIS-5-  The top 5 most ordered pizza types along with their quantities. --------------------------------

-- GET FOUR COLUMNS FROM THREE TABLES USING 2 JOINS:
select pizzas.pizza_type_id, pizza_types.name, pizzas.pizza_id,
order_details.quantity
from pizza_types join pizzas on 
(pizzas.pizza_type_id=pizza_types.pizza_type_id)
 join  order_details on pizzas.pizza_id=order_details.pizza_id;

-- AND THEN DO THIS TO GET SUM OF QUANTITYIES:
select pizza_types.name,
SUM(order_details.quantity) as total_quantity
from pizza_types join pizzas on 
(pizzas.pizza_type_id=pizza_types.pizza_type_id)
 join  order_details on pizzas.pizza_id=order_details.pizza_id 
group by pizza_types.name order by total_quantity desc limit 5;


-- ANALYSIS-6: The total quantity of each pizza category ordered. ---------------------------------- 
select pizza_types.category, sum(order_details.quantity) as total_quantity
 from pizza_types join pizzas on 
 pizza_types.pizza_type_id=pizzas.pizza_type_id  join 
order_details on order_details.pizza_id = pizzas.pizza_id
 group by category order by total_quantity desc ;

-- ANALYSIS-7: Determine the distribution of orders by hour of the day. ----------------------------

select hour(order_time) as hours, count(order_id) from orders
group by hour(order_time);

-- ANALYSIS-8:  The category-wise distribution of pizzas.  ----------------------------
--  distribution yani k ek cotagory m kitny pizzas hn ?
select category, count(pizza_type_id) from pizza_types group by
category;

-- ANALYSIS-9: Group the orders by date and calculate the average number 
-- of pizzas ordered per day.  -----------------------------------
select round(avg(total_quantity),0) from (select orders.order_date, 
sum(order_details.quantity) as total_quantity
 from orders
 join order_details on orders.order_id=order_details.order_id
group by orders.order_date) as  average  ;    


-- ANALYSIS-10: Determine the top 3 most ordered pizza types based on revenue. ---------------------------------
SELECT 
    pizza_types.name,
    sum(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name order by revenue limit 3;


-- ANALYSIS-11: The percentage contribution of each pizza type
-- to total revenue.  ------------------------------------------
SELECT 
    pizza_types.category,
    round((SUM(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS revenue
        FROM
            order_details
                JOIN
            pizzas ON order_details.pizza_id = pizzas.pizza_id
        ORDER BY revenue DESC))*100,2) as revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
order by revenue desc;


-- ANALYSIS-12: Analyze the cumulative revenue generated over time  --------------------------------
-- cumulative yani agar 1st day 200 sales hui and then 2nd day 150
-- sales hui to hmy commulative dikhao yani 2nd day ki sales m 1st day
-- ki sales add kr k dikhao, then 3rd day 200 ki sales hui to commulative
-- dikhao yani 3rd day k ander pichly saary dino ki sales add kr k dikhao
-- yani 200+150+200

select order_date, sum(revenue_per_day) over(order by order_date)
 as cum_revenue from
(select order_date, sum(order_details.quantity * pizzas.price) 
as revenue_per_day
 from orders join order_details on
 orders.order_id=order_details.order_id join pizzas on 
 pizzas.pizza_id = order_details.pizza_id group by order_date) as revenue
 ;

-- ANALYSIS-13: Determine the top 3 most ordered pizza types based 
-- on revenue for each pizza category.----------------------------------
--           yani hr category k top 3 max revenue valy
select category, name, revenue from
(select category, name, revenue, rank() over (partition by category order by revenue
 desc) as rn from
(select pizza_types.category, pizza_types.name, 
sum(order_details.quantity * pizzas.price) as revenue from order_details join
pizzas on order_details.pizza_id = pizzas.pizza_id join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id 
group by pizza_types.category, pizza_types.name
order by pizza_types.category, revenue desc) as a) as b
where rn<=3;







-- order_id tracks the whole order, and order_detail_id tracks each
-- item within that order.
-- order_id: This is a unique identifier for each order placed by a 
-- customer. It groups all items purchased in a single transaction.
-- order_detail_id: This is a unique identifier for each item within
-- an order. It distinguishes individual products within the same order.







