defmodule EstateWeb.PageController do
  use EstateWeb, :controller

  alias Estate.Post

  plug :put_layout, "marketing.html"

  def app_landing(conn, _params) do
    posts = Post
    |> Post.published_query(NaiveDateTime.utc_now)
    |> order_by(:published_at)
    |> limit(8)
    |> Repo.all
    |> List.first
    |> List.duplicate(7)

    render(conn, "app_landing.html", posts: posts)
  end
end
