---
categories: [data analysis]
tags: [calculations, equations]
---

A list of random calculations I will need again for data analysis

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Euclidean Distance

The following equation can be used to calculate distance between two locations (e.g. shopper and store etc.)  

## SQL

```sql
create database test;
create table test.distance (latitude1 float, longitude1 float, latitude2 float, longitude2 float);
insert into test.distance (latitude1, longitude1, latitude2, longitude2) values (52.379128, 4.900272, 40.752726, -73.977229);

select
  *,
  distance_km / 1.609344 "distance_mi"
from
(
  select
  	latitude1,
  	longitude1,
  	latitude2,
  	longitude2,
  	ACOS(
  	  SIN(latitude1*PI()/180) * SIN(latitude2*PI()/180)
  		+ COS(latitude1*PI()/180) * COS(latitude2*PI()/180)
  		* COS(longitude2*PI()/180 - longitude1*PI()/180)
  		) * 6371 "distance_km"
  from test.distance
) x
;
```

## Pandas

```python
import pandas as pd
import math

latitude1 = 52.379128
latitude2 = 40.752726
longitude2 = 4.900272
longitude1 = -73.977229

df = pd.DataFrame([{
    'latitude1': latitude1, 'longitude1': longitude1,
    'latitude2': latitude2, 'longitude2': longitude2}])

euclidean_distance = lambda row: math.acos(
  math.sin(row['latitude1']*math.pi/180) * math.sin(row['latitude2']*math.pi/180)
  + math.cos(row['latitude1']*math.pi/180) * math.cos(row['latitude2']*math.pi/180)
  * math.cos(row['longitude2']*math.pi/180 - row['longitude1']*math.pi/180) ) * 6371

df['distance_km'] = df.apply(euclidean_distance, axis=1)
df['distance_mi'] = df['distance_km'].apply(lambda x: x / 1.609344)
```
