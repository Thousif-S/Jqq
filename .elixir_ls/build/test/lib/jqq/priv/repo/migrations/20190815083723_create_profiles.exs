defmodule Jqq.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :string, null: false
      add :last_name, :string, null: true
      add :profile_pic, :string, null: true
      add :age, :integer, null: false
      add :short_bio, :string, null: true
      add :user_id, references(:users), null: false

      timestamps()
    end

    create index(:profiles, [:user_id])
  end
end
