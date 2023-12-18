defmodule Jellyfin.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Jellyfin.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:jellyfin, :ecto_repos),
       skip: System.get_env("SKIP_MIGRATIONS") == "1"},
      {Bandit, plug: Jellyfin.APIServer}
    ]

    opts = [strategy: :one_for_all, name: Jellyfin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
