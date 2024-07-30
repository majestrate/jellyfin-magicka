defmodule Jellyfin.SystemInfo do

  use Plug.Builder


  
  defp wizard_completed() do
    false # todo
  end
  
  defp sysinfo() do
    [LocalAddress: "127.0.0.1:8000", ServerName: "jellyfin magicka", Version: "10.9.1", ProductName: "Jellyfin Magicka", OperatingSystem: "Linux", Id: "some-id-goes-here", StartupWizardCompleted: wizard_completed()]
  end


  plug :serve


  def serve(conn, _) do
    body = JSON.encode!(sysinfo())
    send_resp(conn, 200, body)
  end

end
