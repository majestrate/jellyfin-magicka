
all: recompile

setup:
	podman build -t jellyfin_build_env -f contrib/base_env.podfile .
compile:
	podman build -t jellyfin -f contrib/build_jellyfin.podfile .

clean:
	podman rmi -f jellyfin_build_env:latest jellyfin:latest

recompile:
	podman build -t jellyfin_build_env -f contrib/base_env.podfile --no-cache .
	podman build -t jellyfin -f contrib/build_jellyfin.podfile --no-cache .	