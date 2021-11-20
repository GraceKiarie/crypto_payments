import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :crypto_payments, CryptoPayments.Repo,
  username: "postgres",
  password: "postgres",
  database: "crypto_payments_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :crypto_payments, CryptoPaymentsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "zaxEqqFf4m8sf9VBYwKrzSv8xPN+BgiCq2Ky7E+24D/7ssuxyAVGk8NyvaGi4cQm",
  server: false

# In test we don't send emails.
config :crypto_payments, CryptoPayments.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :crypto_payments,
  base_url: System.get_env("Etherscan_API_BASE_URL") || "http://localhost:4000",
  api_key: System.get_env("Etherscan_API_KEY") || "ytyjiijtfrydtg"
