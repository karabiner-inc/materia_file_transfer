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
config :logger, level: :debug

# Configure your database
config :materia_file_transfer, MateriaFileTransfer.Test.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
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

# mail settings
config :materia, Materia.Mails.MailClient, client_module: Materia.Mail.MailClientStub

config :sendgrid, api_key: System.get_env("SENDGRID_API_KEY") || ""

config :materia, Materia.Accounts,
  system_from_email: "team_bi@karabiner.tech",
  # not effect when use Materia.Mails.MailClientAwsSes
  system_from_name: "カラビナテクノロジーテスト事務局",
  user_registration_request_mail_template_type: "user_registration_request",
  user_registration_url: "hogehoge.example.com/user-registration",
  user_registration_completed_mail_template_type: "user_registration_completed",
  sign_in_url: "hogehoge.example.com/sign-in",
  password_reset_request_mail_template_type: "password_reset_request",
  password_reset_url: "hogehoge.example.com/pw-reset",
  password_reset_completed_mail_template_type: "password_reset_completed"

config :goth, config_module: MateriaFileTransfer.GoogleCloud.ConfigStub
# config :goth, config_module: MateriaFileTransfer.GoogleCloud.Config

config :materia, bucket_id: System.get_env("BUCKET_ID")
