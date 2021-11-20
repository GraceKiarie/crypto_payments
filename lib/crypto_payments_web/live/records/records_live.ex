defmodule CryptoPaymentsWeb.RecordsLive do
  use CryptoPaymentsWeb, :live_view
  alias CryptoPayments.Payments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :payments, Payments.list_payments())}
  end
end
