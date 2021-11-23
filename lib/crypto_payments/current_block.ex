defmodule CryptoPayments.CurrentBlock do
  use GenServer
  alias CryptoPayments.EtherscanApiHttpClient

  @update_interval 5000

  def start_link(_) do
    latest_block_number = EtherscanApiHttpClient.most_recent_block()
    GenServer.start_link(__MODULE__, latest_block_number, name: __MODULE__)
  end

  def current_state(server_name) do
    GenServer.call(server_name, :latest_block_number)
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_call(:latest_block_number, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:update, _state) do
    # update latest_block_number
    latest_block_number = EtherscanApiHttpClient.most_recent_block()
    # Reschedule once more
    schedule_work()

    {:noreply, latest_block_number}
  end

  defp schedule_work do
    # schedule update to happen every 5 seconds (written in milliseconds).
    Process.send_after(self(), :update, @update_interval)
  end
end
