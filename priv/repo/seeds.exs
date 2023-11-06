# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Jellyfin.Repo.insert!(%Jellyfin.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Jellyfin.Repo.insert!(%Jellyfin.SystemInfo{
  server_name: "jellyfin",
  startup_wizard_completed: false
})
