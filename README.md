# Maven Analystic: MySQL Assignment

![](header.png)


## 1. **Multi-table Analysis**
There are two ways to combine multiple tables into a single table for analysis:
a. **JOIN** add related columns from one table to another, based on common columns.
b. **UNION** stacks the rows from multiple tables with the same column structure.

Use **JOIN** to combine two tables based on common values in a column(s)
- The tables must have at least one column with matching values
- Basic JOIN options include INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL OUTER JOIN.

Use a **UNION** to **stack multiple tables** or queries on top of one another
- **UNION removes duplicate values**, while **UNION ALL retains them**

**TIP:**
If you know there are no duplicate values in the two tables you're combining a UNION ALL will run much faster than a UNION.

**ASSIGNMENT: Multi-table Analysis**

1. We've learned that there is a discrepancy between our orders and products tables in the candy database. Could you use your JOIN knowledge to figure out which product exist in one table, but no the other?
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec4.assignment1_query.png) | ![](/assets/sec4.assignment1_output.png) |

2. Our marketing team wants to do some analysis to identify which our products are similar in terms of price. Could you write a query to determine which products are within 25 cents of each other in terms of unit price and return a list of all the candy pairs.
     | MySQL Query | Result |
     |----------|----------|
     | ![](/assets/sec4.assignment2_query.png) | ![](/assets/sec4.assignment2_output.png) |
