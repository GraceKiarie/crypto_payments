defmodule CryptoPayments.EtherscanAPI do
  @moduledoc """
  Sawa API implementation
  """
  alias CryptoPayments.HttpClient
  import CryptoPayments.Utils.EnvVars

  def transaction_details(txhash) when is_binary(txhash) do
    url =
      "#{base_url()}?module=proxy&action=eth_getTransactionByHash&txhash=#{txhash}&apikey=#{api_key()}"

    url |> HttpClient.get() |> handle_transaction_details_response()
  end

  def most_recent_block do
    url = "#{base_url()}?module=proxy&action=eth_blockNumber&apikey=#{api_key()}"

    {:ok, %{"result" => block_number}} = HttpClient.get(url)
    hex_to_int(block_number)
  end

  def hex_to_int(block_number) do
    {block_number, _} = Integer.parse(String.trim_leading(block_number, "0x"), 16)
    block_number
  end

  defp handle_transaction_details_response(
         {:ok,
          %{
            "error" => %{
              "code" => -32602
            }
          }}
       ) do
    {:error, :invalid_tx_hash}
  end

  defp handle_transaction_details_response({:ok, %{"result" => nil}}) do
    {:error, :transaction_not_found}
  end

  defp handle_transaction_details_response(
         {:ok,
          %{
            "result" => %{
              "blockHash" => blockHash,
              "blockNumber" => blockNumber,
              "hash" => txHash,
              "value" => value
            }
          }}
       ) do
    blockNumber = hex_to_int(blockNumber)
    value = hex_to_int(value)

    tx_details = %{
      blockHash: blockHash,
      blockNumber: blockNumber,
      transactionHash: txHash,
      value: value
    }

    {:ok, tx_details}
  end
end
