from flask import Flask
import js_routine as js
from LayoutViews.MainView import make_main_view

app = Flask(__name__)

@app.route('/main_view')
def main_view():
    view = make_main_view()
    return js.getJSON(view.serialize())

if __name__ == '__main__':
    app.run()
