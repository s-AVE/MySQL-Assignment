-- ASSIGNMENT: Numeric Functions
/*
Our market research team is interested in seeing how many customers have spent $0 - $10 on our products,
$10 - $20, and so on for every $10 range. Could you generate this table for them?
*/
WITH sales AS (
	SELECT
		ord.customer_id
		,SUM(ord.units * pd.unit_price) AS total_spend
        ,FLOOR(SUM(ord.units * pd.unit_price)/10) *10 AS total_spend_bin
	FROM
		orders AS ord
	LEFT JOIN
		products AS pd
	ON
		ord.product_id = pd.product_id
	GROUP BY
		ord.customer_id
	)

SELECT
	total_spend_bin
    ,COUNT(total_spend_bin) AS num_cust
FROM
	sales
GROUP BY
	total_spend_bin
ORDER BY
	total_spend_bin;


-- ASSIGNMENT: Datetime Functions
/*
The market research team wants to do a deep dive on the Q2 2024 orders data we currently have.
Can you pull that data for them?
In addition, they also requested that we include a ship_date column for them that's 2 days after the order_date.
*/

SELECT
	*
    ,DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_date
FROM
	orders
WHERE
	MONTH(order_date) BETWEEN 4 AND 6;


-- ASSIGNMENT: String Functions
/*
We're updating our product_id's to include the factory name and product name. 
Could you write the SQL code to produce this?
*/

SELECT
	factory
    ,product_id
    ,REPLACE(
		REPLACE(
			CONCAT(factory, '-', product_id), 
		' ', '-'), 
	"'", "") AS factory_product_id
FROM
	products
ORDER BY
	factory;

-- SIMPLE QUERY
SELECT
	product_name
    ,CASE
		WHEN INSTR(product_name, '-') = 0 THEN product_name
        ELSE SUBSTR(product_name, INSTR(product_name, '-') +2)
        END AS new_product_name
FROM
	products;
    

-- ASSIGNMENT: Pattern Matching
/*
The marketing team has kicked off an initiative to simplify our product names, 
starting with our Wonka Bars products.
Could you remove "Wonka Bar" from any products that contain the term?
*/
-- To use all pattern matching in COURSE
SELECT
	product_name
    ,CASE
		WHEN INSTR(product_name, '-') = 0 THEN product_name
        ELSE TRIM(
            REPLACE(
                SUBSTR(product_name, INSTR(product_name, '-')), 
            '-', '')
        )
        END AS new_product_name
FROM
	products;
    
-- SIMPLE QUERY --
SELECT
	product_name
    ,CASE
		WHEN INSTR(product_name, '-') = 0 THEN product_name
        ELSE SUBSTR(product_name, INSTR(product_name, '-') +2)
        END AS new_product_name
FROM
	products;



-- ASSIGNMENT: NULL FUNCTIONS
/*
Sugar Shack and The Other Factory just added two new products that don't have divisions assigned to them.
For simplicity's sake, could you update those NULL values to have a value of "Other"?
Here's an extra challenge for you - instead of updating them to "Other", 
could you update them to be the same division as the most common division within their respective factories
*/

WITH div_not_null AS (
	SELECT
		factory
		,division
		,COUNT(division) AS num_product
	FROM
		products
	WHERE
		division IS NOT NULL
	GROUP BY
		factory
		,division
	)
	,num_div AS (
    SELECT
		factory
		,division
		,num_product
        ,ROW_NUMBER() OVER(PARTITION BY factory ORDER BY num_product DESC) 
			AS num_product_rank
	FROM
		div_not_null
	WHERE
		division IS NOT NULL
	GROUP BY
		factory
		,division
    )
	,top_division_fac AS (
	SELECT
		factory
		,division
	FROM
		num_div
	WHERE
		num_product_rank = 1
    )

SELECT
	pd.product_name
    ,pd.factory
    ,pd.division
    ,COALESCE(pd.division, 'Other') AS division_other
    ,tdf.division AS dvision_top
    ,COALESCE(pd.division, tdf.division) AS new_division
FROM
	products AS pd
LEFT JOIN
	top_division_fac AS tdf
ON
	pd.factory = tdf.factory
ORDER BY
    pd.factory;
