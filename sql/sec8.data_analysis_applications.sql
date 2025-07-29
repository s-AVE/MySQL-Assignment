-- ASSIGNMENT: Duplicate Values
/*
We've learned that there's a student who's showing up multiple times in our student records.
Can you generate a report of the students and their emails, and exclude the duplicate student record?
 */

WITH std AS (    
	SELECT
		id
		,student_name
		,grade_level
		,gpa
		,birthday
		,email
		,RANK() OVER(PARTITION BY student_name ORDER BY id DESC) AS rw_num
	FROM
		students
	)

SELECT
	id
	,student_name
	,email
FROM
	std
WHERE
	rw_num = 1;


-- ASSIGNMENT: Min/Max Value Filtering
/*
Can you create a report of each student with their highest grade for the semester, as well as which class it was in?
*/

WITH std_gr AS (    
	SELECT
		sg.student_id
	        ,std.student_name
 	       ,sg.department
		,sg.class_name
		,sg.final_grade
        	,DENSE_RANK() OVER (PARTITION BY sg.student_id ORDER BY sg.final_grade DESC) AS num
	FROM
		student_grades AS sg
	LEFT JOIN
		students AS std
	ON
		sg.student_id = std.id
	)

SELECT
	student_id
	,student_name
	,final_grade AS top_grade
	,class_name
FROM
	std_gr
WHERE
	num = 1;




-- ASSIGNMENT: Pivoting
/*
Can you help us create a summary table that shows the average grade for each department and grade level?
*/

WITH st_gr AS (
	SELECT
		std.id
		,std.student_name
		,std.grade_level
		,sg.department
		,sg.class_name
		,sg.final_grade
	FROM
		students AS std
	LEFT JOIN
		student_grades AS sg
	ON
		std.id = sg.student_id
	)

SELECT
	department
	,ROUND(AVG(
		CASE WHEN grade_level = 9 THEN final_grade END
		)) AS freshman
	,ROUND(AVG(
		CASE WHEN grade_level = 10 THEN final_grade END
		)) AS junior
	,ROUND(AVG(
		CASE WHEN grade_level = 11 THEN final_grade END
		)) AS sophomore
	,ROUND(AVG(
		CASE WHEN grade_level = 12 THEN final_grade END
		)) AS senior
FROM
	st_gr
WHERE
	department IS NOT NULL
GROUP BY
	department
ORDER BY
	department ASC;



-- ASSIGNMENT: Rolling Calculation
/*
Can you help us generate a report that shows the total sales for each month, 
as well as the cumulative sum of sales and the six-month moving average of sales??
*/

WITH sales AS (
	SELECT
		MONTH(order_date) AS mnth
		,YEAR(order_date) AS yr
		,SUM(ord.units * pd.unit_price) AS sale
	FROM
		orders AS ord
	LEFT JOIN
		products AS pd
		ON ord.product_id = pd.product_id
	GROUP BY
		YEAR(order_date)
		,MONTH(order_date)
	ORDER BY
		YEAR(order_date)
		,MONTH(order_date)
	)
SELECT
	*
	,SUM(sale) OVER(ORDER BY yr, mnth ) AS cumulative_sum
	,ROUND(AVG(sale) OVER(ORDER BY yr, mnth 
		ROWS BETWEEN 5 PRECEDING AND CURRENT ROW),2) 
		AS six_month_ma
FROM
	sales;

-- IMPUTING NULL Values
SELECT
	dt
	,price
	,COALESCE(price, 600) AS updated_price_600
	,COALESCE(price, ROUND((SELECT AVG(price) FROM sp),2)) AS updated_price_avg
	,COALESCE(price, LAG(price) OVER()) AS updated_price_prior
	,COALESCE(price, ROUND((LAG(price OAVER() + LEAD(price) OVER())/2), 2)) AS updated_price_smooth
FROM 
	sp;
