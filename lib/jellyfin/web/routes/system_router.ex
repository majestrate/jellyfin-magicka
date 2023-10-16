defmodule Jellyfin.Web.Routes.SystemRouter do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/Info/Public" do
    body = "asd"
    send_resp(conn, 200, body)
  end
end
