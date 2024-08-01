defmodule Jellyfin.UserController do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    # TODO: list users
    conn |> put_resp_header("content-type", "application/json") |> send_resp(200, "[]")
  end

  post "/" do
    # TODO: upsert user
    conn |> put_resp_header("content-type", "application/json") |> send_resp(403, "{}")
  end

  match _ do
    conn |> put_resp_header("content-type", "application/json") |> send_resp(404, "")
  end
end
