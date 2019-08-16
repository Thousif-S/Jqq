defmodule Jqq.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :description, :string, null: false
      add :image, :string, null: true
      add :salary, :string, null: true
      add :prerequisities, :string, null: true
      add :about_us, :string, null: true
      add :taking_applicants_till, :string, null: true
      # add :user_id, references(:users), null: false

      timestamps()
    end

    create unique_index(:jobs, [:slug])
    # create index(:jobs, [:user_id])
  end
end
