-- ASSIGNMENT: Window Function Basics
/*
We currently have an orders report with customer, order and transaction IDs,
and we would like to add an additional column that contains 
the transaction number of each customer as well.
Could you help us do this using window functions?
*/
SELECT
	customer_id
    ,order_id
    ,transaction_id
    ,order_id
    ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS num_trans_by_cust
FROM
	orders
ORDER BY
	customer_id;


-- ASSIGNMENT: Row Numbering
/*
Our product team would like to know which products are most popular within each day.
Could you create a product rank field that returns a 1 for the most popular product in an order, 
2 for second most, and so on? Please take a look at the results preview to get an idea of 
what they'd like the ranking to look like.
*/

WITH sales AS (
	SELECT 
		ord.order_date
        ,ord.order_id
        ,ord.product_id
		,pd.product_name
		,ord.units
	FROM
		orders AS ord
	LEFT JOIN
		products AS pd
	ON
		ord.product_id = pd.product_id
	)

SELECT 
	order_date
    ,product_name
    ,units
    ,DENSE_RANK() OVER(PARTITION BY order_date ORDER BY units DESC) AS rank_sale
FROM 
	sales
ORDER BY
	order_date
    ,rank_sale;

-- PRODUCT RANKING in SALE
WITH sales AS (    
	SELECT 
		ord.product_id
        ,pd.product_name
		,SUM(units) as unit_sale
	FROM 
		orders AS ord
	LEFT JOIN
		products AS pd
	ON 
		ord.product_id = pd.product_id
	GROUP BY
		product_id
	)

SELECT 
	product_id
    ,product_name
    ,unit_sale
    ,RANK() OVER(ORDER BY unit_sale DESC) AS rank_sale
FROM
	sales;


-- ASSIGNMENT: Value within a Window
/*
Could you specifically give me a list of the 2nd most popular product within each order?
The sales team is going to try to see if they can bundle them with some other products to 
increase units sold within each order
*/
WITH sales AS (
	SELECT
		ord.order_id
		,ord.product_id
		,pd.product_name
		,ord.units
        ,DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS ranking
	FROM
		orders AS ord
	LEFT JOIN
		products AS pd
	ON
		ord.product_id = pd.product_id
    )
    
SELECT 
	order_id
    ,product_id
    ,product_name
    ,units
    -- ,ranking
FROM 
	sales
WHERE
	ranking = 2;


-- ASSIGNMENT: Value Relative to a Row
/*
We'd like to look into how orders have changed over time for each customer.
Could you produce a table that contains info about each customer and their orders, 
the number of units in each order, and the change in units from order to order?
*/


WITH prior_units_buying AS (
		SELECT
		customer_id
		,order_date
		,sum(units) AS total_units
		,LAG(sum(units)) OVER(PARTITION BY customer_id ORDER BY order_date) AS prior_units
	FROM 
		orders
	GROUP BY
		customer_id
		,order_date
	)
    
SELECT 
	customer_id
	,order_date
	,total_units
    ,prior_units
    ,total_units - prior_units AS buying_change
FROM
	prior_units_buying;


-- ASSIGNMENT: Statistical Functions
/*
The customer engagement team would like to create a rewards program for our top 1% of customers.
Could you pull a list of the top 1% of customers in terms of how much they've spent with us?
*/
WITH cte_table AS (
	SELECT 
		ord.customer_id
		,SUM(ord.units * pd.unit_price) AS spending
	FROM
		orders AS ord
	LEFT JOIN
		products AS pd
	ON 
		ord.product_id = pd.product_id
	GROUP BY
		ord.customer_id
	ORDER BY
		spending
	)
	
    ,cte_table2 AS (    
	SELECT 
		*
		,NTILE(100) OVER(ORDER BY spending DESC) AS top_cust
	FROM
		cte_table
	)

SELECT
	customer_id
    ,spending
FROM
	cte_table2
WHERE
	top_cust = 1;

-- PREVIEW: Moving Average
SELECT
	country
    ,year
    ,happiness_score
    ,AVG(happiness_score) OVER(PARTITION BY country ORDER BY year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_year_ma
FROM
	happiness_scores;