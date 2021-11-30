defmodule CryptoPayments.CreatePaymentService do
  alias CryptoPayments.{EtherscanAPI, Payments}

  def create(tx_hash) do
    with {:ok, tx_details} <- EtherscanAPI.transaction_details(tx_hash),
         {:ok, payments} <- Payments.create_payment(tx_details) do
      :ok
    end
  end
end
