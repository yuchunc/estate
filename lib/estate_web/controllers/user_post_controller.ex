defmodule EstateWeb.UserPostController do
  use EstateWeb, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    render(conn, "index.html")
  end
end
