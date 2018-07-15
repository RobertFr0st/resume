# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :resume,
  ecto_repos: [Resume.Repo]

# Configures the endpoint
#secret key is to localhost, production key is not tracked on vc
config :resume, Resume.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cqGx8GflxkFuMtYrmNxxWQV7PxyVAz1KnVENdAiZSY7sTZkaU9PZGaHyPwzNfczF",
  render_errors: [view: Resume.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Resume.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#enviromental configurations
import_config "#{Mix.env}.exs"
