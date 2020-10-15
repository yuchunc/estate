defmodule EstateWeb.PageController do
  use EstateWeb, :controller

  plug :put_layout, "marketing.html"

  def landing(conn, _params) do
    render(conn, "landing.html")
  end
end
