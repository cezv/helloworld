from flask import render_template as rt
from datetime import datetime as dt
from . import app

@app.route("/")
def home():
    return rt("hello.html", date=dt.now().strftime("%A, %d/%m/%Y"))