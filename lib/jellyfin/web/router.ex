defmodule Jellyfin.Web.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  forward("/System", to: Jellyfin.Web.Routes.SystemRouter)

  get "/ligma" do
    send_resp(conn, 200, "ligma balls")
  end

  match _ do
    send_resp(conn, 404, "fug")
  end
end
