from pyjellyfin.app import app
from flask import Blueprint, send_file
from pathlib import Path

bp = Blueprint("webui", __name__, url_prefix="/web")


@bp.route("/")
def serve_index():
    return serve_webui("index.html")


@bp.route("/<path:name>")
def serve_webui(name):
    name = app.config["WEBUI_DIR"] / Path(name)
    return send_file(name)
