import flask
import pathlib


p = pathlib.Path("..", "external", "jellyfin-web", "dist")

app = flask.Flask(__name__)
app.config["WEBUI_DIR"] = p
