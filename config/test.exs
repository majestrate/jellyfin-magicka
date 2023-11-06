import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :jellyfin, Jellyfin.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "jellyfin_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jellyfin, JellyfinWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "yV7P/M8U1xF/yvJDNb2K1Yiq+tJGB3BJpyYAOWTD7lhkEkKImqeTL1Htm+naKb+o",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :jellyfin, Jellyfin.Repo,
  username: "jeff",
  password: "jeff",
  hostname: "localhost",
  database: "jellyfin_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jellyfin, JellyfinWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "1qUm9uPqusqrGxMPfvcpaTJ2f7BvZfSDSEyzIdfnB5d0Oe5toLVeBSJuXTw4e6tg",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
