defmodule CryptoPayments.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :transactionHash, :string
      add :blockNumber, :integer
      add :blockHash, :string
      add :value, :float
      add :confirmed_status, :boolean, default: false

      timestamps()
    end
  end
end
