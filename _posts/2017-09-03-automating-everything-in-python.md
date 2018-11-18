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

## Temporary
```python
from tempfile import TemporaryDirectory
with TemporaryDirectory() as tmpdir:
    # do stuff
    # context manager cleans up after itself
# OR
import tempfile
import shutil
tmpdir = tempfile.mkdtemp()
# do stuff
# and clean up after yourself
shutil.rmtree(tmpdir)
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

## Time

```python
import time
from datetime import datetime

start = datetime.now()
# do something
time.sleep(2)
# or sleep two seconds
end = datetime.now()

time_delta = end - start
processing_speed = time_delta.seconds
```

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

#postgresql
db = create_engine('postgresql+psycopg2://{}:{}@{}:{}/{}'.format(
  creds['user'],
  creds['password'],
  creds['host'],
  creds['port'],
  creds['database']),
    encoding='utf8')

#mysql
db = create_engine('mysql+mysqldb://{}:{}@{}:{}/{}?charset=utf8&local_infile=1'.format(
    creds['user'],
    creds['password'],
    creds['host'],
    creds['port'],
    creds['database']),
      encoding='utf8')

#oracle
db = create_engine('oracle+cx_oracle://{}:{}@{}:{}/{}'.format(
  creds['user'],
  creds['password'],
  creds['host'],
  creds['port'],
  creds['tns']),
    encoding='utf8')

#write some data to file from pandas
#(format NULLs for MySQL acceptance)
df.fillna('\\N').to_csv('datafile.txt', sep='\t', encoding='utf8', quotechar='"', line_terminator='\n')

# define some sql statement
sql = """
  LOAD DATA LOCAL INFILE '{data}'
  INTO TABLE {schema}.{table}
  CHARACTER  SET utf8
  FIELDS TERMINATED BY '\t'
  OPTIONALLY] ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
""".format(data='datafile.txt',
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

def bool_string_input(s):
    if s in ['True','False']:
        return s == 'True'
    else:
        raise ValueError('Incorrect boolean value provided. Please specify one of "True" or "False"')

parser.add_argument('-a', '--argument', dest='myargument', type=str, help='Example argument description.', default='test')
parser.add_argument('-b', '--boolean', dest='myboolean', type=bool_string_input, help='Example boolean argument description.', default=False)

args = parser.parse_args()

myargument = args.myargument
myboolean = args.myboolean
```

## Logging

Setup a basic logging configuration for outputting log messages to console during runtime.  

```python
import Logging

logger = logging.getLogger('MyScript')

ch = logging.StreamHandler()
ch.setLevel(logging.INFO)

formatter = logging.Formatter('%(asctime)-15s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)

logger.addHandler(ch)

logger.info('Doing stuff')
logger.info('Doing other stuff')
```

# SMTP Email

Find a full working example of how to send emails with attachments, in python, using the SMTP protocol.   

```python
import smtplib
from email.message import EmailMessage
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

message_text = """
Automated message sent form Python job.

{custom}
""".format(custom="some custom message")

message_html = """
<html>
  <head></head>
  <body>
      <p>Automated message sent form Python job.</p>
      <br><br>
      <p>{custom}</p>
  </body>
</html>
""".format(custom="some custom message")

msg = MIMEMultipart('alternative')

msg_text_part = MIMEText(message_text, 'plain')
msg_html_part = MIMEText(message_html, 'html')

msg.attach(msg_text_part)
msg.attach(msg_html_part)

msg['Subject'] = 'Python Job Finished'
from_email = 'your_email@domain.com'
msg['From'] = from_email
to_email = 'their_email@domain.com'
msg['To'] = to_email

for f in attachments:
    with open(f,'rb') as b:
        part = MIMEApplication(
            b.read(),
            Name=os.path.basename(f)
        )
        part['Content-Disposition'] = 'attachment; filename="{}"'.format(os.path.basename(f))
        msg.attach(part)

s = smtplib.SMTP('smtp-server.yourcompany')
s.sendmail(from_email, to_email, msg.as_string())
```

# Jupyter

Jupyter Notebooks are a great place to write and debug code on the fly and interactively. Here are a few added magic functions or tricks to make going back and forth a bit more convenient.  

Run a python file from within a Jupyter Notebook with:  

```shell
!python program.py -h
```

Load a python file into a Jupyter cell with the following.  

```shell
%load program.py
```

And if running some code inside a Jupyter Notebook, which utilizes `argparse` and thus undesirable breaks execution, you can allow Jupyter Notebook to pass this section by doing the following.  

```python
if get_ipython().__class__.__name__ == 'ZMQInteractiveShell'
    sys.argv = ['-f']
```
