#!/usr/bin/python
from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def post():
    # return str(request.headers) + str(request.get_data())
    return request.get_data()

if __name__ == '__main__':
    app.debug = False
    app.run()