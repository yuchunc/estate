defmodule Estate.LVRDatum.BuildingPlan do
  use Estate, :schema

  @primary_key false
  embedded_schema do
    field :bedrooms, :integer
    field :halls, :integer
    field :bathrooms, :integer
    field :compartment, :string
  end

  def changeset(bplan, attrs) do
    bplan
    |> cast(attrs, [:bedrooms, :halls, :bathrooms, :compartment])
  end
end
