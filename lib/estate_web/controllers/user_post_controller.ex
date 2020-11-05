defmodule EstateWeb.UserPostController do
  use EstateWeb, :controller

  alias Estate.Post

  def index(conn, _) do
    user = current_user(conn)

    posts =
      Post
      |> Post.by_user_query(user)
      |> Repo.all()

    render(conn, "index.html", posts: posts)
  end

  def new(conn, _) do
    render(conn, "new.html", changeset: Estate.Post.changeset())
  end

  def create(conn, params) do
    render(conn, "index.html")
  end
end
