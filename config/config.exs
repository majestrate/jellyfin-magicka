# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :jellyfin,
  ecto_repos: [Jellyfin.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :jellyfin, JellyfinWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: JellyfinWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Jellyfin.PubSub,
  live_view: [signing_salt: "/GBKFOlx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

passwd_file = "config/#(config_env()}_db_passwd.txt"

{:ok, passwd} =
  cond do
    File.exists?(passwd_file) -> File.read!(passwd_file)
    true -> {:ok, nil}
  end

# defaults
config :jellyfin, Jellyfin.Repo,
  username: "jellyfin_#{config_env()}",
  password: passwd

import_config "#{config_env()}.exs"
