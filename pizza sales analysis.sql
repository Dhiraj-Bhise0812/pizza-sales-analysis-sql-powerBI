use project;
--Retrieve the total number of orders placed:-

select count(order_id) as total_orders from orders;


--Calculate the total revenue generated from pizza sales:-

select sum(order_details.Quantity * pizzas.price) as total_revenue 
from order_details inner join pizzas 
on pizzas.pizza_id=order_details.pizza_id;



--Identify the highest-priced pizza:-

select * from pizzas order by price desc limit 2;
select pizza_types.name,pizzas.price from 
pizza_types inner join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by price desc limit 2;



---Identify the most common pizza size ordered.:-
select pizzas.size, count(order_details.Order_details_id) as total_quantity
from pizzas inner join order_details 
on order_details.pizza_id=pizzas.pizza_id 
group by pizzas.size order by total_quantity desc ;



--- List the top 5 most ordered pizza types along with their quantities:-

select pizza_types.name, count(order_details.Order_details_id) as total_quantity
from pizza_types inner join pizzas 
on pizzas.pizza_type_id=pizza_types.pizza_type_id 
inner join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by total_quantity desc limit 5;



---Join the necessary tables to find the total quantity of each pizza category ordered.:-

select pizza_types.category ,pizza_types.name ,count(order_details.Quantity) as total_quantity 
from pizza_types inner join pizzas 
on pizzas.pizza_type_id=pizza_types.pizza_type_id inner join 
order_details on order_details.pizza_id=pizzas.pizza_id 
group by pizza_types.category,pizza_types.name order by total_quantity desc;



---Determine the distribution of orders by hour of the day.:-

select hour(time) as hour, count(order_id) as total_orders 
from orders
group by hour order by hour asc;



---Join relevant tables to find the category-wise distribution of pizzas:-

select category,count(name) as total_count 
from pizza_types group by category;




---Group the orders by date and calculate the average number of pizzas ordered per day.:-

select avg(quantity) as average_number from 
(select orders.date,sum(order_details.Quantity) as quantity
from order_details inner join orders on
orders.order_id=order_details.order_id 
group by orders.date ) as order_quantity;



---Determine the top 3 most ordered pizza types based on revenue.:-

select order_details.pizza_id,sum(order_details.Quantity * pizzas.price) as revenue
from order_details inner join pizzas 
on pizzas.pizza_id=order_details.pizza_id 
group by order_details.pizza_id order by revenue desc limit 3;


Select pizza_types.name, SUM(order_details.quantity *pizzas.price) as revenue
from pizza_types INNER JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id INNER JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
Group by pizza_types.name ORDER BY revenue DESC LIMIT 3;




---Calculate the percentage contribution of each pizza type to total revenue.:-

select pizza_types.name,round(sum(order_details.quantity * pizzas.price) /(select sum(order_details.quantity * pizzas.price) 
from order_details inner join pizzas on pizzas.pizza_id=order_details.pizza_id ) *100,2 ) as revenue_percent
from pizza_types inner join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id 
inner join order_details on pizzas.pizza_id=order_details.pizza_id 
group by pizza_types.name order by revenue_percent desc;




---Analyze the cumulative revenue generated over time.:-

SELECT Date,
       SUM(cumt_revenue) OVER (ORDER BY date) AS cum_revenue
FROM(
select orders.date , sum(order_details.quantity * pizzas.price) as cumt_revenue 
from order_details inner join orders on order_details.order_id=orders.order_id 
inner join pizzas on order_details.pizza_id=pizzas.pizza_id 
group by orders.date) as sales ;


SELECT Date,
       SUM(revenue) OVER (ORDER BY date) AS cum_revenue
FROM (
    SELECT orders.date,
           SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
   INNER JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    INNER JOIN orders ON orders.order_id = order_details.order_id
    GROUP BY orders.date
) AS sales;
use project;



---Determine the top 3 most ordered pizza types based on revenue for each pizza category.:-

with revenue_ranking as (
select pizza_types.category,pizza_types.name ,
sum(order_details.Quantity * pizzas.price) as  revenue
from pizza_types inner join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
inner join order_details on pizzas.pizza_id=order_details.pizza_id 
group by pizza_types.category,pizza_types.name ) 
select name,revenue from 
(select category,name ,revenue,
rank () over (partition by category order by revenue desc) as rn from revenue_ranking) as re
where rn<=3 order by rn desc limit 3;