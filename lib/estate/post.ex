defmodule Estate.Post do
  use Estate, :schema

  alias Estate.Post

  schema "posts" do
    field :county, :string
    field :area, :string
    field :budget, :integer
    field :house_type, HouseTypeEnum
    field :min_size, :integer
    field :max_size, :integer
    field :room_count, :integer
    embeds_one :options, Post.Options

    field :published_at, :naive_datetime
    field :expired_at, :naive_datetime
    field :archived_at, :naive_datetime

    belongs_to :user, Estate.Account.User, type: :binary_id

    timestamps()
  end

  def by_user_query(query, %{id: user_id}) do
    query
    |> where(user_id: ^user_id)
  end

  @doc false
  def changeset do
    change(%__MODULE__{})
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
