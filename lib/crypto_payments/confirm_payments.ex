defmodule CryptoPayments.ConfirmPayments do
  use GenServer
  alias CryptoPayments.{CurrentBlock, Payments}

  @update_interval 10000

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl true
  def init(state) do
    schedule_payment_updates()
    {:ok, state}
  end

  @impl true
  def handle_info(:maybe_update_pending_payments, state) do
    # get current block number and update confirmed transactions
    CurrentBlock.current_state(CurrentBlock) |> Payments.update_pending_payments()

    schedule_payment_updates()

    {:noreply, state}
  end

  defp schedule_payment_updates do
    # schedule update to happen every 10 seconds (written in milliseconds).
    Process.send_after(self(), :maybe_update_pending_payments, @update_interval)
  end
end
