defmodule Jellyfin.Repo.Migrations.InitialSchema do
  use Ecto.Migration

  defmodule Private do
    # helper for overriding defaults.
    # TODO: figure out where this goes.
    def add(col, name, opts \\ []) do
      Ecto.Migration.add(col, name, opts)
    end
  end

  def up do
    # a library kind maps to a distinct library layout
    # e.g. music/movies/ebooks
    # each has a list of mimetypes that will be indexed by the library
    create table("library_kinds") do
      # display name
      Private.add(:name, :text)
      # user shown description
      Private.add(:description, :text)
      # which mime types we will index libraries of this nature
      Private.add(:allowed_mime_types, {:array, :string})
    end

    # table holds all media collections, a set of folders grouped into
    create table("libraries") do
      # displayed name
      Private.add(:name, :text)
      # text description of library
      Private.add(:description, :text)
      # which uri schemes will we allow? e.g. file / https / ssh+rsync / smb
      Private.add(:allowed_uri_schemes, {:array, :string})
    end

    # intersect table for libraries and library_kinds
    create table("libraries_x_library_kinds", primary_key: false) do
      Private.add(:kind, references("library_kinds", on_delete: :restrict))
      Private.add(:library, references("libraries", on_delete: :delete_all))
    end

    # holds all sources of our own media, be it local or remotely hosted.
    create table("library_data_sources") do
      # uri of the underlying library where we scan.
      Private.add(:root_uri, :text)
      Private.add(:library, references("libraries", on_delete: :delete_all))
    end

    # record of all library scans we did
    create table("library_scans") do
      # when this scan ended, nil if still going
      Private.add(:ended_at, :time, null: true)
      # null if the job succeeded otherwise holds error info.
      Private.add(:error, :map, null: true)
      # when this scan started at
      Private.add(:started_at, :time, [:default, fragment("now()")])
      # this job was canceled or interrupted?
      Private.add(:canceled, :bool)
      Private.add(:parent, references("library_data_sources", on_delete: :delete_all))
    end

    # a distinct file or resource holding indexed media
    create table("media_items") do
      # path relative to library root uri where this file is located.
      Private.add(:path, :text)
      Private.add(:parent, references("library_data_sources", on_delete: :delete_all))
    end

    # providers of metadata
    create table("metadata_providers") do
      # display name
      Private.add(:name, :text)
      # who made this provider
      Private.add(:author, :text)
      # url to maintainer's git repo
      Private.add(:repo_url, :text)
      # send bug reports here url
      Private.add(:issue_url, :text)
      # a pile of jsonb that tells us how the metadata provider works, e.g. how to call it etc.
      Private.add(:metadata, :map)
    end

    # this table holds ALL media metadata.
    # GD i love jsonb, this table lets us dump a huge pile of json into the database and index on parts of it.
    create table("media_item_metadata") do
      # jsonb blob of metadata
      Private.add(:data, :map)
      Private.add(:source, references("metadata_providers"))
      # the media item the metadata refers to
      Private.add(:item, references("media_items", on_delete: :delete_all))
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
  end
end
