use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :resume, Resume.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :resume, Resume.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "resume_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Resume.User,
  repo: Resume.Repo,
  module: Resume,
  logged_out_url: "/",
  email_from_name: "Bob Ross",
  email_from_email: "example@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, Resume.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "wow"
# %% End Coherence Configuration %%
