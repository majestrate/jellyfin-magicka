defmodule Jellyfin.SystemInfo do
  def public(:LocalAddress) do
    "127.0.0.1:4000"
  end

  def public(:Version) do
    "placeholder-version-here"
  end

  def public(:ProductName) do
    "jellyfin-magicka"
  end

  def public(:OperatingSystem) do
    {:unix, name} = :os.type()

    ver =
      case :os.version() do
        {major, minor, patch} = x when is_tuple(x) -> "#{major}.#{minor}.#{patch}"
        x -> "#{x}"
      end

    "#{name}-#{ver}"
  end

  def public(:Id) do
    "placeholder-id"
  end

  def public(:ServerName) do
    "placeholder server name"
  end

  def public(:StartupWizardCompleted) do
    false
  end

  @public_info_keys [
    :LocalAddress,
    :ServerName,
    :Version,
    :ProductName,
    :OperatingSystem,
    :Id,
    :StartupWizardCompleted
  ]

  def pub_info() do
    Map.new(@public_info_keys, &{&1, public(&1)})
  end
end
