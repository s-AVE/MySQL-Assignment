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

**AGGREGATE vs WINDOW FUNCTIONS**.
How are window functions different than a GROUP BY?
- Aggregate functions collapse the rows in each group and apply a calculation.
- Window functions leave the rows as they are and apply calculations by window.
