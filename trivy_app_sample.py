'''
Python File to Run Example
'''

from app import create_app, db # pylint: disable=unused-import

app = create_app()

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port='8080')  
