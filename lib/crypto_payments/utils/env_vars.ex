defmodule CryptoPayments.Utils.EnvVars do
  def base_url, do: Application.get_env(:crypto_payments, :base_url)
  def api_key, do: Application.get_env(:crypto_payments, :api_key)
end
