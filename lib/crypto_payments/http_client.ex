defmodule CryptoPayments.HttpClient do
  require Logger
  import CryptoPayments.Utils.HttpHelpers

  def get(url) do
    :get
    |> Finch.build(url)
    |> Finch.request(EtherscanApi)
    |> handle_response()
  end
end
