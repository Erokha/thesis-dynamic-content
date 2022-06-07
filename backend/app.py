from flask import Flask
import js_routine as js
from LayoutViews.MainView import make_main_view
from LayoutViews.DetailView import make_detail_view
import LayoutViews.ExampleView as example
from  LayoutViews.component_demo import make_demo_component

app = Flask(__name__)

@app.route('/main_view')
def main_view():
    view = make_main_view()#make_demo_component()
    return js.getJSON(view.serialize())

@app.route('/profile_view')
def detail_view():
    view = make_detail_view()
    return js.getJSON(view.serialize())

@app.route('/example_view')
def example_view():
    view = example.make_base_view()
    view.subviews = [
        example.make_text_view(),
        example.make_round_view()
    ]
    return js.getJSON(view.serialize())


if __name__ == '__main__':
    app.run()



