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

    # State Related Fields
    field :published_at, :naive_datetime_usec
    field :expired_at, :naive_datetime_usec
    field :archived_at, :naive_datetime_usec

    belongs_to :user, Estate.Account.User, type: :binary_id

    timestamps()
  end

  def by_user_query(query, %{id: user_id}) do
    query
    |> where(user_id: ^user_id)
  end

  def published_query(query, utc_dt) do
    query
    |> where([p], is_nil(p.archived_at))
    |> where([p], p.published_at < ^utc_dt)
  end

  @doc false
  def changeset do
    change(%__MODULE__{})
  end

  def creation_changeset(post, attrs) do
    post
    |> cast(attrs, [:county, :area, :budget, :house_type, :min_size, :max_size, :room_count])
    |> cast_embed(:options)
    |> validate_required([:county, :area, :budget, :house_type])
    |> validate_max_min
  end

  defp validate_max_min(changeset) do
    min_size = get_field(changeset, :min_size)
    max_size = get_field(changeset, :max_size)

    cond do
      is_nil(min_size) or is_nil(max_size) -> changeset
      max_size < min_size -> add_error(changeset, :max_size, "max_size less than min_size")
      true -> changeset
    end
  end
end
