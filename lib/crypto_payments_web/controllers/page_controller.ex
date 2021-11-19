defmodule CryptoPaymentsWeb.PageController do
  use CryptoPaymentsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
