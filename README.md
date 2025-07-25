# Maven Analystic: MySQL Assignment

![](header.png)


## 1. **Multi-table Analysis**
There are two ways to combine multiple tables into a single table for analysis:
- **JOIN** add related columns from one table to another, based on common columns.
- **UNION** stacks the rows from multiple tables with the same column structure.


Use **JOIN** to combine two tables based on common values in a column(s)
- The tables must have at least one column with matching values
- Basic JOIN options include INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL OUTER JOIN.

Use a **UNION** to **stack multiple tables** or queries on top of one another
- **UNION removes duplicate values**, while **UNION ALL retains them**

**TIP:**
If you know there are no duplicate values in the two tables you're combining a UNION ALL will run much faster than a UNION.

<h3>ASSIGNMENT: Multi-table Analysis</h3>

1. We've learned that there is a discrepancy between our orders and products tables in the candy database. Could you use your JOIN knowledge to figure out which product exist in one table, but no the other?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec4.assignment1_query.png) | ![](/assets/sec4.assignment1_output.png) |

2. Our marketing team wants to do some analysis to identify which our products are similar in terms of price. Could you write a query to determine which products are within 25 cents of each other in terms of unit price and return a list of all the candy pairs.
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec4.assignment2_query.png) | ![](/assets/sec4.assignment2_output.png) |

## 2. **SUBQUERY and CTEs**
A **Subquery** is **a query nested** within a main query and is typically used for solving a problem in multiple steps.
Subqueries can occur in **multiple places** within a query:
- calculation in the **SELECT** clause,
- As part of a **JOIN** in the **FROM** clause,
- Filtering in the **WHERE** and **HAVING** clauses.

Queries can contain multiple subqueries as long as each one has a different alias ("**AS**").
Keywords like **ANY**, **ALL**, and **EXISTS** can provide more specific filtering logic.
- ANY (**at least one** value in the list);
- ALL (**every** value in the list);
- EXISTS (correlated subqueries can be rewritten as **INNER JOINs to run faster**).

**TIPS:**
- Interpreting nested subqueries can be overwhelming, so start from the inner subqueries and work your way out or use CTE instead.
- Using subqueries within the JOIN clause is great for **speeding up queries**, since it allows you to join smaller tables.

A **Common Table Expression (CTE)** creates a named, temporary output that can be referenced within another query.
CTE need to start with the "**WITH**" keyword, followed by **the alias** the "**AS**" keyword, and the query between **parentheses**
WHY USE CTE instead SUBQUERIES:
1. Readability: Complex queries with CTE's are much easier to read.
2. Reusability: CTE's can be referenced multiple times within a query
3. Recursiveness: CTE's can handle recursive queries

Unlike subqueries, CTE's can be referenced multiple times within a query which helps avoid repeating code.

Despite all this, you shouldn't forget about subqueries:
- Most modern RDBMS support CTE, but not all of them do.
- For simple subqueries, sometimes a subquery is readable enough and works just fine.

You can use **multiple CTEs in a query** and even combine them with subqueries. You can using multiple CTEs by using **a single "WITH"** keyword to create two CTEs and they are spearated by a "**COMMA (,)**".

<h3>ASSIGNMENT: Subqueries and CTEs</h3>

1. ASSIGNMENT: Subqueries in the **SELECT** Clause
- Our product team plans on evaluating our product prices later this week to see if any adjustments need to be made for nest year.
Can you give me a list of our products from most to least expensive, along with how much each product differs from the average unit price?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec5.assignment1_query.png) | ![](/assets/sec5.assignment1_output.png) |

2. ASSIGNMENT: Subqueries in the **FROM** Clause
- Our inventory management team would like to review the products produced by each factory.
Can you give me a list of our factories, along with the names of the products they produce and the number of products they produce?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec5.assignment2_query.png) | ![](/assets/sec5.assignment2_output.png) |

3. ASSIGNMENT: Subqueries in the **WHERE** Clause
- Our Wicked Choccy's factory has some extra badwidth and we'd like to see if there are any lower priced products that they can help produce going forward.
Can you help us identify products that have a unit price less than the unit price of all products from Wicked Choccy's? Please include which factory is currently producing them as well.
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec5.assignment3_query.png) | ![](/assets/sec5.assignment3_output.png) |

4. ASSIGNMENT: **CTES**
- The sales director wants a list of our biggest orders. In addition to sending over a list of all the orders over $200, could you also tell him the number of orders over $200?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec5.assignment4_query.png) | ![](/assets/sec5.assignment4_output.png) |

5. ASSIGNMENT: **Multiple CTES**
- Our inventory management team would like to review the products produced by each factory. Can you give me a list of our factories, along with the name of the products they produce and the number of products they produce?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec5.assignment5_query.png) | ![](/assets/sec5.assignment5_output.png) |


## 3. **Window Functions**
Window functions are used to apply a function to a "window" of data
- Windows are essentially groups of rows of data
- Aggregate functions collapse the rows in each group, but window functions leave the rows untouched.

