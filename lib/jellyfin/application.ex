defmodule Jellyfin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Plug.Cowboy, scheme: :http, plug: Jellyfin.Web.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: Jellyfin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
