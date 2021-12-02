defmodule CryptoPayments.HttpClient do
  require Logger
  alias Finch.Response

  def get(url) do
    :get
    |> Finch.build(url)
    |> Finch.request(EtherscanApi)
    |> handle_response()
  end

  def handle_response({:ok, %Response{body: body}}) do
    body
    |> decode_json_body()
  end

  @spec decode_json_body(binary | {:error, any} | {:ok, any}) :: any
  def decode_json_body(body) when is_binary(body), do: Jason.decode(body) |> decode_json_body()
  def decode_json_body({:ok, json_map}), do: {:ok, json_map}

  def decode_json_body({:error, error}) do
    Logger.error("#{__MODULE__}.decode_json_body/1 error = #{inspect(error)}")
    {:error, :invalid_response}
  end
end
