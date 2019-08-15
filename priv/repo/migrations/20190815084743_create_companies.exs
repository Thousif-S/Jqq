defmodule Jqq.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string, null: false
      add :about_us, :string, null: false
      add :phone, :string, null: true
      add :address, :string, null: false
      add :web, :string, null: true
      add :user_id, references(:users), null: false

      timestamps()
    end

    create unique_index(:companies, [:user_id])

  end
end
