import flask as Flask
import json

# import cutter as Cutter
from .cutter import Cutter

from flask import Flask
from flask import send_file
from flask import request

from PIL import Image
from io import BytesIO
from io import StringIO

import requests
import tempfile

app = Flask(__name__)

@app.route("/<int:top_left_x>/<int:top_left_y>/<int:bottom_right_x>/<int:bottom_right_y>")
def show(top_left_x, top_left_y, bottom_right_x, bottom_right_y):
    image_url = request.args.get('image_url')
    image_response = requests.get(image_url, stream=True)
    tmp_image = tempfile.NamedTemporaryFile(mode="wb")
    tmp_image.write(image_response.content)
    print(image_response.content)
    print(tmp_image.name)
    # input_image = urllib.urlopen(image_url).read()
    # file = cStringIO.StringIO(input_image)
    rectangle = (top_left_x, top_left_y, bottom_right_x, bottom_right_y)
    cutter = Cutter(tmp_image.name, rectangle)
    cutted_image = cutter.call()

    im = Image.fromarray(cutted_image)
    img2 = BytesIO()
    im.save(img2, format="png")
    # return 'hello'
    img2.seek(0)

    return send_file(img2, mimetype='image/png')

if __name__ == "__main__":
    app.run()
