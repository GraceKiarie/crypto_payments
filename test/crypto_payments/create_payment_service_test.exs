defmodule CryptoPayments.CreatePaymentServiceTest do
  use CryptoPayments.DataCase
  alias CryptoPayments.CreatePaymentService

  test "receive payment - with valid tx hash" do
    tx_hash = "0xbc78ab8a9e9a0bca7d0321a27b2c03addeae08ba81ea98b03cd3dd237eabed44"

    assert :ok == CreatePaymentService.create(tx_hash)
  end

  test "receive payment - with valid hash string but an invalid tx_hash" do
    tx_hash = "0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7909"

    assert {:error, :transaction_not_found} == CreatePaymentService.create(tx_hash)
  end

  test "receive payment - with an invalid hash string" do
    tx_hash = "0x7b6d0e8d812873260291c3f8"

    assert {:error, :invalid_tx_hash} == CreatePaymentService.create(tx_hash)
  end
end
