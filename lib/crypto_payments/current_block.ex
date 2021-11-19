defmodule CryptoPayments.CurrentBlock do
  use GenServer
  alias CryptoPayments.EtherscanApiHttpClient

  def start_link(_) do
    state = EtherscanApiHttpClient.most_recent_block()
    GenServer.start_link(__MODULE__, state)
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    # Do the desired work here
    # ...
    new_state = EtherscanApiHttpClient.most_recent_block()
    IO.inspect(state)

    if new_state > state do
      # update transactions
      IO.inspect("the diff is #{new_state - state}", label: "state")
    end

    # Reschedule once more
    schedule_work()

    {:noreply, new_state}
  end

  defp schedule_work do
    # We schedule update to happen every 5 seconds (written in milliseconds).
    Process.send_after(self(), :work, 5000)
  end
end
