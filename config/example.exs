import Config

config :jellyfin, Jellyfin.Repo,
  # the name of the postgres database to use
  database: "jellyfin",
  # postgres user to access database with
  username: "",
  # password for above user
  password: "",
  # db server address
  hostname: ""
