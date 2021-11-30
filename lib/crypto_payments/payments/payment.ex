defmodule CryptoPayments.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  @minimum_block_confirmations_before_completion 2

  schema "payments" do
    field :blockHash, :string
    field :blockNumber, :integer
    field :transactionHash, :string
    field :value, :float
    field :confirmed_status, :boolean , default: false

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:transactionHash, :blockNumber, :blockHash, :value, :confirmed_status])
    |> validate_required([:transactionHash, :blockNumber, :blockHash, :value])
  end

  def minimum_block_confirmations_before_completion,
    do: @minimum_block_confirmations_before_completion
end
