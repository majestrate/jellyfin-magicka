
all: help

help:
	@echo "run: make setup compile up"
compile:
	podman build -t jellyfin-magicka -f contrib/build_jellyfin.podfile --no-cache .
clean:
	podman rmi -f jellyfin-build:latest jellyfin-magicka:latest jellyfin-webui:latest
setup:
	podman build -t jellyfin-build -f contrib/base_env.podfile --no-cache .
	podman build -t jellyfin-webui -f contrib/build_webui.podfile --no-cache .
up:
	podman-compose up
down:
	podman-compose down