# CryptoPayments

Integration:
  Integrated with Etherscan API using Finch
 
Receive Payments:
  * I utilized phoenix inbuilt live view to allow a use submit a tx_hash via a /payments. The submitted has is used to query transaction details using [eth_getTransactionByHash](https://docs.etherscan.io/api-endpoints/geth-parity-proxy#eth_gettransactionbyhash). If the transaction exist, the details are saved in the payments table.



Payment confirmation - i have implemented two genservers:
   * Genserver CurrentBlock keeps track of the most_recent_bock by calling the [eth_blockNumber endpoint] (https://docs.etherscan.io/api-endpoints/geth-parity-proxy#eth_blocknumber) every 5seconds . This block is converted to int for easier manipulation.
   * Genserver ConfirmPayments calls the CurrentBlock to get the state and updates payments that have more than 2 block confirmations by changing field confirmed_status to true marking the payment ascomplete on the /records page. Runs every 10 seconds


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

