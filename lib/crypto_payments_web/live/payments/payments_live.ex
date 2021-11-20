defmodule CryptoPaymentsWeb.PaymentsLive do
  use CryptoPaymentsWeb, :live_view
  alias CryptoPayments.{EtherscanApiHttpClient, Payments}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("save", %{"txhash" => hash}, socket) do
    case EtherscanApiHttpClient.transaction_details(hash) do
      {:ok, %{"result" => nil}} ->
        {:noreply,
         socket
         |> put_flash(
           :info,
           "No transaction exists for the given hash. Please confirm and try again"
         )}

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

        {:noreply, socket |> put_flash(:info, "Payment received pending confirmation")}

      {:ok, %{"error" => %{"message" => _message}}} ->
        {:noreply, socket |> put_flash(:error, "Please enter a valid tx_hash")}
    end
  end
end
