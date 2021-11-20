defmodule CryptoPayments.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CryptoPayments.Repo,
      # Start the Telemetry supervisor
      CryptoPaymentsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CryptoPayments.PubSub},
      # Start the Endpoint (http/https)
      CryptoPaymentsWeb.Endpoint,
      # Start a worker by calling: CryptoPayments.Worker.start_link(arg)
      # {CryptoPayments.Worker, arg}

      # Start Finch
      {Finch, name: EtherscanApi}
      # CryptoPayments.CurrentBlock
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CryptoPayments.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CryptoPaymentsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
