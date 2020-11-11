defmodule Estate.LVRDatum.BuildingPlan do
  use Estate, :schema

  @primary_key false
  embedded_schema do
    field :bedrooms, :integer
    field :living_rooms, :integer
    field :lavatories, :integer
  end

  def changeset(bplan, attrs) do
    bplan
    |> cast(attrs, [:bedrooms, :living_rooms, :lavatories])
  end
end
