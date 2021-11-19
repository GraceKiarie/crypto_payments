defmodule CryptoPayments.Utils.HttpHelpers do
  require Logger
  alias Finch.Response

  def build_json_body(map) when is_map(map) do
    case Jason.encode(map) do
      {:ok, json_body} ->
        json_body

      error ->
        Logger.error("#{__MODULE__}.build_json_body/1 error = #{inspect(error)}")
        :invalid_body
    end
  end

  @spec decode_json_body(binary | {:error, any} | {:ok, any}) :: any
  def decode_json_body(body) when is_binary(body), do: Jason.decode(body) |> decode_json_body()
  def decode_json_body({:ok, json_map}), do: json_map
  def decode_json_body({:error, error}), do: IO.inspect(error, label: "decode_json_body/1 error")

  def handle_response({:ok, %Response{body: body}}) do
    decoded_json_body =
      body
      |> decode_json_body()

    {:ok, decoded_json_body}
  end
end
