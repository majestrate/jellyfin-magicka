from pyjellyfin.app import app
from flask import Blueprint, jsonify

bp = Blueprint("system", __name__, url_prefix="/system")


def dummy_system_info():
    return {
        "LocalAddress": "string",
        "ServerName": "string",
        "Version": "string",
        "ProductName": "string",
        "OperatingSystem": "string",
        "Id": "string",
        "StartupWizardCompleted": False,
    }


@bp.route("/info/public")
def index():
    return jsonify(dummy_system_info())
