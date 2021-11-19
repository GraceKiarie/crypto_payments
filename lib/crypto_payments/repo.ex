defmodule CryptoPayments.Repo do
  use Ecto.Repo,
    otp_app: :crypto_payments,
    adapter: Ecto.Adapters.Postgres
end
