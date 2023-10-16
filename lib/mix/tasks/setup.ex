defmodule Mix.Tasks.Jellyfin.Setup do
  @moduledoc "Jellyfin Setup tool

  usage: mix jellyfin.setup genconf [--interactive]

  "

  @shortdoc "Jellyfin Setup tool"

  use Mix.Task

  defguardp command_is(args, cmd) when hd(args) == cmd

  @impl Mix.Task
  def run(args) when command_is(args, "genconf") do
    _interactive = Enum.member?(args, "--interactive")
  end

  @impl Mix.Task
  def run(args) when length(args) == 0 or command_is(args, "help") do
    Mix.shell().info([@moduledoc])
  end
end
