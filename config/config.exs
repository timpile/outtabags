# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :outtabags,
  ecto_repos: [Outtabags.Repo]

# Configures the endpoint
config :outtabags, OuttabagsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M+v+giEB3hxAc0ngL8JHQH9I8NCQtA8X7OfaaM0Q9rLp/AB8Vi3l7il9sbYzkfPM",
  render_errors: [view: OuttabagsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Outtabags.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
