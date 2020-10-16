defmodule EstateWeb.DashboardController do
  use EstateWeb, :controller

  def show(conn, _) do
    render conn, "show.html"
  end
end
