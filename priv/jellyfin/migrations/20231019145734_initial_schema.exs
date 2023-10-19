defmodule Jellyfin.Repo.Migrations.InitialSchema do

    use Ecto.Migration

    defmodule Private do

        def fix_add_opts(opts) when is_list(opts) do
            opts ++ if Enum.member?(opts, [null: true]) do [] else [null: false] end
        end

        def fix_add_opts(opts) when not is_nil(opts) do
            [opts] |> fix_add_opts
        end

        def fix_add_opts(opts) do
            opts
        end



        def add(column, type, opts \\ []) do
            Ecto.Migration.add column, type, fix_add_opts(opts)
        end

        def drop(col_or_const, opts \\ []) do
            Ecto.Migration.drop(col_or_const, opts)
        end

    end

    @self Private


    def up do

        # a library kind maps to a distinct library layout
        # e.g. music/movies/ebooks
        # each has a list of mimetypes that will be indexed by the library
        create table("library_kinds") do
            @self.add :name, :text # display name
            @self.add :description, :text # user shown description
            @self.add :allowed_mime_types, {:array, :string} # which mime types we will index libraries of this nature
        end

        # table holds all media collections, a set of folders grouped into
        create table("libraries") do
            @self.add :name, :text# displayed name
            @self.add :description, :text # text description of library
            @self.add :allowed_uri_schemes, {:array, :string} # which uri schemes will we allow? e.g. file / https / ssh+rsync / smb
        end

        # intersect table for libraries and library_kinds
        create table("libraries_x_library_kinds", primary_key: false) do
            @self.add :kind, references("library_kinds", [on_delete: :restrict])
            @self.add :library, references("libraries", [on_delete: :delete_all])
        end

        # holds all sources of our own media, be it local or remotely hosted.
        create table("library_data_sources") do
            @self.add :root_uri, :text # uri of the underlying library where we scan.
            @self.add :library, references("libraries", [on_delete: :delete_all])
        end

        # record of all library scans we did
        create table("library_scans") do
            @self.add :ended_at, :time, [null: true] # when this scan ended, nil if still going
            @self.add :error, :map, [null: true] # null if the job succeeded otherwise holds error info.
            @self.add :started_at, :time, [:default, fragment("now()")] # when this scan started at
            @self.add :canceled, :bool # this job was canceled or interrupted?
            @self.add :parent, references("library_data_sources", [on_delete: :delete_all])
        end

        # a distinct file or resource holding indexed media
        create table("media_items") do
            @self.add :path, :text # path relative to library root uri where this file is located.
            @self.add :parent, references("library_data_sources", [on_delete: :delete_all])
        end

        # providers of metadata
        create table("metadata_providers") do
            @self.add :name, :text # display name
            @self.add :author, :text # who made this provider
            @self.add :repo_url, :text # url to maintainer's git repo
            @self.add :issue_url, :text # send bug reports here url
            @self.add :metadata, :map # a pile of jsonb that tells us how the metadata provider works, e.g. how to call it etc.
        end

        # this table holds ALL media metadata.
        # GD i love jsonb, this table lets us dump a huge pile of json into the database and index on parts of it.
        create table("media_item_metadata") do
            @self.add :data, :map #jsonb blob of metadata
            @self.add :source, references("metadata_providers")
            @self.add :item , references("media_items", [on_delete: :delete_all]) # the media item the metadata refers to
        end

    end

    def down do
        @self.drop table("media_item_metadata")
        @self.drop table("metadata_providers")
        @self.drop table("media_items")
        @self.drop table("library_scans")
        @self.drop table("libraries_x_library_kinds")
        @self.drop table("library_data_sources")
        @self.drop table("libraries")
        @self.drop table("library_kinds")
    end

end
