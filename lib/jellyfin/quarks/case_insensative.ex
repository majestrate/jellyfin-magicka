defmodule Jellyfin.Quarks.CaseInsensative do
  def init(opts), do: opts

  def call(conn, _params) do
    conn
    |> Map.put(:path_info, Enum.map(conn.path_info, &String.downcase(&1)))
    |> Map.put(:request_path, String.downcase(conn.request_path))
  end
end
