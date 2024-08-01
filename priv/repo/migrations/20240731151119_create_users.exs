defmodule Jellyfin.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    create table("users") do
      add :name, :string, null: false
      add :password, :string
      add :primary_image_tag, :string
      add :last_login_at, :utc_datetime, null: false
      add :last_activity_at, :utc_datetime, null: false
      add :disabled, :boolean, null: false
      add :hidden, :boolean, null: false

      timestamps()
    end
  end

  def down do
    drop table("users")
  end
end
