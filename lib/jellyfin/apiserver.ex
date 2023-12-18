defmodule Jellyfin.APIServer do
  use Plug.Router
  use Plug.ErrorHandler

  import Jason
  import Jason.Helpers

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  defp redirect_to(conn, to) do
    conn
    |> resp(:found, "")
    |> put_resp_header("location", to)
    |> send_resp()
  end

  defp send_json(conn, status, obj) do
    body = Jason.encode!(obj)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end

  defp serve_webui(conn) do
    path = Path.join(conn.path_info) |> String.replace("%40", "@")

    fname =
      :code.priv_dir(:jellyfin)
      |> Path.join(path)

    cond do
      File.exists?(fname) -> send_file(conn, :ok, fname)
      true -> send_resp(conn, :not_found, "")
    end
  end

  def serve_public_info(conn) do
    obj = Jason.Helpers.json_map(ID: "fug")
    conn |> send_json(:ok, obj)
  end

  get "/web/" do
    conn |> redirect_to("/web/index.html")
  end

  get "/web/*glob" do
    serve_webui(conn)
  end

  get "/_version" do
    resp =
      case :application.get_key(:jellyfin, :vsn) do
        {:ok, vsn} -> vsn
        _ -> "no version found"
      end

    send_resp(conn, :ok, resp)
  end

  get "/System/Public/Info" do
    serve_public_info(conn)
  end

  get "/" do
    conn |> redirect_to("/web/")
  end

  get _ do
    send_resp(conn, :not_found, "")
  end

  match _ do
    send_resp(conn, :method_not_allowed, "")
  end
end
