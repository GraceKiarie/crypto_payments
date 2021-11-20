defmodule CryptoPayments.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CryptoPayments.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        blockHash: "some blockHash",
        blockNumber: 42,
        transactionHash: "some transactionHash",
        value: 120.5
      })
      |> CryptoPayments.Payments.create_payment()

    payment
  end
end
