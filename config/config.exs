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

import_config "#{config_env()}.exs"
