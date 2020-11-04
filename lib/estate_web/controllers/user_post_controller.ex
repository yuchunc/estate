defmodule EstateWeb.UserPostController do
  use EstateWeb, :controller

  def index(conn, _) do
    render(conn, "index.html")
  end

  def new(conn, _) do
    render(conn, "new.html", changeset: Estate.Post.changeset)
  end

  def create(conn, params) do
    IO.inspect(label: "ok")
    render(conn, "index.html")
  end
end
