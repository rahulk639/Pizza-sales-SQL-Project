-- Total number of orders
SELECT COUNT(order_id) AS total_orders FROM orders;

-- Total revenue from pizza sales
SELECT ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS total_sales
FROM orders_details
JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id;

-- Highest-priced pizza
SELECT pizza_types.name, pizzas.price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Most common pizza size ordered
SELECT pizzas.size, COUNT(orders_details.order_details_id) AS order_count
FROM pizzas
JOIN orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- Top 5 most ordered pizzas
SELECT pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;