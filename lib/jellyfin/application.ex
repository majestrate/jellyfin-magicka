defmodule Jellyfin.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Jellyfin.Repo,
      {Plug.Cowboy, scheme: :http, plug: Jellyfin.Web.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: Jellyfin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
