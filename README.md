# Jellyfin Magicka

## <span style='color: red;'> **Currently in development, NOT for end users** </span>

![logo by autismus maximus](logo.svg)

### Jellyfin media server rewritten in elixir

# Workflow

`uwu`

## Requirements

* elixir >= 1.15
* erlang >= 26.1
* ffmpeg >= 5.1
* postgresql >= 15 with rum indices


setup:

    $ asdf install

compile:

    $ mix local.hex
    $ mix deps.get
    $ mix ecto.up

<!--
configure:

    $ mix jellyfin.setup genconf --interactive

-->

run:

    $ mix run --no-halt
