defmodule Estate.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :city, :string, null: false
      add :area, :string, null: false
      add :bid, :integer, null: false
      add :house_type, :string, null: false
      add :size, :integer, null: false
      add :room_count, :integer, null: false
      add :options, :map

      timestamps()
    end
  end
end
