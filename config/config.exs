import Config
import Logger

config :logger,
  level: :all

config :jellyfin, :ecto_repos, [Jellyfin.Repo]

config :jellyfin, Jellyfin.Repo,
  database: "jellyfin",
  username: "",
  password: "",
  hostname: "",
  adapter: Ecto.Adapters.Postgres,
  priv: "priv/jellyfin"

secrets = "#{config_env()}.exs"

:ok =
  cond do
    File.exists?("./config/#{secrets}") -> import_config secrets
    true -> Logger.warning("could not find #{secrets}")
  end
