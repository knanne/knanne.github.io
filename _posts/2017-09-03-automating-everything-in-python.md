---
categories: [data analysis]
tags: [python]
---

Helpful scripts for automating everything Python  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Files

Manipulate files for automating ETL pipelines.  

## Stats

```python
import os
from datetime import datetime
f = 'file.txt'
size = os.stat(f).st_size
last_modified = datetime.fromtimestamp(os.stat(f).st_mtime)
```

## Creating

```python
import os
folder = os.path.abspath('folder')
if not os.path.exists(folder):
    os.makedirs(folder)
```

## Copying

```python
import os
import glob
import shutil
src_dir = 'folder_in'
dst_dir = 'folder_out'
if not os.path.exists(dst_dir):
  os.makedirs(dst_dir)
for f in glob.glob(os.path.join(src_dir, '*.txt')):
  shutil.copy(f, dst_dir)
```

## Zipping

```python
import zipfile
import os
src_dir = 'folder'
dst_dir = 'folder.zip'
zp = zipfile.ZipFile(dst_dir, 'w')
for folder, subfolder, files in os.walk(src_dir):
  for f in files:
    zp.write(os.path.join(folder,f), os.path.relpath(os.path.join(folder,f), dst_dir), compress_type=zipfile.ZIP_DEFLATED)
zp.close()
```

## Decompressing

```python
import gzip
import io
infile = 'compressed.gz'
outfile = 'decompressed.txt'
with gzip.open(infile, 'rb') as inf:
  with io.open(outfile, 'wb+') as outf:
    outf.write(inf.read())
```

# Shell

Run command line operations from within python.  

## Executing Commands

```python
import subprocess
infiles = os.path.join('folder', '*.gz')
outfile = 'combined.gz'

# windows
cmd = 'copy /B /Y {} {}'.format(infiles, outfile)
# unix
cmd = 'cat {} > {}'.format(infiles, outfile)

subprocess.run(cmd, shell=True)
```

# Security

Always hide credentials or keys behind the scenes.  

## Accessing Credentials

From files. The file should contain a dictionary, looking something like this:

```json
{
  'username': 'fake_user',
  'password': 'fake_password'
}
```

```python
import json
with open('credentials', 'r') as f:
    creds = json.loads(f.read())
```

From environmental variables.  

```python
import os
username = os.environ['USERNAME']
password = os.environ['PASSWORD']
```

# System

Access and use system settings in a workflow.  

## OS

```python
import platform
print(platform.system())
```

## Python Installation

```python
import sys
# python installation location
print(sys.executable)
# python version
print(sys.version_info.major)
```

## Modify PATH

Temporarily add a folder to you path, maybe for importing a custom python module.   

```python
import sys
import os
custom_module = os.path.abspath('custom_module')
sys.path.append(custom_module)
```

# HTTP

Operations over HTTP(s)  

## API

```python
import requests
url = 'https://site/endpoint'
payload = {
  'item1': item1,
  'item2': item2
}
headers = {'hitem1': hitem1}
r = requests.post(url, headers=headers, json=payload)
```

## Download

```python
import urllib
url = 'https://site/endpoint/file'
urllib.urlretrieve(url)
```

# SQL

Connect to a database and execute a sql statement with the following.  

This following example uses [SQLAlchemy](http://www.sqlalchemy.org/). Depending on the type of database you are connecting to, there is an extra configuration step to install the right Python-to-ODBC connection, then choose the correct engine below.  

PostgreSQL: `pip install psycopg2`, see [psycopg homepage](http://initd.org/psycopg/)  

MySQL: `pip install mysqlclient`, see [mysqlclient-python on github](https://github.com/PyMySQL/mysqlclient-python) which supports python 3.6. If on Windows, find the correct wheel file for your platform on [pypi](https://pypi.python.org/pypi/mysqlclient)  

Oracle: `pip install cx_Oracle` see [python-cx_Oracle on github](https://github.com/oracle/python-cx_Oracle). You will also need the [Oracle Client](http://www.oracle.com/technetwork/database/features/instant-client/index.html).  

```python
import json
# read database credentials from json file
with open('creds_file') as f:
  creds = json.loads(f.read())

from sqlalchemy import create_engine
# create appropriate database connection engine
db = create_engine('postgresql+psycopg2://{}:{}@{}:{}/{}'.format(
  creds['user'],
  creds['password'],
  creds['host'],
  creds['port'],
  creds['database']),
    encoding='utf8')

db = create_engine('mysql+mysqldb://{}:{}@{}:{}/{}?charset=utf8&local_infile=1'.format(
    creds['user'],
    creds['password'],
    creds['host'],
    creds['port'],
    creds['database']),
      encoding='utf8')

db = create_engine('oracle+cx_oracle://{}:{}@{}:{}/{}'.format(
  creds['user'],
  creds['password'],
  creds['host'],
  creds['port'],
  creds['tns']),
    encoding='utf8')

# define some sql statement
sql = """
  LOAD DATA LOCAL INFILE '{data}'
  INTO TABLE {schema}.{table}
  FIELDS TERMINATED BY '\t'
  IGNORE 1 LINES
""".format(data='file.txt',
           schema='db',
           table='data')

# execute sql
connection = db.connect()
r = connection.execute(sql)
connection.close()
```

# Processing

## Progress

[tqdm](https://github.com/tqdm/tqdm) is a super nice library for showing a progress bar when executing loops. They even have a [pandas integration](https://github.com/tqdm/tqdm#pandas-integration).  

It runs in terminal by default, you can also run it in a Jupyter Notebook. Here is good example, using enumerate.  

```python
from tqdm import tqdm
from tqdm import tnrange, tqdm_notebook

with tqdm_notebook(total=len(data)) as pbar:
  for i,file in enumerate(data):
    pbar.update(1)
```

# Runtime

Various procedures to consider when building `.py` executables.  

## Arguments

Pass command line arguments to a .py during execution. Simply copy the below to a `test.py` file and run `test.py -h` from the command line.   

```python
import argparse
parser = argparse.ArgumentParser(description='Example on how to use ArgumentParser', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument('-a', '--argument', dest='myargument', type=str, help='Example argument', default='test')
parser.add_argument('-b', '--boolean', dest='myboolean', type=bool, help='Example boolean argument', default=False)

args = parser.parse_args()

myargument = args.myargument
myboolean = args.myboolean
```

## Logging

Setup a basic logging configuration when running time consuming operations.  

```python
import Logging

logging.basicConfig(level=logging.INFO, format='%(asctime)-15s %(message)s')

logging.info('My custom logging message')

# disable logging to a certain level
logging.disable(logging.INFO)

logging.info('My second custom logging message')
```
