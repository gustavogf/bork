use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :bork, BorkWeb.Endpoint,
  secret_key_base: "F7s1LNkStM2RoAE0NEoLwGJ0HtmpYE5EYYSDgvfZRGBdotPWBWpfgL4v852UlQMg"

# Configure your database
config :bork, Bork.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "bork_prod",
  pool_size: 15
