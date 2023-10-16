import Config

config :jellyfin, :db,
  database: "jellyfin",
  username: "",
  password: "",
  hostname: "",
  adapter: Ecto.Adapters.Postgres

config :jellyfin,
  ecto_repos: [
    Jellyfin.Repo
  ]

secrets = "#{Mix.env()}.secret.exs"

if File.exists?(secrets) do
  import_config secrets
end
