defmodule JellyfinElixirTest do
  use ExUnit.Case
  doctest JellyfinElixir

  test "greets the world" do
    assert JellyfinElixir.hello() == :world
  end
end
