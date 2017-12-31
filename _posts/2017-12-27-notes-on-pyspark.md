---
categories: [big data]
tags: [pyspark, spark, databricks]
---

Random notes, links, commands or snippets of code related to big data analysis using PySpark on Databricks.

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Code Snippets

Below is a collection of code samples which I have created and needed to use in my work more than once. They may be helpful to others.  

## Explode Array (or nested dictionary column) with Index

The below code creates a PySpark `user defined function` which implements `enumerate` on a list and returns a dictionary with `{index:value}` as integer and string respectively. I apply this to a dummy column "myNestedDict" which contains a key "myNestedCol" to show that this can work on dictionaries as well as arrays.  

```python
from pyspark.sql.functions import udf, col, explode
from pyspark.sql.types import ArrayType, MapType, StringType, IntegerType

explodeWithIndex = udf(lambda x: i:str(v) for i,v in enumerate(x) if x is not None), MapType(IntegerType(),StringType())

df2 = df.filter(col("myNestedDict").isNotNull()).select("id", explode(explodeWithIndex("myNestedDict").myNestedCol))
```

## String Column to Comma Separated Values within a Group (Reverse Explode)

The below sample code will group by a dummy id, and roll up a column of string values into a single column of comma separated values. This could also be considered as a reverse explode.  

```python
from pyspark.sql import functions as F

df2 = df.groupby("id").agg(F.concat_ws(",", F.collect_list("myValues"))).withColumnRenamed("concat_ws(,, collect_list(myValues))", "myCSV")
```
