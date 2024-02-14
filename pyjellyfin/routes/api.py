from pyjellyfin.app import app
from flask import Blueprint, send_from_directory

bp = Blueprint("api", __name__)


@bp.route("/", methods=("GET", "HEAD"))
def index():
    return "suh"
