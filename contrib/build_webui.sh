#!/bin/bash
source /opt/asdf/asdf.sh
set -x
cd priv/web/jellyfin-web
npm install
npm run build:development
