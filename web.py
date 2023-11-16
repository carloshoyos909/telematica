from flask import Flask, render_template, request
from waitress import serve
import os

app = Flask(__name__)

def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True, port=5000)