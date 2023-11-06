defmodule JellyfinWeb.PublicInfoTest do
  use JellyfinWeb.ConnCase, async: true

  alias Jellyfin.SystemInfo

  test "public info json is served" do
    info = Jellyfin.Repo.one!(SystemInfo)
    j_info = info |> SystemInfo.as_map()
    IO.inspect(info)
    IO.inspect(j_info)

    refute j_info == nil
  end
end
