defmodule EstateWeb.UserPostController do
  use EstateWeb, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end
end
