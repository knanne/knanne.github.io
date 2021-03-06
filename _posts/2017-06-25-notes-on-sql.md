---
categories: [programming]
tags: [sql, mysql, postgresql, oracle]
---

Helpful SQL tips and commands  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Notes

I have interacted frequently with MySQL, PostgreSQL, and Oracle. However, they all have a few slight differences which can make switching back and forth a frustrating hassle. Most significantly when grouping, or using built-in named functions. Also, there are plenty of analytic features included in Oracle and PostgreSQL which are not included in MySQL (until release of 8.0).  

Some simple differences include:
  - Despite MySQL allowing most naive group by behavior, PostgreSQL and Oracle SQL will both complain if you do not explicitly list all non-aggregate columns in the group by clause (unless you include a table's unique identifier). However, this is good practice anyway.  
  - Limiting rows in MySQL is easy as `limit 10` while in Oracle you can do `WHERE ROWNUM <= 10`.  
  - You are allowed to use `#comment` for comment blocks in MySQL, however in PostgreSQL `--comment--` is recommended. Although, in all languages, the standard of `/*comment*/` always works.  
  - MySQL handles strings with single quotes (`' '`) or double (`" "`), and reserved words like table names and columns with backticks (`` ` ` ``). However, PostgreSQL and Oracle use double quotes for reserved words, single quotes for strings and no backticks.
  - To get the current date in MySQL use `CURDATE()`, PostgreSQL use `CURRENT_DATE`, in Oracle use `SYSDATE`  

# Use Cases

## Ranking Within Groups

### MySQL

```sql
SELECT tmp1.* FROM
(
  SELECT
    tmp.*,
    @num := IF(@grp = tmp.`group_col`, @num + 1, 1) AS "rank",
    @grp := tmp.`group_col` AS "dummy"
  FROM
  (
    SELECT `group_col`, SUM(`values_col`) AS "values_col"
		FROM schema.table
    GROUP BY `group_col`
		ORDER BY `group_col` ASC, SUM(`values_col`) DESC
  ) tmp
    ORDER BY `dummy` ASC, `rank` ASC
) tmp1
WHERE `rank` <= 10
;
```

### Oracle

```sql
SELECT tmp1.* FROM
(
  SELECT
    tmp.*,
    RANK() OVER (PARTITION BY "group_col" ORDER BY "values_col" DESC) "rank"
  FROM
  (
    SELECT "group_col", SUM("values_col") AS "values_col"
		FROM schema.table
		GROUP BY "group_col"
		ORDER BY "group_col" ASC, SUM("values_col") DESC
  ) tmp
  ORDER BY "dummy" ASC, "rank" ASC
) tmp1
WHERE "rank" <= 10
;
```

## Pivot

If you need to unstack a categorical column into multiple columns for reporting, the following technique can easily be applied in general SQL. However, you do need to hardcode your values, and it may have efficiency limitations. The below snippet is universal SQL.  

```sql
SELECT
  `group_col`,
  SUM(CASE `category_col` WHEN 'Category1' THEN 1 ELSE 0 END) "Category1",
  SUM(CASE `category_col` WHEN 'Category2' THEN 1 ELSE 0 END) "Category2",
  SUM(CASE `category_col` WHEN 'Category2' THEN 1 ELSE 0 END) "Category3"
FROM schema.table
GROUP BY `group_col`
;
```

If you need to achieve the opposite, by stacking multiple columns into a single column, you can either utilize `UNION` with multiple 'SELECT' statements, or `COALESCE` to combine only the first non-NULL value.  

## HAVING For Efficiency

The SQL command called `HAVING` is similar to `WHERE` although applies the filter on rows after the `SELECT` has taken place instead of before. `HAVING` therefore allows to filter on aggregated metrics directly in the same `SELECT` statement doing the aggregation. This prevents the need to wrap the statement in another `SELECT` statement using `WHERE`, therefore saving code space. For example:  

```sql
SELECT * FROM
(
  SELECT
    `group`,
    COUNT(DISTINCT(`id`)) AS "count"
  FROM schema.table
  GROUP BY `group`
)
WHERE "count" > 10
;
```

Is the same as simply doing:  

```sql
SELECT
  `group`,
  COUNT(DISTINCT(`id`)) "count"
FROM schema.table
GROUP BY `group`
HAVING COUNT(DISTINCT(`id`)) > 10
;
```

## WITH Query Integrity

Commonly in query data for reporting, you may need to join multiple queries containing optional data for some similar base ids, and you want to ensure you report on ALL base ids. Or you simulate this with some fancy FULL OUTER JOINs, or simply use the `WITH` expression.  

For example, imagine a table of accounts and transactions to those accounts over time, which can either be debits or credits, and some various other attributes. You may want to report on statistics based of the rows of debits and credits differently. In this case, it's helpful to create a base table of the account ids, and all reporting periods (e.g. months), and then optionally join the metrics from either the separated debits query and credits query when applicable. Below is how to accomplish this in Oracle (or PostgreSQL).  

This functionality of Common Table Expressions (CTE) is included in [PostgreSQL](https://www.postgresql.org/docs/current/static/queries-with.html), and will be included in [MySQL 8.0](https://dev.mysql.com/doc/refman/8.0/en/with.html)  

```sql
WITH base_table AS (
  SELECT DISTINCT(account_id) AS "account_id" FROM schema.transactions
  CROSS JOIN
  SELECT DISTINCT(reporting_month) AS "reporting_month" FROM schema.transactions
)
SELECT
  base_table.account_id,
  base_table.reporting_month,
  debit.debit_transactions,
  debit.debit_total,
  credit.credit_transactions,
  credit.credit_total
FROM base_table
LEFT JOIN (
  SELECT account_id, reporting_month, count(transaction_id) AS "debit_transactions", sum(amount) AS "debit_total"
  FROM schema.transactions
  WHERE type = 'Debit'
  GROUP BY account_id, reporting_month
) debit ON base_table.account_id = debit.base_id AND base_table.reporting_month = debit.reporting_month
LEFT JOIN (
  SELECT account_id, reporting_month, count(transaction_id) AS "credit_transactions", sum(amount) AS "credit_total"
  FROM schema.transactions
  WHERE type = 'Credit'
  GROUP BY account_id, reporting_month
) credit ON base_table.account_id = credit.base_id AND base_table.reporting_month = credit.reporting_month
ORDER BY base_table.transaction_id ASC, base_table.reporting_month ASC
;
```

## Window Functions

Window functions are great way to make complex calculations fairly simple. Oracle SQL groups these into the various [Analytical Functions](https://docs.oracle.com/cloud/latest/db112/SQLRF/functions004.htm).  

A practical example of valuable window functions would be difference calculation between rows. Imagine a scenario where you have a table of financial data, where each row contains a year, month, and total. And now you want to add a column as the difference in total from previous month, restarting each year. Below is an example of how to do this in Oracle SQL.

```sql
SELECT
  year,
  month,
  total,
  total - LAG(total) OVER (PARTITION BY year ORDER BY month)
FROM schema.table
;
```

Similarly you could utilize the same window concept to calculate a cumulative sum for each year, restarting each year.  

```sql
SELECT
  year,
  month,
  total,
  SUM(total) OVER (PARTITION BY year ORDER BY month)
FROM schema.table
;
```

Similar functionality as Window Functions are included in [PostgreSQL](https://www.postgresql.org/docs/current/static/functions-window.html#FUNCTIONS-WINDOW-TABLE), and will be included in [MySQL 8.0](https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html)  

## CASE Statement in WHERE Clause

It may be desirable to add some more complexity to a `WHERE` clause, which can be done with a `CASE` statement. However, it is best to organize the logic in a way that is most interpretable, by isolating the CASE statement and checking if it evaluates to TRUE (or 1 in SQL).  

```sql
SELECT
    `col1`,
    `col2`,
    `col3`
FROM schema.table
WHERE
    (CASE
        WHEN `col1` = 'value1' AND `col2` = `col3` THEN 1 --RANDOM LOGIC TO EVALUATE TO TRUE
        WHEN `col3` IN ('value2','value3','value4') THEN 1 --RANDOM LOGIC TO EVALUATE TO TRUE
        ELSE 0 -- FALSE
    END) = 1 -- COMPARE AGAINST TRUE
```

## Selecting and Removing Duplicates

Select the duplicated IDs in an example table.  

```sql
SELECT *
FROM schema.table
GROUP BY `id`
HAVING COUNT(*) > 1
```

Delete records for duplicated ids, and keep the most recent updated record.  

```sql
DELETE schema.table
FROM schema.table
JOIN
(
    SELECT
        MAX(`last_updated`) AS "max_last_updated",
        `id` AS "duplicated_id"
    FROM schema.table
    GROUP BY `id`
    HAVING COUNT(*) > 1
) duplicates ON id = duplicated_id
WHERE last_updated < duplicates.max_last_updated
```

## Generate List of Months

Commonly it is good practice to join data onto some base or anchor table for reporting so that all reporting combinations are first show, even if they do not have some attributes or metrics. Use the below sample code to generate a list of months in the last 5 years. This is in MySQL, it is much easier in PostgreSQL or Oracle to use a `CROSS JOIN` instead.  

```sql
SELECT
    STR_TO_DATE(DATE_FORMAT(CURDATE(), '%Y-%m-01'), '%Y-%m-%d') - INTERVAL series.number MONTH) AS "datemonth"
FROM
    (
        SELECT
            @i := @i + 1 AS `number`
        FROM
        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) AS years,
        (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12) AS months,
        (SELECT @i:=0) as t_init
    ) AS series
HAVING YEAR(`datemonth`) >= YEAR(CURDATE()) - 5
```

## Efficient Date Filtering

Indexes or keys are necessary in SQL to return results most efficiently. When you have an indexed date column, use the column itself when filtering instead of extracting and comparing parts of it which are not indexed, like `YEAR` for example.  

For reporting, it's likely you want to include full years of some time period, up to current YTD. Here is how to return records within the last 5 years, from year start.  

### MySQL

```sql
SELECT * FROM table.schema WHERE date_col >= DATE_SUB(MAKEDATE(YEAR(CURDATE()),1), INTERVAL 5 YEAR);
```

### Oracle

```sql
SELECT * FROM table.schema WHERE date_col >= TRUNC(ADD_MONTHS(CURRENT_DATE, -5*12), 'YEAR');
```

Or simply get the year part from a date using `YEAR(CURDATE())` in MySQL, or `EXTRACT(YEAR FROM CURRENT_DATE)` in PostgreSQL, `TO_CHAR(SYSDATE, 'YYYY')` in Oracle.  

Relevant date functions docs for each are here:
  - https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html
  - https://www.postgresql.org/docs/8.0/static/functions-datetime.html
  - https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions001.htm

# ETL Jobs

## Migrate Development to Production

Below is a simply example of migration one table from a single schema to another. This is a useful practice in data engineering if you have a staging or development environment (e.g. data access layer (DAL) or user access testing (UAT)) and a different production schema.  

This procedure will work on transaction safe tables (e.g. INNODB). You can alternatively specify `SET AUTOCOMMIT=0` to disable autocommiting for current transaction.  

```sql
-- assuming development table is ready for migration
BEGIN;
DROP TABLE IF EXISTS prd_schema.table_name;
CREATE TABLE prd_schema.table_name LIKE dev_schema.table_name;
INSERT INTO prd_schema.table_name SELECT * FROM dev_schema.table_name;
-- do any last minute quality checks here
-- update your ETL audit information here (e.g. last modified date, row counts, type conversions, null counts etc.)
COMMIT; -- or ROLLBACK if the job did not pass your tests
```

## Maintain Database on Unique Text Column

If you have database where the required key is in fact a text column (or you need unique key of multiple columns beyond the maximum limit), the "key" is to convert the unique text into a hash value and then index on that. You can do this simply with the `MD5()` function. In MySQL a full example of creating and updating such data would look like the following:   

```sql
CREATE TEMPORARY TABLE `schema`.`_tmp_data` (
    `column1` TEXT,
    `column2` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
;

LOAD DATA LOCAL INFILE 'datafile.txt'
INTO TABLE `schema`.`_tmp_data`
;

CREATE TABLE IF NOT EXISTS `schema`.`data` (
    `id` MEDIUMINT(9) NOT NULL AUTO_INCREMENT,
    `column1` TEXT,
    `column1_hash` CHAR(32),
    `column2` TEXT,
    PRIMARY KEY `id` (`id`),
    UNIQUE KEY `column1_hash` (column1_hash)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4
;

INSERT INTO `schema`.`data`
SELECT
    NULL,
    `column1`,
    MD5(`column1`),
    `column2`
FROM `schema`.`_tmp_data`
ON DUPLICATE KEY UPDATE
    # id is auto incremented
    column1 = VALUES(column1),
    # column1_hash is unique
    column2 = VALUES(column2)
;
```

The steps are first load the data into a temporary table, Create a temporary table with no keys.
2. Load data
3. Insert select into main database using md5

## MySQL Load Local Infile Dynamically

Consider you have a datafile that contains more than what you want in the database, and that this file is large enough that you do not want to read and preprocess it. Below is an extensive example on how to dynamically load a tab separated text file, mapping specific data columns into table columns. We also add an auto-increment id column, add a timestamp of the load as `created_at` and correct a boolean column during the load. As well the load statement specifies utf8 encoding (not default until MySQL 8), ignores the datafile header, and replaces duplicates on the primary key.  

Note that to read NULL values from a file correctly into a table in MySQL, the required value is `\N`. This is exemplified in the table below. This means in an ETL job you must impute your data correctly before loading the file into the database, for example in Python Pandas do `df.fillna('\\N')`.  

**Create table**  

```sql
CREATE TABLE IF NOT EXISTS schema.table
  `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `last_updated` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` VARCHAR(100) NOT NULL,
  `attribute1` MEDIUMINT(10) UNSINGED DEFAULT 0,
  `some_bool_col` BOOLEAN DEFAULT FALSE,
  `attribute2` VARCHAR(50) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  PRIMARY KEY (`title`),
  KEY `created_at` (`created_at`),
  KEY `some_bool_col` (`some_bool_col`),
  KEY `attribute1` (`attribute1`),
  KEY `attribute2` (`attribute2`)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
;
```

**Sample tab-separated datafile as `data.txt`**  

| col1         | col2 | col3     | col4 | col5           | col6 | col7                                                                           |
| ------------ | ---- | -------- | ---- | -------------- | ---- | ------------------------------------------------------------------------------ |
| Lorem Ipsum1 | \N | 82310    | true | Lorem ipsum    | \N | Omnis et maxime tenetur adipisci, aut commodi debitis                          |
| Lorem Ipsum2 | \N | 02163549 | false | dolor sit amet | \N | Sint laborum quisquam reiciendis delectus numquam est ea architecto            |
| Lorem Ipsum3 | \N | 97436134 | true | Lorem ipsum    | \N | Obcaecati illo tempora laborum porro odit quia et pariatur iste enim facilis   |
| Lorem Ipsum4 | \N | 00173462 | \N | dolor sit amet | \N | Fuga dignissimos quas est culpa temporibus incidunt voluptatem unde beatae sit |
| Lorem Ipsum5 | \N | 87413    | false | Lorem ipsum    | \N | libero dolorum pariatur fugit sit officia ducimus laborum                      |

**Load**  

```sql
LOAD DATA LOCAL INFILE 'C:/path/to/data.txt'
REPLACE INTO schema.table
CHARACTER SET utf8
FIELDS SEPARATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @col2, @col3, @col4, @col5, @col6, @col7)
SET id=NULL,
    created_at=NULL,
    last_updated=NULL,
    title=@col1,
    attribute1=@col3,
    some_bool_col=(@col4='true'),
    attribute2=@col5,
    description=@col7
;
```

## Modify Table Ignoring Foreign Keys

Sometimes you may need to modify a table in place, or recreate a table with foreign references, where you may wish to simply ignore these references for accomplishing some specific custom load statement. Normally this will throw an error.  

In MySQL you can `SET FOREIGN_KEY_CHECKS = 0;` and then proceed to drop or truncate, or insert with ignoring the parent/child references. This setting only applies to the current connection session, although you can set it back with `SET FOREIGN_KEY_CHECKS = 1;`.  

In Oracle, there is no such command, although you can use `CASCADE CONSTRAINTS` to simply remove the references on foreign tables when dropping a table to allow success.

## Convert Encoding

I almost always create a database using `CHARSET utf8mb4`, however, blindly setting this without checking your source files before loading can cause issues if you didn't realize they were in a different encoding before loading it in. For example take a file of global names, this will commonly be stored with Latin characters and usually encoded in `latin-1`.  

Good news is there is a simply trick to revert to back to bytes from original encoding and then into the utf8. For example, the following works in MySQL do convert `latin-1` string column incorrectly stored in a `utf8` database.  

```sql
UPDATE `schema`.`table` SET `column` = CONVERT(CAST(CONVERT(`column` USING latin1) AS binary) USING utf8)
```

*Note, if doing this operation on a `PRIMARY` or `UNIQUE` key use `UPDATE IGNORE`. And if modify a column with `FOREIGN KEY REFERENCES` use `SET FOREIGN_KEY_CHECKS = 0;` to let the operation pass.*  

## Cleaning Hidden Characters

Common hidden characters you might see in dirty data may include:  

- Tab, ASCII character 9, showing up as orange horizontal arrow in notepad++
- Line Feed, ASCII character 10, showing up as `LF` in notepad++
- Carriage Return, ASCII character 13, showing up as `CR` in notepad++

[ASCII source](https://ascii.cl/control-characters.htm)  

### MySQL

```sql
REPLACE(REPLACE(REPLACE(TRIM(`string_col`), CHAR(9),''), CHAR(10),''), CHAR(13),'')
```

### Oracle

```sql
TRANSLATE(TRANSLATE(TRANSLATE(TRIM(BOTH FROM "string_col"), CHR(9),' '), CHR(10),' '), CHR(13),' ')
```

NOTE the `' '` (empty space) in above example:
> You cannot use an empty string for to_string to remove all characters in from_string from the return value. Oracle Database interprets the empty string as null, and if this function has a null argument, then it returns null. - [Oracle Docs](https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions196.htm)  

## Concatenate Columns with Separator

Easily turn  

| value1   | value2   | value3     |
| :------- | :------- | :--------- |
| Item One | Item Two | Item Three |

...into `Item One,Item Two,Item Three` with...  

```sql
SELECT CONCAT_WS(',',`value1`,`value2`,`value3`) FROM schema.table
```

## Roll up Values into Comma Separated List

Do the same as above, this time with rows in a group by statement. Imagine the following table  

| value1    | value2     |
| :-------- | :--------- |
| Group One | Item One   |
| Group One | Item Two   |
| Group One | Item Three |
| Group One | Item Four  |
| Group One | Item Five  |

You can easily rollup the second column into a list using the following code  

```sql
SELECT
    `value1`
    GROUP_CONCAT(`Value2` SEPARATOR ',') AS "CSVvalues2"
FROM schema.table
GROUP BY `value1`
;    
```

## Searching Comma Separated Values

Use the function `FIND_IN_SET` to search for a string in another string of comma separated values. Imagine a scenario where you need to search an ID column to be in a comma separated values list of IDs (although really why not upload this into a temporary table with a proper index?)...or potentially more valuable, imagine a scenario where you have some string column made up of a csv list of strings, and need to search if some value exists in this column. Both examples are outlined below in this order.  

You use this to either filter where a column is in a csv string: (in this case you can utilize a normal index on the left-hand column to be filtered)  

```sql
SELECT *
FROM schema.table
WHERE FIND_IN_SET(`myStringColumn`, 'random,comma,separated,values');
```

Or you can search for a string in a csv column: (in this case no index required or allowed for the right-hand column)  

```sql
SELECT *
FROM schema.table
WHERE FIND_IN_SET('random_string',`myCSVColumn`);
```

# Maintenance

In MySQL, show the size of your tables in Mb  

```sql
SELECT
	table_schema,
	table_name,
	ROUND(((data_length + index_length) / 1024 / 1024), 2) "size (Mb)"
FROM information_schema.tables
WHERE
	table_schema = 'scheme'
	AND table_name LIKE '%keyword%'
ORDER BY
	ROUND(((data_length * index_length) / 1024 / 1024), 2) DESc
;
```

In MySQL, get various other table information for automated management.

```sql
SELECT
    create_time,
    table_name,
    table_rows
FROM information_schema.tables
WHERE table_schema = 'schema'
;
```

# User Management

In MySQL, create a dummy user and grant it `SELECT` only on a few tables. This is useful for example if you need give limited database access to a production app.  

Note that the `'%'` used below represents access from any host. Change this to a specific IP address to restrict the user's access even further.  

**NOTE:** Methods of creating and updating user passwords changed at MySQL v 5.7.6, better to consult the official [MySQL docs on account management](https://dev.mysql.com/doc/refman/8.0/en/account-management-sql.html) if unsure.

```sql
CREATE USER 'dummy'@'%' IDENTIFIED BY PASSWORD('dummy_password');
GRANT SELECT ON `schema`.`dummy_table` TO 'dummy'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'dummy'@'%';
```

The user was added to the user table. You can see this by:

```sql
SELECT * FROM mysql.user;
```

To reset a password, simply update the users table with:

```sql
UPDATE mysql.user SET password = PASSWORD(`new_dummy_password`) WHERE User='dummy';
```
