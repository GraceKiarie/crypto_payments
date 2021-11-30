defmodule CryptoPaymentsWeb.PaymentsLive do
  use CryptoPaymentsWeb, :live_view
  alias CryptoPayments.CreatePaymentService

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("save", %{"txhash" => hash}, socket) do
    case CreatePaymentService.create(hash) do
      {:error, :no_tansaction_found} ->
        {:noreply,
         socket
         |> put_flash(
           :info,
           "No transaction exists for the given hash. Please confirm and try again"
         )}

      :ok ->
        {:noreply, socket |> put_flash(:info, "Payment received pending confirmation")}

      {:error, :invalid_tx_hash} ->
        {:noreply, socket |> put_flash(:error, "Please enter a valid tx_hash")}
    end
  end
end
