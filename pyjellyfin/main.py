from pyjellyfin.app import app
from pyjellyfin.routes import webui, api, system


for mod in (webui, system, api):
    app.register_blueprint(mod.bp)
