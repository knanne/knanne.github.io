---
layout: post
categories: [web development]
tags: [python, flask]
sections:
- Flask Intro
- Resources
- Simple setup
- Advanced
---

Notes on using Flask, a microframework for creating apps in Python.

<!-- excerpt separator -->

<div class="heading" id="flask_intro"></div>

## Flask Intro

**Flask**

> Flask is a micro webdevelopment framework for Python - [website](http://flask.pocoo.org/)

<div class="heading" id="resources"></div>

## Resources

[This guy](https://blog.miguelgrinberg.com/category/Flask) has some pretty good blog posts on Flask, and wrote a [book](http://flaskbook.com/) on it

<div class="heading" id="simple setup"></div>

## Simple Setup

Create app environment  

```shell
md flask_app
cd flask_app
virtual env
```

Activate app from scripts  

```shell
cd env
cd Scripts
activate
```

Install flask in root  

```shell
cd ..
cd ..
pip install flask
```

Write app in python  

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
	return 'Hello World'

if __name__ == '__main__':
	app.run()
```

Run app  

```shell
python app.py
```

navigate to [localhost:5000](http://127.0.0.1:5000/)  

<div class="heading" id="advanced"></div>

## Advanced

A more complex web app which needs to perform time consuming tasks like send emails, make external API calls or do long computations will require a background processing. Enter [celery](http://www.celeryproject.org/)

[Here](https://blog.miguelgrinberg.com/post/using-celery-with-flask) is a good blog post on celery for Flask
