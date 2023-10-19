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

secrets = "#{Mix.env()}_secrets.exs"

Logger.debug("looking for #{secrets}")

if File.exists?("./config/#{secrets}") do
  Logger.info("loading #{secrets}")
  import_config secrets
end
