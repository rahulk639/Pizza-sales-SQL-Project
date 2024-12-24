-- Revenue percentage contribution by pizza type
SELECT pizza_types.category, ROUND((SUM(orders_details.quantity * pizzas.price) / 
(SELECT ROUND(SUM(orders_details.quantity * pizzas.price), 2) FROM orders_details
JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id)) * 100, 2) AS revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY revenue DESC;

-- Cumulative revenue over time
SELECT order_date, SUM(revenue) OVER (ORDER BY order_date) AS cum_revenue
FROM (SELECT orders.order_date, SUM(orders_details.quantity * pizzas.price) AS revenue
      FROM orders_details
      JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
      JOIN orders ON orders.order_id = orders_details.order_id
      GROUP BY orders.order_date) AS sales;

-- Top 3 pizzas by revenue for each category
SELECT name, revenue FROM (SELECT category, name, revenue, RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn
                           FROM (SELECT pizza_types.category, pizza_types.name, SUM(orders_details.quantity * pizzas.price) AS revenue
                                 FROM pizza_types
                                 JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
                                 JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
                                 GROUP BY pizza_types.category, pizza_types.name) AS a) AS b
WHERE rn <= 3;