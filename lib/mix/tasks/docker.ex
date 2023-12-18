# ./lib/mix/tasks/docker.ex
defmodule Mix.Tasks.Docker do
  use Mix.Task
  @shortdoc "Docker utilities for building releases"

  defguardp is_cmd(args, cmd) when is_list(args) and hd(args) == cmd
  defguardp is_cmd(arg, cmd) when is_binary(arg) and arg == cmd

  defp tag(:latest) do
    "jellyfin:latest"
  end

  defp docker(args) when is_list(args) do
    Mix.shell().info(["run: docker" | args |> Enum.map(fn x -> " #{x}" end)])
    Mix.Task.run("cmd", ["docker" | args])
  end

  defp docker(arg) when is_binary(arg) do
    docker([arg])
  end

  def run(args) when is_cmd(args, "compile") do
    :ok = Mix.Task.run("jellyfin", ["compile"])
    :ok = docker(["build", "-t", "#{tag(:latest)}", "."])
    docker(["run", "-t", tag(:latest)])
  end

  def run(args) when length(args) == 0 do
  end
end
