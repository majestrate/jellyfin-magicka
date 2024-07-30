defmodule JellyfinTest do
  use ExUnit.Case
  doctest Jellyfin

  test "greets the world" do
    assert Jellyfin.hello() == :world
  end
end
