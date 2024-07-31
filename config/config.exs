import Config

config :jellyfin, Jellyfin.Repo,
  database: "jeff",
  username: "jeff",
  password: "jeff",
  hostname: "localhost"

config :jellyfin,
  ecto_repos: [Jellyfin.Repo]

config :jellyfin, Jellyfin.SystemInfo,
  server_name: "jellyfin",
  product_name: "jellyfin magicka",
  os: "Linux",
  version: "10.9.1",
  id: "some-server-id"

import_config "#{config_env()}.exs"
