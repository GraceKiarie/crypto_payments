# CryptoPayments

Integration:
  Integrated with Etherscan API using Finch
 
Receive Payments:
  * Utilized phoenix inbuilt live view to allow a use submit a tx_hash via "/" route. The submitted has is used to query transaction details using [eth_getTransactionByHash](https://docs.etherscan.io/api-endpoints/geth-parity-proxy#eth_gettransactionbyhash). If the transaction exist, the details are saved in the payments table.



Payment confirmation - implements two genservers:
   * Genserver CurrentBlock keeps track of the most_recent_bock by calling the [eth_blockNumber endpoint](https://docs.etherscan.io/api-endpoints/geth-parity-proxy#eth_blocknumber) every 5seconds . This block is converted to an int for easier manipulation.
   * Genserver ConfirmPayments calls the CurrentBlock to get the state and updates payments that have more than 2 block confirmations by changing field confirmed_status to true, marking the payment as complete on the  "/records" page. Runs every 10 seconds

Tests:
Use of [exvcr](https://github.com/parroty/exvcr) cassettes

Possible Design issues:
 The system has one worker that checks every 10seconds to see if there are pending confirmations that can be update given the latest block number.If confirmations have to happen immediately then the alternative would be to spawn every payment submission as a different process and subscribe it to topic so that it can get broadcasted messages from the CurrentBlock server immediately a change occurs
 




To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

