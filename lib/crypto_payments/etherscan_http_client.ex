defmodule CryptoPayments.EtherscanApiHttpClient do
  @moduledoc """
  Sawa API implementation
  """
  import CryptoPayments.HttpClient
  import CryptoPayments.Utils.EnvVars

  def transaction_details(txhash) when is_binary(txhash) do
    url =
      base_url() <>
        "?module=proxy&action=eth_getTransactionByHash&txhash=#{txhash}&apikey=#{api_key()}"

    get(url)
  end

  def most_recent_block do
    url =
      base_url() <>
        "?module=proxy&action=eth_blockNumber&apikey=#{api_key()}"

    {:ok, %{"result" => block_number}} = get(url)
    hex_to_int(block_number)
  end

  def hex_to_int(block_number) do
    {block_number, _} = Integer.parse(String.trim_leading(block_number, "0x"), 16)
    block_number
  end
end
