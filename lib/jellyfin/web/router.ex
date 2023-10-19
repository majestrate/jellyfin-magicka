defmodule Jellyfin.Web.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(Plug.RequestId)

  plug(:match)
  plug(:dispatch)

  forward("/System", to: Jellyfin.Web.Routes.SystemRouter)

  get "/" do
    case conn.query_string do
      "stevejobs" -> send_resp(conn, 410, "LIGMA BALLS")
      _ -> send_resp(conn, 200, "")
    end
  end

  match _ do
    send_resp(conn, 404, "fug")
  end
end
