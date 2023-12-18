defmodule Jellyfin.Routes.System do
  use Plug.Router

  import Jason
  import Jason.Helpers

  plug(:match)
  plug(:dispatch)

  def send_json(conn, status, obj) do
    body = Jason.encode!(obj)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end

  get "/Public/Info" do
    obj = Jason.Helpers.json_map(ID: "fug")
    conn |> send_json(:ok, obj)
  end

  get _ do
    send_resp(conn, :not_found, "")
  end
end
