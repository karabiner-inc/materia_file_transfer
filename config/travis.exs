use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :materia_file_transfer, MateriaFileTransferWeb.Test.Endpoint,
  http: [port: 4001],
  # server: false,
  debug_errors: true,
  code_reloader: false,
  check_origin: false,
  watchers: []

# Print only warnings and errors during test
config :logger, level: :info

# Configure your database
config :materia_file_transfer, MateriaFileTransfer.Test.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "materia_file_transfer_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :materia_file_transfer, repo: MateriaFileTransfer.Test.Repo

# Configures GuardianDB
config :guardian, Guardian.DB,
  repo: MateriaFileTransfer.Test.Repo,
  # default
  schema_name: "guardian_tokens",
  # token_types: ["refresh_token"], # store all token types if not set
  # default: 60 minutes
  sweep_interval: 60
