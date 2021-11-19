defmodule CryptoPaymentsWeb.PaymentsLive do
  use CryptoPaymentsWeb, :live_view
  alias CryptoPayments.EtherscanApiHttpClient

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
           "blockNumber" => "0x4b9b05",
           "gasUsed" => "0x5208",
           "logs" => [],
           "status" => "0x1",
           "transactionHash" => _hash,
           "transactionIndex" => "0xa0",
           "type" => "0x0"
         }
       }} ->
        {:noreply, socket |> put_flash(:info, "Payment received pending confirmation")}

      {:ok, %{"error" => %{"message" => message}}} ->
        {:noreply, socket |> put_flash(:error, message)}
    end
  end
end
