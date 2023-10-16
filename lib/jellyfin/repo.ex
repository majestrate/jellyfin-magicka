defmodule Jellyfin.Repo do
  use Ecto.Repo,
      Keyword.merge(Application.compile_env(:jellyfin, :db), otp_app: :jellyfin)
end
