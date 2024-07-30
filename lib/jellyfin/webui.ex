defmodule Jellyfin.WebUI do
  use Plug.Builder

  plug(Plug.Static,
    at: "/web",
    from: "priv/web/jellyfin-web/dist"
  )
end
