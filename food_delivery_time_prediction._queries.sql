select * from food_delivery limit 10

--1) Find the number of orders for each restaurant.
select pickup_zone,sum(order_items)
from food_delivery
group by pickup_zone

--2) Find the average delivery time for each vehicle type.
select vehicle_type,round(avg(delivery_time),2)
from food_delivery
group by vehicle_type

--3) Find the average delivery time for each weather condition.
select weather,round(avg(delivery_time),2)
from food_delivery
group by weather

--4) Find the percentage of orders delivered in less than 30 minutes.
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN delivery_time < 30 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS delivered_in_30_min
FROM food_delivery;

--5) Top 5 restaurants with highest average delivery time
select pickup_zone,round(avg(delivery_time),2)
from food_delivery
group by pickup_zone
order by avg(delivery_time) desc
limit 5

--6) Top 5 Pickup Zones with the most orders in rain
select pickup_zone,sum(order_items)
from food_delivery
where weather='Rain'
group by pickup_zone
order by sum(order_items) desc
limit 5

--7) Top 5 Fastest and slowest deliveries from each pickup zone
select pickup_zone,
		min(delivery_time) as fast_delivery,
		max(delivery_time) as slow_delivery
from food_delivery
group by pickup_zone

--8) Peak ordering hour with number of orders
select order_hour,count(order_items)
from food_delivery
group by order_hour
order by count(order_items) desc
limit 1

--9) Number of delayed orders (>45 minutes)
select pickup_zone,count(*) as delayed_orders
from food_delivery
where delivery_time>45
group by pickup_zone

-- 10) Number of orders delivered based on traffic level
select traffic_level,count(*)
from food_delivery
group by traffic_level
order by count(*) desc
