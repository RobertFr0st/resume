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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Resume.User,
  repo: Resume.Repo,
  module: Resume,
  logged_out_url: "/",
  email_from_name: "Nicholas Kelley",
  email_from_email: "nickdk.1995@gmail.com",
  opts: [:authenticatable, :recoverable, :lockable, :unlockable_with_token]

config :coherence, Resume.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
