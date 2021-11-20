defmodule CryptoPayments.PaymentsTest do
  use CryptoPayments.DataCase

  alias CryptoPayments.Payments

  describe "payments" do
    alias CryptoPayments.Payments.Payment

    import CryptoPayments.PaymentsFixtures

    @invalid_attrs %{blockHash: nil, blockNumber: nil, transactionHash: nil, value: nil}

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Payments.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Payments.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{blockHash: "some blockHash", blockNumber: 42, transactionHash: "some transactionHash", value: 120.5}

      assert {:ok, %Payment{} = payment} = Payments.create_payment(valid_attrs)
      assert payment.blockHash == "some blockHash"
      assert payment.blockNumber == 42
      assert payment.transactionHash == "some transactionHash"
      assert payment.value == 120.5
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payments.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      update_attrs = %{blockHash: "some updated blockHash", blockNumber: 43, transactionHash: "some updated transactionHash", value: 456.7}

      assert {:ok, %Payment{} = payment} = Payments.update_payment(payment, update_attrs)
      assert payment.blockHash == "some updated blockHash"
      assert payment.blockNumber == 43
      assert payment.transactionHash == "some updated transactionHash"
      assert payment.value == 456.7
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.update_payment(payment, @invalid_attrs)
      assert payment == Payments.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Payments.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Payments.change_payment(payment)
    end
  end
end
