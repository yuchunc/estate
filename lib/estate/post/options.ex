defmodule Estate.Post.Options do
  use Estate, :schema

  @primary_key false
  embedded_schema do
    field :has_elevator, :boolean
    field :has_parking, :boolean
    field :decorated, :boolean
    field :furnished, :boolean
  end

  def changeset(option, attrs) do
    option
    |> cast(attrs, [:has_elevator, :has_parking, :decorated, :furnished])
  end
end
