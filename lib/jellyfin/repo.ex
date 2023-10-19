defmodule Jellyfin.Repo do
  use Ecto.Repo,
    otp_app: :jellyfin,
    adapter: Ecto.Adapters.Postgres
end
