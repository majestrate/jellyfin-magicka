defmodule Jellyfin.SystemInfo do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:server_id, FlakeId.Ecto.Type, autogenerate: true}

  def public(_info, :LocalAddress) do
    "127.0.0.1:4000"
  end

  def public(_info, :Version) do
    "placeholder-version-here"
  end

  def public(_info, :ProductName) do
    "jellyfin-magicka"
  end

  def public(_info, :OperatingSystem) do
    {:unix, name} = :os.type()

    ver =
      case :os.version() do
        {major, minor, patch} = x when is_tuple(x) -> "#{major}.#{minor}.#{patch}"
        x -> "#{x}"
      end

    "#{name}-#{ver}"
  end

  def public(info, :server_id) do
    info.server_id
  end

  def public(info, :server_name) do
    info.server_name
  end

  def public(info, :startup_wizard_completed) do
    info.startup_wizard_completed
  end

  def public(info, :ServerName) do
    public(info, :server_name)
  end

  def public(info, :Id) do
    public(info, :server_id)
  end

  def public(info, :StartupWizardCompleted) do
    public(info, :startup_wizard_completed)
  end

  schema "system_info" do
    field(:server_name, :string)
    field(:startup_wizard_completed, :boolean)
  end

  @db_keys [:server_name, :startup_wizard_completed, :server_id]

  def changeset(user, attrs) do
    user
    |> cast(attrs, @db_keys)
    |> validate_required(@db_keys)
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

  def as_map(info) do
    Map.new(@public_info_keys, &{&1, public(info, &1)})
  end
end