**AGGREGATE vs WINDOW FUNCTIONS**.
How are window functions different than a GROUP BY?
- Aggregate functions collapse the rows in each group and apply a calculation.
- Window functions leave the rows as they are and apply calculations by window.

The general syntax is function OVER(PARTITION BY columnX ORDER BY columnY)
- OVER indicates that we're writing a window function
- PARTITION BY states how we'd like to split up the rows into groups
- ORDER BY states how the rows within each window should be ordered before applying the function

The function portion of a window function in applied to each window
- You can number rows with ROW_NUMBER(), RANK(), and DENSE_RANK()
- You can identify values within a window with FIRST_VALUE(), LAST_VALUE(), and NTH_VALUE()
- You can returns values from relative rows with LEAD() and LAG()
- You can use statistical functions like NTILE() for making percentile calculations
- You can use aggregate functions like AVG() for making moving average calculations

<h3>ASSIGNMENT: Window Functions</h3>

1. ASSIGNMENT: **Window Function Basics**
- We currently have an orders report with customer, order and transaction IDs, and we would like to add an additional column that contains the transaction number of each customer as well. Could you help us do this using window functions?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec6.assignment1_query.png) | ![](/assets/sec6.assignment1_output.png) |

2. ASSIGNMENT: **Row Numbering**
- Our product team would like to know which products are most popular within each day. Could you create a product rank field that returns a 1 for the most popular product in an order, 2 for second most, and so on? Please take a look at the results preview to get an idea of what they'd like the ranking to look like.
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec6.assignment2_query.png) | ![](/assets/sec6.assignment2_output.png) |

3. ASSIGNMENT: **Value within a Window**
- Could you specifically give me a list of the 2nd most popular product within each order? The sales team is going to try to see if they can bundle them with some other products to increase units sold within each order
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec6.assignment3_query.png) | ![](/assets/sec6.assignment3_output.png) |

4. ASSIGNMENT: **Value Relative to a Row**
- We'd like to look into how orders have changed over time for each customer. Could you produce a table that contains info about each customer and their orders, the number of units in each order, and the change in units from order to order?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec6.assignment4_query.png) | ![](/assets/sec6.assignment4_output.png) |

5. ASSIGNMENT: **Value Relative to a Row**
- The customer engagement team would like to create a rewards program for our top 1% of customers. Could you pull a list of the top 1% of customers in terms of how much they've spent with us?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec6.assignment5_query.png) | ![](/assets/sec6.assignment5_output.png) |

6. ASSIGNMENT: **Moving Average** **[PREVIEW]**
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec6.assignment6_query.png) | ![](/assets/sec6.assignment6_output.png) |

## 4. **Functions by Data Type**
A function applies a calculation or transformation to rows of data
- An aggregate function applies a calculation to all rows an returns a single value (COUNT, SUM, etc.)
- A window function performs a calculation across a window of rows (OVER(), PARTITION BY, etc.)
- A general function performs a calculation or transformation on all rows
Specific functions can be applied to specific data types
- If needed, you can CAST or CONVERT a field into a different data type to apply a particular function
- Common numeric functions include LOG(), ROUND(), etc.
- Common datetime functions include YEAR(), DATEDIFF(), etc.
- Common string functions include TRIM(), REPLACE(), REGEXP(), etc.
- Common NULL functions include IFNULL(), COALESCE(), etc.

1. ASSIGNMENT: **Numeric Functions**
- Our market research team is interested in seeing how many customers have spent $0 - $10 on our products, $10 - $20, and so on for every $10 range. Could you generate this table for them?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec7.assignment1_query.png) | ![](/assets/sec7.assignment1_output.png) |
  
2. ASSIGNMENT: **Datetime Functions**
- The market research team wants to do a deep dive on the Q2 2024 orders data we currently have. Can you pull that data for them? In addition, they also requested that we include a ship_date column for them that's 2 days after the order_date.
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec7.assignment2_query.png) | ![](/assets/sec7.assignment2_output.png) |

3. ASSIGNMENT: **String Functions**
- We're updating our product_id's to include the factory name and product name. Could you write the SQL code to produce this?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec7.assignment3_query.png) | ![](/assets/sec7.assignment3_output.png) |

4. ASSIGNMENT: **String Functions**
- The marketing team has kicked off an initiative to simplify our product names, starting with our Wonka Bars products. Could you remove "Wonka Bar" from any products that contain the term?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec7.assignment4_query.png) | ![](/assets/sec7.assignment4_output.png) |

5. ASSIGNMENT: **NULL FUNCTIONS**
- Sugar Shack and The Other Factory just added two new products that don't have divisions assigned to them. For simplicity's sake, could you update those NULL values to have a value of "Other"? Here's an extra challenge for you - instead of updating them to "Other",  could you update them to be the same division as the most common division within their respective factories
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec7.assignment5_query.png) | ![](/assets/sec7.assignment5_output.png) |
