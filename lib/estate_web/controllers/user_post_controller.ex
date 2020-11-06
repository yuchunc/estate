defmodule EstateWeb.UserPostController do
  use EstateWeb, :controller

  alias Estate.Post

  def index(conn, _) do
    user = current_user(conn)
    utc_now = NaiveDateTime.utc_now()

    posts =
      Post
      |> Post.by_user_query(user)
      |> Post.published_query(utc_now)
      |> Repo.all()

    past_posts =
      Post
      |> Post.by_user_query(user)
      |> Post.expired_query(utc_now)
      |> Repo.all()

    render(conn, "index.html", posts: posts, past_posts: past_posts)
  end

  def new(conn, _) do
    render(conn, "new.html", changeset: Estate.Post.changeset())
  end

  def create(conn, %{"post" => post_params}) do
    user = current_user(conn)
    utc_now = NaiveDateTime.utc_now()
    utc_expired_at = Timex.shift(utc_now, days: 90)

    chgst =
      %Post{user_id: user.id, published_at: NaiveDateTime.utc_now()}
      |> Post.creation_changeset(post_params)

    case Repo.insert(chgst) do
      {:ok, _} -> redirect(conn, to: Routes.user_post_path(conn, :index))
      {:error, chgst} -> render(conn, "new.html", changeset: chgst)
    end
  end
end
