defmodule Jellyfin.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Jellyfin.Repo,
      {DNSCluster, query: Application.get_env(:jellyfin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Jellyfin.PubSub},
      # Start a worker by calling: Jellyfin.Worker.start_link(arg)
      # {Jellyfin.Worker, arg},
      # Start to serve requests, typically the last entry
      JellyfinWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Jellyfin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JellyfinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
