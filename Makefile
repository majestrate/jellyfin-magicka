
all: compile

webui:
	podman build -t jellyfin-webui -f contrib/build_webui.podfile .

compile: webui
	podman build -t jellyfin-magicka -f contrib/build_jellyfin.podfile .

clean:
	podman rmi -f jellyfin_build_env:latest jellyfin-magicka:latest jellyfin-webui:latest

setup:
	podman build -t jellyfin_build_env -f contrib/base_env.podfile --no-cache .

run:
	podman-compose up
