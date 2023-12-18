defmodule JellyfinTest.APIServerTest do
  alias Jellyfin.APIServer
  use JellyfinTest.Plug, APIServer

  test "check static pages" do
    :ok =
      req_and_test("/")
      |> was_sent_and()
      |> was_redirected_to_and("/web/")
      |> ok()

    :ok =
      req_and_test("/web/")
      |> was_sent_and()
      |> was_redirected_to_and("/web/index.html")
      |> ok()

    :ok =
      req_and_test("/web/index.html")
      |> was_sent_and(:file)
      |> was_ok_and()
      |> ok()
  end

  test "check base case" do
    :ok =
      req_and_test("/", :put)
      |> was_sent_and()
      |> had_status_and(:method_not_allowed)
      |> ok()
  end

  test "public server info works" do
    :ok =
      req_and_test("/System/Public/Info")
      |> was_sent_and()
      |> was_ok_and()
      |> had_content_type_and("json")
      |> ok()
  end
end
