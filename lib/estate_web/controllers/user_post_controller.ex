defmodule EstateWeb.UserPostController do
  use EstateWeb, :controller

  alias Estate.Post

  def index(conn, _) do
    user = current_user(conn)

    posts =
      Post
      |> Post.by_user_query(user)
      |> Post.published_query(NaiveDateTime.utc_now)
      |> Repo.all()

    render(conn, "index.html", posts: posts)
  end

  def new(conn, _) do
    render(conn, "new.html", changeset: Estate.Post.changeset())
  end

  def create(conn, %{"post" => post_params }) do
    user = current_user(conn)

    chgst = %Post{user_id: user.id, published_at: NaiveDateTime.utc_now}
    |> Post.creation_changeset(post_params)

    case Repo.insert(chgst) do
      {:ok, _} -> redirect(conn, to: Routes.user_post_path(conn, :index))
      {:error, chgst} -> render(conn, "new.html", changeset: chgst)
    end
  end
end
