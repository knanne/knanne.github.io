---
categories: [data analysis]
tags: [python]
---

Helpful scripts for automating everything Python  

<!-- excerpt separator -->

* AUTO TABLE OF CONTENTS
{:toc}

# Files

## Stats

```python
import os
f = 'file.txt'
size = os.stat(f).st_size
last_modified = os.stat(f).st_mtime
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
import glob
import shutil
src_dir = 'folder_in'
dst_dir = 'folder_out'
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

## Executing Commands

```python
import subprocess
infiles = os.path.join('folder', '*.gz')
outfile = 'combined.gz'
cmd = 'copy /B /Y {} {}'.format(infiles, outfile)
subprocess.run(cmd, shell=True)
```

# Security

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

## Python Installation

```python
import sys
print(sys.executable)
print(sys.version_info())
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

Connect to a database and quickly upload data with the following.  

```python
from sqlalchemy import create_engine
db = create_engine('mysql+mysqldb://{}:{}@{}:{}/?charset=utf8&local_infile=1'.format(creds['user'],
                                                                                     creds['password'],
                                                                                     creds['host'],
                                                                                     creds['port']),
                   encoding='utf8')
sql = """
  LOAD DATA LOCAL INFILE '{data}'
  INTO TABLE {schema}.{table}
  FIELDS TERMINATED BY '\t'
  IGNORE 1 LINES
""".format(data='file.txt',
           schema='db',
           table='data')
r = db.execute(sql)
```
