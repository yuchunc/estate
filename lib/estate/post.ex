defmodule Estate.Post do
  use Estate, :schema

  schema "posts" do
    field :city, :string
    field :area, :string
    field :bid, :integer
    field :house_type, HouseTypeEnum
    field :size, :integer
    field :room_count, :integer

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
