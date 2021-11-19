defmodule CryptoPayments.EtherscanApiHttpClient do
  @moduledoc """
  Sawa API implementation
  """
  import CryptoPayments.HttpClient
  import CryptoPayments.Utils.EnvVars

  def transaction_details(txhash) when is_binary(txhash) do
    url =
      base_url() <>
        "?module=proxy&action=eth_getTransactionReceipt&txhash=#{txhash}&apikey=#{api_key()}"

    get(url)
  end

  def most_recent_block do
    url =
      base_url() <>
        "?module=proxy&action=eth_blockNumber&apikey=#{api_key()}"

    get(url)

    # {:ok, %{"id" => 83, "jsonrpc" => "2.0", "result" => "0xd03c78"}}
  end
end
