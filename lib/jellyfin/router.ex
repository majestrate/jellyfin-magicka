
defmodule Jellyfin.Router do

  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  plug Jellyfin.WebUI

  defp goto_webui(conn) do
    conn |> put_resp_header("location", "/web/index.html") |> send_resp(302, "")  
  end
  
  get "/" do
    goto_webui(conn)
  end

  get "/web/" do
    goto_webui(conn)
  end
  forward "/web", to: Jellyfin.WebUI

  forward "/system/info/public", to: Jellyfin.SystemInfo
  
  match _ do
    send_resp(conn, 404, "not found")
  end
end
