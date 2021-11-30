defmodule CryptoPayments.EtherscanApiTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Finch
  alias CryptoPayments.EtherscanAPI

  setup_all do
    # start the http client
    Finch.start_link(name: EtherscanAPi)
    :ok
  end

  test "get transaction details with a valid hash" do
    use_cassette "transaction_details" do
      tx_hash = "0xbc78ab8a9e9a0bca7d0321a27b2c03addeae08ba81ea98b03cd3dd237eabed44"
      {:ok, response} = EtherscanAPI.transaction_details(tx_hash)

      assert response["result"]["hash"] == tx_hash
    end
  end

  test "get transaction details with an invalid hash" do
    use_cassette "invalid_tx_hash" do
      tx_hash = "Ochsdkhchccnvvjkcj"

      assert {:ok,
              %{
                "error" => %{
                  "code" => _code,
                  "message" => _message
                }
              }} = EtherscanAPI.transaction_details(tx_hash)
    end
  end
end
