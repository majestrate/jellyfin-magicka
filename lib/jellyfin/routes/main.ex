defmodule Jellyfin.Routes.Main do
  use Plug.Router
  use Plug.ErrorHandler

  get "/" do
    send_resp(conn, :ok, "jellyfin")
  end

  defp redirect_to(conn, to) do
    conn
    |> resp(:found, "")
    |> put_resp_header("location", to)
    |> send_resp()
  end

  get "/web/" do
    conn |> redirect_to("/web/index.html")
  end

  get "/web/*glob" do
    path = Path.join(conn.path_info) |> String.replace("%40", "@")

    fname =
      :code.priv_dir(:jellyfin)
      |> Path.join(path)

    cond do
      File.exists?(fname) -> send_file(conn, :ok, fname)
      true -> send_resp(conn, :not_found, "")
    end
  end

  get "/_version" do
    resp =
      case :application.get_key(:jellyfin, :vsn) do
        {:ok, vsn} -> vsn
        _ -> "no version found"
      end

    send_resp(conn, :ok, resp)
  end

  forward("/System", to: Jellyfin.Routes.System)

  get _ do
    send_resp(conn, :not_found, "")
  end

  match _ do
    send_resp(conn, :method_not_allowed, "")
  end
end
