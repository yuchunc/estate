defmodule EstateWeb.PageController do
  use EstateWeb, :controller

  plug :put_layout, "marketing.html"

  def app_landing(conn, _params) do
    render(conn, "app_landing.html")
  end
end
