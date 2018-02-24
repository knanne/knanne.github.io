---
categories: [big data]
tags: [pyspark, spark, python, databricks]
---

Random notes, links, commands or snippets of code related to big data analysis using PySpark (on Databricks).

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Intro

Official [PySpark docs](https://spark.apache.org/docs/latest/api/python/index.html) are available, and [Databricks](https://docs.databricks.com/) has some good notes, but it can still be confusing for a beginner coming from Pandas.  

# Common Techniques

There are two common ways to select on DataFrames through the Python API of Spark. Either `df.select("myCol")` or `df.selectExp("myCol")`.  

For me `.select()` is the most intuitive coming from Pandas, however I also always do `from pyspark.sql import functions as F` and use `df.select(F.col("myCol").key)` or `df.select(F.explode("myCol"))`.  

While others prefer to use `.selectExp()` which accepts SQL but still returns the DataFrame, and do `df.selectExp("myCol.key")` or `df.selectExp("explode(myCol)")`.  

Group by and aggregation look like this, `df.groupby("myCol1", "myCol2").agg(F.countDistinct("myCol3"))`.  

Chaining functions together works really well, for example: `df.filter(...).select(...).join(...).groupby(...).agg(...)`.  

Also, when dealing with HIVE tables, nested dictionaries and arrays can be utilized quite powerfully, and accessed in natural Pythonic ways. For example, as show above, access dictionaries using `myDictCol.key`, and index arrays simply with `myArrayCol[index]`.  

Common functions to remember are `.withColumn()` to add calculated fields to DataFrames or chain more than one `explode` together, and also `.withColumnRenamed()` to quickly rename that function-applied column.  

After `from pyspark.sql import functions as F`, you have access to a lot of basic tools, which can be combined in all sorts of ways to analysis. Consider the example of making SQL-accepted date column by combining a string year and month column. `df.withColumn(F.to_date(F.concat_ws('-', df.year, df.month, F.lit('01')), format='yyyy-mm-dd').alias("date"))`  

# Code Snippets

Below is a collection of code samples which I have created and needed to use in my work more than once. They may be helpful to others.  

## Explode with Index

Explode an elements in an array, or a key in an array of nested dictionaries with an index value, to capture the sequence.  

The below code creates a PySpark `user defined function` which implements `enumerate` on a list and returns a dictionary with `{index:value}` as integer and string respectively. I apply this to a dummy column "myNestedDict" which contains a key "myNestedCol" to show that this can work on dictionaries as well as arrays.  

```python
from pyspark.sql.functions import udf, col, explode
from pyspark.sql.types import ArrayType, MapType, StringType, IntegerType

explodeWithIndex = udf(lambda x: i:str(v) for i,v in enumerate(x) if x is not None, MapType(IntegerType(),StringType()))

df2 = df.filter(col("myNestedDict").isNotNull()).select("id", explode(explodeWithIndex("myNestedDict").myNestedCol))
```

## Reverse Explode

Convert a column of strings to comma separated values list as a single string within a group by statement.  

The below sample code will group by a dummy id, and roll up a column of string values into a single column of comma separated values. This could also be considered as a reverse explode.  

```python
from pyspark.sql import functions as F

df2 = df.groupby("id").agg(F.concat_ws(",", F.collect_list("myValues"))).withColumnRenamed("concat_ws(,, collect_list(myValues))", "myCSV")
```
