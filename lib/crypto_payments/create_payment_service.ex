defmodule CryptoPayments.CreatePaymentService do
  alias CryptoPayments.{EtherscanApiHttpClient, Payments}

  def create(tx_hash) do
    case EtherscanApiHttpClient.transaction_details(tx_hash) do
      {:ok, %{"result" => nil}} ->
        {:error, :transaction_not_found}

      {:ok,
       %{
         "result" => %{
           "blockHash" => blockHash,
           "blockNumber" => blockNumber,
           "hash" => txHash,
           "value" => value
         }
       }} ->
        blockNumber = EtherscanApiHttpClient.hex_to_int(blockNumber)
        value = EtherscanApiHttpClient.hex_to_int(value)

        %{
          blockHash: blockHash,
          blockNumber: blockNumber,
          transactionHash: txHash,
          value: value
        }
        |> Payments.create_payment()

      {:ok, %{"error" => %{"message" => _message}}} ->
        {:error, :invalid_tx_hash}
    end
  end
end
