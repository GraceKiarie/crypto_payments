defmodule CryptoPayments.CurrentBlock do
  use GenServer
  alias CryptoPayments.EtherscanApiHttpClient

  def start_link(_) do
    state = EtherscanApiHttpClient.most_recent_block()
    GenServer.start_link(__MODULE__, state, name: Block)
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_call(:current_state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:update, _state) do
    # update state
    new_state = EtherscanApiHttpClient.most_recent_block()
    # Reschedule once more
    schedule_work()

    {:noreply, new_state}
  end

  def current_state(server_name) do
    GenServer.call(server_name, :current_state)
  end

  defp schedule_work do
    # schedule update to happen every 5 seconds (written in milliseconds).
    Process.send_after(self(), :update, 5000)
  end
end
