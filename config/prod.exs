use Mix.Config

config :resume, Resume.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "fierce-brook-69606.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :resume, Resume.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Resume.User,
  repo: Resume.Repo,
  module: Resume,
  logged_out_url: "/",
  email_from_name: System.get_env("NAME_FROM"),
  email_from_email: System.get_env("EMAIL_FROM"),
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, Resume.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("SENDGRID_APIKEY")
# %% End Coherence Configuration %%

# Do not print debug messages in production
config :logger, level: :info
