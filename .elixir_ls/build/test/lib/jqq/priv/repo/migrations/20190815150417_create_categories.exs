defmodule Jqq.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end
  end
end
