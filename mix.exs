defmodule Jellyfin.MixProject do
  use Mix.Project

  def project do
    [
      app: :jellyfin,
      version: "0.1.0",
      elixir: "~> 1.11",
      test_coverage: [tool: CoverModule],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        jellyfin: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ]
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
      {:cors_plug, "~> 3.0"},
      {:req, "~> 0.4.0"},
      {:bandit, "~> 1.0"},
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, "~> 0.17.3"},
      {:jason, "~> 1.0"},
      {:ffmpex, "~> 0.10.0"},
      {:markdown_formatter, "~> 0.6", only: :dev, runtime: false}
    ]
  end

  def cli do
    [
      preferred_envs: [
        "jellyfin.test": :test,
        release: :prod
      ]
    ]
  end
end
