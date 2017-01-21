---
layout: post
categories: [tech]
tags: [python, flask]
---

Notes on using Flask, a microframework for creating apps in Python.

<!--excerpt separator -->

## Intro to Flask

- [flask docs](http://flask.pocoo.org/)

#### resources

[This guy](https://blog.miguelgrinberg.com/category/Flask) has some pretty good blog posts on Flask, and wrote a [book](http://flaskbook.com/) on it

## Getting Started

###### create app environment
```shell
md flask_app
cd flask_app
virtual env
```

###### activate app from scripts
```shell
cd env
cd Scripts
activate
```

###### install flask in root
```shell
cd ..
cd ..
pip install flask
```

###### write app in python
```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
	return 'Hello World'

if __name__ == '__main__':
	app.run()
```

###### run app
```shell
python app.py
```

navigate to [localhost:5000](http://127.0.0.1:5000/)

## App Jobs

A more complex web app which needs to perform time consuming tasks like send emails, make external API calls or do long computations will require a background processing. Enter [celery](http://www.celeryproject.org/)

[Here](https://blog.miguelgrinberg.com/post/using-celery-with-flask) is a good blog post on celery for Flask
