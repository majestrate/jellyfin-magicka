defmodule JellyfinWeb.PublicInfo do
  use JellyfinWeb, :controller

  def render(info) do
    Jason.encode!(info)
  end
end
