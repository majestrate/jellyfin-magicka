defmodule Mix.Tasks.Jellyfin do
  @shortdoc "compiles all the jellyfin parts"

  use Mix.Task

  defguardp is_cmd(args, cmd) when is_list(args) and hd(args) == cmd

  defp priv(path) when is_binary(path) do
    Mix.Project.app_path()
    |> Path.join("priv")
    |> Path.join(path)
  end

  defp webui(:git) do
    Path.join("external", "jellyfin-web")
  end

  defp webui(:compile) do
    webui(:git) |> Path.join("dist")
  end

  defp webui(:output) do
    priv("web")
  end

  defp npm(target, more) when is_list(more) do
    args = ["--cd", webui(:git), "npm", target] ++ more
    Mix.shell().info(["running npm #{target} ", more])
    :ok = Mix.Task.run("cmd", args)
  end

  defp npm(target, more) when is_binary(more) do
    npm(target, [more])
  end

  defp npm(target) do
    npm(target, [])
  end

  defp build_target() do
    case Mix.env() do
      :prod -> "build:production"
      _ -> "build:development"
    end
  end

  @no_cache "--no-cache-web"

  defp drop_args(args) do
    drop = [@no_cache]

    args
    |> Enum.drop(1)
    |> Enum.reject(fn arg -> Enum.member?(drop, arg) end)
  end

  defp args_for(target, args) do
    cond do
      Enum.member?(args, @no_cache) -> [target, @no_cache]
      true -> [target]
    end
  end

  defp compile_webui() do
    Mix.shell().info("compile webui in #{webui(:git)} to #{webui(:output)}")
    npm("install")
    npm("run", build_target())
    Mix.shell().info("copying webui to #{webui(:output)}")

    :ok =
      cond do
        not File.exists?(priv("")) -> File.mkdir(priv(""))
        true -> :ok
      end

    {:ok, _} = webui(:compile) |> File.cp_r(webui(:output))
    :ok
  end

  def run(args) when is_cmd(args, "clean") do
    {:ok, _} = webui(:git) |> Path.join("node_modules") |> File.rm_rf()
    {:ok, _} = Mix.Task.run("clean")
  end

  def run(args) when is_cmd(args, "compile") do
    :ok =
      case Mix.Task.run("deps", ["get"]) do
        :error -> :error
        _ -> :ok
      end

    :ok =
      case Mix.Task.run("deps", ["compile"]) do
        :error -> :error
        _ -> :ok
      end

    cond do
      not File.exists?(webui(:output)) -> compile_webui()
      Enum.member?(args, @no_cache) -> compile_webui()
      true -> Mix.shell().info("webui compile cached")
    end
  end

  def run(args) when is_cmd(args, "test") do
    args_for("compile", args) |> run()
    Mix.Task.run("test", drop_args(args))
  end

  def run(args) when is_cmd(args, "run") do
    args_for("compile", args) |> run()
    Mix.Task.run("run", args ++ ["--no-halt"])
  end

  def run(arg) when is_binary(arg) do
    run([arg])
  end
end
