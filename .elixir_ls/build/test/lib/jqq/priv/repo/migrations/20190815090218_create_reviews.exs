defmodule Jqq.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :rating, :integer, null: true
      add :comment, :string, null: false
      add :user_id, references(:users), null: false
      add :company_id, references(:companies), null: true

      timestamps()
    end

    create index(:reviews, [:user_id])
    create index(:reviews, [:company_id])
  end
end
