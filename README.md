# Jellyfin Magicka

## <span style='color: red;'> **Currently in development, NOT for end users** </span>

![logo by autismus maximus](logo.svg)

### Jellyfin media server rewritten in elixir

# Workflow

`uwu`

## Requirements

* elixir >= 1.15
* erlang >= 26.1
* nodejs >= 20.8 && < 21.0.0
* ffmpeg >= 5.1
* postgresql >= 15 with rum indices


setup tooling if you dont have the right elixir erlang or nodejs:

	$ asdf install

set up submodules:

	$ git submodule update --init --recursive

compile:

	$ mix jellyfin compile

initialize database:

	$ mix ecto up
	$ mix ecto migrate

<!--
configure:

	$ mix jellyfin.setup genconf --interactive

-->


testing:
	
	$ mix test
	
testing without caching webui:
	
	$ mix jellyfin test --no-cache-web

run:

	$ mix jellyfin run

run without caching webui:

    $ mix jellyfin run --no-cache-web
