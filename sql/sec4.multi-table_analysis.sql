-- ASSIGNMENT: BASIC JOINS
/*
We've learned that there is a discrepancy between our orders 
and products tables in the candy database.
Could you use your JOIN knowledge to figure out which 
product exist in one table, but no the other?
*/
SELECT
	pd.product_id
	,pd.product_name
 	,ord.product_id
FROM
	products AS pd
LEFT JOIN 
	orders AS ord
ON
	pd.product_id = ord.product_id
WHERE
	ord.product_id IS NULL;


-- ASSIGNMENT: SELFT JOINS
/*
Our marketing team wants to do some analysis to identify 
which our products are similar in terms of price.
Could you write a query to determine which products are 
within 25 cents of each other in terms of unit price
and return a list of all the candy pairs.
*/
SELECT
	pd1.product_name
	,pd1.unit_price
	,pd2.product_name
	,pd2.unit_price
	,(pd1.unit_price - pd2.unit_price) AS price_diff
FROM
	products AS pd1
CROSS JOIN
	products AS pd2
WHERE
	ABS(pd1.unit_price - pd2.unit_price) < 0.25
    -- (pd1.unit_price - pd2.unit_price) BETWEEN -0.25 AND 0.25
    AND
	pd1.product_id <> pd2.product_id -- is not equal
ORDER BY
	price_diff DESC;
