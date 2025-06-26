-- ASSIGNMENT: Subqueries in the SELECT Clause
/*
Our product team plans on evaluating our product prices later this week 
to see if any adjustments need to be made for nest year.
can you give me a list of our products from most to least expensive, 
along with how much each product differs from the average unit price?
*/
SELECT 
    product_id
    ,product_name,
    unit_price
    ,(
        SELECT 
            ROUND(AVG(unit_price),2)
        FROM 
            products
        ) AS avg_price
	,ROUND(unit_price - (
            SELECT 
                AVG(unit_price) 
            FROM 
                products
	),2) AS different_price
FROM
	products
ORDER BY
	unit_price DESC;


-- ASSIGNMENT: Subqueries in the FROM Clause
/*
Our inventory management team would like to review 
the products produced by each factory.
Can you give me a list of our factories, along with the names of 
the products they produce and the number of products they produce?
*/

SELECT 
	pd.factory
	,pd.product_name
    ,num_product.num_product
FROM 
	products AS pd
LEFT JOIN (
    SELECT 
	factory 
	,COUNT(product_name) AS num_product
    FROM 
	products
    GROUP BY 
        factory
    ) AS num_product
ON pd.factory = num_product.factory
ORDER BY 
    pd.factory
    ,pd.product_name;

-- ASSIGNMENT: Subqueries in the WHERE Clause
/*
Our Wicked Choccy's factory has some extra badwidth and 
we'd like to see if there are any lower priced products that 
they can help produce going forward.
Can you help us identify products that have a unit price less than 
the unit price of all products from Wicked Choccy's? 
Please include which factory is currently producing them as well.
*/

SELECT *
FROM 
    products AS pd
WHERE 
    unit_price < ALL(
	SELECT 
		unit_price
        FROM
		products
    	WHERE
		factory = "Wicked Choccy's"
        )
ORDER BY 
    pd.unit_price;

-- ASSIGNMENT: CTEs
/*
The sales director wants a list of our biggest orders. 
In addition to sending over a list of all the orders over $200, 
could you also tell him the number of orders over $200?
*/
WITH sales AS (
    SELECT
		ord.order_id
		,ord.product_id
		,pd.product_name
		,ord.units
		,pd.unit_price
		,units * unit_price AS sale
    FROM 
	orders AS ord
    LEFT JOIN (
		SELECT *
		FROM
			products
		) AS pd
    ON
	ord.product_id = pd.product_id
    )
    
SELECT 
	order_id 
	,SUM(sale) AS spending
FROM 
	sales
GROUP BY 
	order_id
HAVING 
	spending > 200
ORDER BY 
	spending DESC;


-- ASSIGNMENT: Multiple CTEs
/*
Our inventory management team would like to review the products produced by each factory. 
Can you give me a list of our factories, along with the name of 
the products they produce and the number of products they produce?
*/

WITH pd AS (
	SELECT *
	FROM
		products
	)
    ,num_of_product AS (
	SELECT 
		factory
		,count(product_name) AS num_pro
	FROM
		products
	GROUP BY
		factory
	)

SELECT
    pd.factory
    ,pd.product_name
    ,num_of_product.num_pro
FROM 
    pd
LEFT JOIN
    num_of_product
ON
    pd.factory = num_of_product.factory
ORDER BY
    pd.factory;
