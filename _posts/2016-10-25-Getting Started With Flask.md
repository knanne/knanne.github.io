---
layout: post
image: /assets/img/posts/flask.png
categories: [tech]
tags: [flask, tutorial]
---

Notes on using Flask, a microframework for creating apps in Python.

<!--excerpt separator -->

## Intro to Flask

- [flask docs](http://flask.pocoo.org/)

## Getting Started

*create app environment*  

```shell
md flask_app
cd flask_app
virtual env
```

*activate app from scripts*  

```shell
cd env
cd Scripts
activate
```

*install flask in root*  

```shell
cd ..
cd ..
pip install flask
```

*write app in python*  

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
	return 'Hello World'

if __name__ == '__main__':
	app.run()
```

*run app*  

```shell
python app.py
```

navigate to [localhost:5000](http://127.0.0.1:5000/)