defmodule Estate.Post do
  use Estate, :schema

  schema "posts" do
    field :city, :string
    field :area, :string
    field :budget, :integer
    field :house_type, HouseTypeEnum
    field :min_size, :integer
    field :max_size, :integer
    field :room_count, :integer

    timestamps()
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
