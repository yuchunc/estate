defmodule Estate.Post.Options do
  use Estate, :schema

  embedded_schema do
    field :has_elevator, :boolean
    field :has_parking, :boolean
    field :decorated, :boolean
    field :furished, :boolean
  end
end
