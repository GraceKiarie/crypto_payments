defmodule CryptoPaymentsWeb.PageControllerTest do
  use CryptoPaymentsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Crypto Payments"
  end
end
