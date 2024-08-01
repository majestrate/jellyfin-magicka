defmodule JellyfinTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @options Jellyfin.Router.init([])

  test "public system info fetches fine" do
    {status, _headers, _body} =
      conn(:get, "/system/info/public")
      |> Jellyfin.Router.call(@options)
      |> Plug.Test.sent_resp()

    assert status == 200
  end

  test "fetch users" do
    {status, _headers, _body} =
      conn(:get, "/users")
      |> Jellyfin.Router.call(@options)
      |> Plug.Test.sent_resp()

    assert status == 200
  end
end
