import Config

config :jellyfin,
  server_name: "jellyfin",
  product_name: "jellyfin magicka",
  os: "Linux",
  version: "10.9.1",
  id: "some-server-id"

import_config "#{config_env()}.exs"
