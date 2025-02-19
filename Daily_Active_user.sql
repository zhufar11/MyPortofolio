select sale_date,
str_to_date(sale_date, '%Y-%m-%d')
from sales_data;

update sales_data
set sale_date = str_to_date(sale_date, '%Y-%m-%d');

#mencari total cost per bulan tanggal
select date (sale_date),
sum(cost) as total_cost
from sales_data
group by date (sale_date)
order by date (sale_date) asc;

#mencari total revenue per tanggal
SELECT product_name,
       date(sale_date) AS sale_date,
       SUM(revenue) AS total_revenue
FROM sales_data
GROUP BY product_name, sale_date;

#mencari ARPU
WITH monthly_revenue AS (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT sale_id) AS total_users
  FROM sales_data
  GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
)

SELECT
  year,
  month,
  total_revenue / total_users AS arpu
FROM monthly_revenue
ORDER BY year, month;

#Mencari MAU dan DAU
WITH daily_active_users AS (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS 'year',
    EXTRACT(MONTH FROM sale_date) AS 'month',
    EXTRACT(DAY FROM sale_date) AS 'day',
    COUNT(DISTINCT sale_id) AS active_users
  FROM sales_data
  GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date), EXTRACT(DAY FROM sale_date)
),
monthly_active_users AS (
  SELECT
    EXTRACT(YEAR FROM sale_date) AS 'year',
    EXTRACT(MONTH FROM sale_date) AS 'month',
    COUNT(DISTINCT sale_id) AS monthly_active_users
  FROM sales_data
  GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
)

SELECT
  daily_active_users.year,
  daily_active_users.month,
  active_users,
  monthly_active_users
FROM daily_active_users
INNER JOIN monthly_active_users ON daily_active_users.year = monthly_active_users.year AND daily_active_users.month = monthly_active_users.month 
ORDER BY daily_active_users.year, daily_active_users.month, daily_active_users.day;


select *
from sales_data;

