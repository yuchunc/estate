defmodule Estate.LVRDatum.TransactionItinary do
  use Estate, :schema

  @primary_key false
  embedded_schema do
    field :land_count, :integer
    field :building_count, :integer
    field :parking_count, :integer
  end

  def changeset(t_itin, attrs) do
    t_itin
    |> cast(attrs, [:land_count, :building_count, :parking_count])
  end
end
