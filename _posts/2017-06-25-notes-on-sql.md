---
categories: [programming]
tags: [sql, mysql, postgresql, oracle]
---

Helpful SQL tips and commands I use frequently  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Notes

I interact on a daily basis with MySQL, PostgreSQL, and Oracle. However, they all have a few slight differences which can make switching back and forth a frustrating hassle. Most significantly when grouping, or using built-in functions.  

Some simple differences include:
  - Despite MySQL allowing most group by behavior, PostgreSQL and Oracle SQL will both complain if you do not explicitly list all non-aggregate columns in the group by clause (unless you incude a table's unique identifier). However, this is good practice anyway.  
  - Limiting rows in MySQL is easy as `limit 10` while in Oracle you can do `WHERE ROWNUM <= 10`.  
  - You are allowed to use `#comment` for comment blocks in MySQL, however in PostgreSQL `--comment--` is recommended. Although, in all languages, the standard of `/*comment*/` always works.  
  - MySQL handles strings with single quotes (`' '`) or double (`" "`), and reserved words like table names and columns with backticks (`` ` ` ``). However, PostgreSQL and Oracle use double quotes for reserved words, single quotes for strings and no backticks.  


# Use Cases

## Ranking Within Groups

### MySQL

```sql
SELECT tmp1.* FROM
(
  SELECT
    tmp.*,
    @grp := tmp.`group_col` AS "dummy",
    @num := IF(@grp = tmp.`group_col`, @num + 1, 1) AS "rank"
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

# Pivot

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

If you need to achieve the opposite, you can probably take advantage of `COALESCE` to stack multiple columns into one based on the first non-NULL value.

# Random Code Snippets

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

## MySQL Load Local Infile Dynamically

Consider you have a datafile that contains more than what you want in the database, and that this file is large enough that you do not want to read and preprocess it. Below is an extensive example on how to dynamically load a tab separated text file, mapping specific data columns into table columns. We also add an auto-increment id column, ignore the datafile header, and ignoring duplicates on our primary key.  

**Create table**  

```sql
CREATE TABLE IF NOT EXISTS schema.table
  `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `last_updated` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` VARCHAR(100) NOT NULL,
  `attribute1` MEDIUMINT(10) UNSINGED DEFAULT 0,
  `attribute2` VARCHAR(50) DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  PRIMARY KEY (`title`),
  KEY `attribute1` (`attribute1`),
  KEY `attribute2` (`attribute2`)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
;
```

**Sample tab-separated datafile as `data.txt`**  

| col1         | col2 | col3     | col4 | col5           | col6 | col7                                                                           |
| ------------ | ---- | -------- | ---- | -------------- | ---- | ------------------------------------------------------------------------------ |
| Lorem Ipsum1 | NULL | 82310    | NULL | Lorem ipsum    | NULL | Omnis et maxime tenetur adipisci, aut commodi debitis                          |
| Lorem Ipsum2 | NULL | 02163549 | NULL | dolor sit amet | NULL | Sint laborum quisquam reiciendis delectus numquam est ea architecto            |
| Lorem Ipsum3 | NULL | 97436134 | NULL | Lorem ipsum    | NULL | Obcaecati illo tempora laborum porro odit quia et pariatur iste enim facilis   |
| Lorem Ipsum4 | NULL | 00173462 | NULL | dolor sit amet | NULL | Fuga dignissimos quas est culpa temporibus incidunt voluptatem unde beatae sit |
| Lorem Ipsum5 | NULL | 87413    | NULL | Lorem ipsum    | NULL | libero dolorum pariatur fugit sit officia ducimus laborum                      |

**Load**  

```sql
LOAD DATA LOCAL INFILE 'C:/path/to/data.txt'
IGNORE INTO schema.table
FIELDS SEPARATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@col1, @col2, @col3, @col4, @col5, @col6, @col7)
SET id=NULL,
    created_at=NULL,
    last_updated=NULL,
    title=@col1,
    attribute1=@col3,
    attribute2=@col5,
    description=@col7
;
```
