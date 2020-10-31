defmodule Estate.Post do
  use Ecto.Schema
  import Ecto.Changeset

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
