import Config

config :ecto, Repo, url: "sqlite://jellyfin_#{Mix.env()}.sqlite"

secrets = "#{Mix.env()}_secret.exs"

if File.exists?(secrets) do
  import_config secrets
end
