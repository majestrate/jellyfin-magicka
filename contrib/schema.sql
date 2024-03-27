

-- shows is a collection of highest level watchable collections
CREATE TABLE IF NOT EXISTS shows (
       id SERIAL PRIMARY KEY,
       name TEXT NOT NULL,
       description TEXT NOT NULL
);

-- show collections is a subdivision of an existing show, like a season.
-- each show collection has a watch order which decides which media files are watched in.
CREATE TABLE IF NOT EXISTS show_collections (
       id SERIAL PRIMARY KEY,
       name TEXT NOT NULL,
       sort_order INTEGER NOT NULL,
       FOREIGN KEY (show_id) REFERENCES (shows.id)
);


-- media sources are all read only places where media can be discovered from
CREATE TABLE IF NOT EXISTS media_sources (
       id SERIAL PRIMARY KEY,
       uri TEXT NOT NULL,
       last_scanned_at TIME NOT NULL,
);

-- media files are read only files that came from media sources.
CREATE TABLE IF NOT EXISTS media_files (
       id SERIAL PRIMARY KEY,
       relative_filepath TEXT NOT NULL, -- filepath relative to media source uri
       last_synced_at TIME NOT NULL, -- last time we synched data from disk
       FOREIGN KEY (media_source_id) REFERENCES (media_sources.id),
       FOREIGN KEY (show_collection_id) REFERENCES (show_collections.id),
);


