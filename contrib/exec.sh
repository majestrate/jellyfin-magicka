#!/bin/bash
source /opt/asdf/asdf.sh
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8
set -x
exec "$@"