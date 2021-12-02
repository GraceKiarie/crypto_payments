defmodule CryptoPayments.EtherscanApiTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch
  alias CryptoPayments.EtherscanAPI

  setup_all do
    # start the http client
    Finch.start_link(name: EtherscanApi)
    :ok
  end

  test "get transaction details with a valid hash" do
    use_cassette "transaction_details" do
      tx_hash = "0xbc78ab8a9e9a0bca7d0321a27b2c03addeae08ba81ea98b03cd3dd237eabed44"

      assert {:ok,
              %{
                blockHash: _block_number,
                blockNumber: _block_hash,
                transactionHash: ^tx_hash,
                value: _value
              }} = EtherscanAPI.transaction_details(tx_hash)
    end
  end

  test "get transaction details with an invalid hash" do
    use_cassette "invalid_tx_hash" do
      tx_hash = "Ochsdkhchccnvvjkcj"

      assert {:error, :invalid_tx_hash} = EtherscanAPI.transaction_details(tx_hash)
    end
  end
end
