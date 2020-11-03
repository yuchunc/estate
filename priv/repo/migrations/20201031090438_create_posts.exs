defmodule Estate.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :city, :string, null: false
      add :area, :string, null: false
      add :budget, :integer, null: false
      add :house_type, :string, null: false
      add :min_size, :integer
      add :max_size, :integer
      add :room_count, :integer
      add :options, :map

      timestamps()
    end
  end
end
