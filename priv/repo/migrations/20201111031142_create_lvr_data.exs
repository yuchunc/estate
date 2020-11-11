defmodule Estate.Repo.Migrations.CreateLVRData do
  use Ecto.Migration

  def change do
    create table(:lvr_data) do
      add :serial, :string, null: false
      add :note, :text
      add :county, :string, null: false
      add :district, :string, null: false
      add :subject_type, :string, null: false
      add :approximate_address, :string, null: false
      add :transaction_land_area, :float, null: false
      add :city_zone, :string
      add :urban_zone, :string
      add :urban_usage, :string
      add :transaction_date, :date
      add :transaction_floor, :string
      add :total_floor, :string
      add :building_type, :string
      add :main_usage, :string
      add :building_main_material, :string
      add :building_complete_date, :date
      add :transaction_building_area, :float
      add :has_management, :boolean, default: false, null: false
      add :transaction_ntd_amount, :integer
      add :ntd_per_square_meter, :integer
      add :parking_type, :string
      add :parking_area, :float
      add :parking_ntd_amount, :integer

      add :building_plan, :map
      add :transaction_itinary, :map

      timestamps()
    end

    create unique_index(:lvr_data, [:serial])
  end
end
