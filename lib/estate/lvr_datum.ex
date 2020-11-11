defmodule Estate.LVRDatum do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "lvr_data" do
    field :approximate_address, :string
    field :building_complete_date, :date
    field :building_main_material, :string
    field :building_type, :string
    field :city_zone, :string
    field :compartment, :integer
    field :county, :string
    field :district, :string
    field :has_management, :boolean, default: false
    field :main_usage, :string
    field :non_city_use, :string
    field :non_city_zone, :string
    field :note, :string
    field :ntd_per_square_meter, :integer
    field :parking_area, :float
    field :parking_ntd_amount, :integer
    field :parking_type, :string
    field :serial, :string
    field :total_floor, :string
    field :transaction_building_area, :float
    field :transaction_date, :date
    field :transaction_floor, :string
    field :transaction_land_area, :float
    field :transaction_ntd_amount, :integer
    field :subject_type, :string

    embeds_one :building_plan, LVRDatum.BuildingPlan, on_replace: :delete
    embeds_one :transaction_itinary, LVRDatum.TransactionItinary, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(lvr_data, attrs) do
    lvr_data
    |> cast(attrs, [
      :serial,
      :note,
      :county,
      :district,
      :subject_type,
      :address,
      :city_zone,
      :non_city_zone,
      :non_city_use,
      :transaction_floor,
      :transaction_date,
      :transaction_itinary,
      :transaction_land_area,
      :total_floor,
      :building_type,
      :main_usage,
      :building_main_material,
      :building_complete_date,
      :transaction_building_area,
      :has_management,
      :transaction_ntd_amount,
      :ntd_per_square_meter,
      :parking_type,
      :parking_area,
      :parking_ntd_amount
    ])
    |> unique_constraint(:serial)
  end
end
