defmodule Jellyfin.Repo.Migrations.InitialSchema do
  use Ecto.Migration

  def up do
    create table("system_info") do
      add(:server_name, :text)
      add(:startup_wizard_completed, :boolean)
      add(:server_id, :uuid, primary_key: true)
    end

    # a library kind maps to a distinct library layout
    # e.g. music/movies/ebooks
    # each has a list of mimetypes that will be indexed by the library
    create table("library_kinds") do
      # display name
      add(:name, :text)
      # user shown description
      add(:description, :text)
      # which mime types we will index libraries of this nature
      add(:allowed_mime_types, {:array, :string})
    end

    # table holds all media collections, a set of folders grouped into
    create table("libraries") do
      # displayed name
      add(:name, :text)
      # text description of library
      add(:description, :text)
      # which uri schemes will we allow? e.g. file / https / ssh+rsync / smb
      add(:allowed_uri_schemes, {:array, :string})
    end

    # intersect table for libraries and library_kinds
    create table("libraries_x_library_kinds", primary_key: false) do
      add(:kind, references("library_kinds", on_delete: :restrict))
      add(:library, references("libraries", on_delete: :delete_all))
    end

    # holds all sources of our own media, be it local or remotely hosted.
    create table("library_data_sources") do
      # uri of the underlying library where we scan.
      add(:root_uri, :text)
      add(:library, references("libraries", on_delete: :delete_all))
    end

    # record of all library scans we did
    create table("library_scans") do
      # when this scan ended, nil if still going
      add(:ended_at, :time, null: true)
      # null if the job succeeded otherwise holds error info.
      add(:error, :map, null: true)
      # when this scan started at
      add(:started_at, :time, [:default, fragment("now()")])
      # this job was canceled or interrupted?
      add(:canceled, :bool)
      add(:parent, references("library_data_sources", on_delete: :delete_all))
    end

    # a distinct file or resource holding indexed media
    create table("media_items") do
      # path relative to library root uri where this file is located.
      add(:path, :text)
      add(:parent, references("library_data_sources", on_delete: :delete_all))
    end

    # providers of metadata
    create table("metadata_providers") do
      # display name
      add(:name, :text)
      # who made this provider
      add(:author, :text)
      # url to maintainer's git repo
      add(:repo_url, :text)
      # send bug reports here url
      add(:issue_url, :text)
      # a pile of jsonb that tells us how the metadata provider works, e.g. how to call it etc.
      add(:metadata, :map)
    end

    # this table holds ALL media metadata.
    # GD i love jsonb, this table lets us dump a huge pile of json into the database and index on parts of it.
    create table("media_item_metadata") do
      # jsonb blob of metadata
      add(:data, :map)
      add(:source, references("metadata_providers"))
      # the media item the metadata refers to
      add(:item, references("media_items", on_delete: :delete_all))
    end
  end

  def down do
    drop(table("media_item_metadata"))
    drop(table("metadata_providers"))
    drop(table("media_items"))
    drop(table("library_scans"))
    drop(table("libraries_x_library_kinds"))
    drop(table("library_data_sources"))
    drop(table("libraries"))
    drop(table("library_kinds"))
    drop(table("system_info"))
  end
end
