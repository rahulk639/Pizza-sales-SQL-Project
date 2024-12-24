-- Quantity by category
SELECT pizza_types.category, SUM(orders_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- Orders by hour
SELECT HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY HOUR(order_time)
ORDER BY order_count DESC;

-- Category-wise distribution of pizzas
SELECT category, COUNT(name) FROM pizza_types
GROUP BY category;

-- Average pizzas ordered per day
SELECT ROUND(AVG(quantity), 0) AS avg_pizza_ordered_per_day
FROM (SELECT orders.order_date, SUM(orders_details.quantity) AS quantity
      FROM orders
      JOIN orders_details ON orders.order_id = orders_details.order_id
      GROUP BY orders.order_date) AS order_quantity;

-- Top 3 pizzas by revenue
SELECT pizza_types.name, ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;