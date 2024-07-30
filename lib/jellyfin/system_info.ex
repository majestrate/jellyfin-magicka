defmodule Jellyfin.SystemInfo do
  use Plug.Builder

  defp wizard_completed() do
    # todo
    false
  end

  defp sysinfo_part(symbol) do
    Application.fetch_env!(:jellyfin, symbol)
  end

  defp localaddr() do
    # todo
    "127.0.0.1:8000"
  end

  defp sysinfo() do
    [
      LocalAddress: localaddr(),
      ServerName: sysinfo_part(:server_name),
      Version: sysinfo_part(:version),
      ProductName: sysinfo_part(:product_name),
      OperatingSystem: sysinfo_part(:os),
      Id: sysinfo_part(:id),
      StartupWizardCompleted: wizard_completed()
    ]
  end

  plug(:serve)

  def serve(conn, _) do
    body = JSON.encode!(sysinfo())
    send_resp(conn, 200, body)
  end
end
