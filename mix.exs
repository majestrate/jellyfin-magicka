defmodule Jellyfin.MixProject do
  use Mix.Project

  def project do
    [
      app: :jellyfin,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Jellyfin.Application, []}
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.14"},
      {:plug_cowboy, "~> 2.0"},
      {:cors_plug, "~> 3.0"},
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, "~> 0.17.3"},
      {:jason, "~> 1.0"}
    ]
  end
end
