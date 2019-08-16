defmodule Jqq.Repo.Migrations.CreateApplicants do
  use Ecto.Migration

  def change do
    create table(:applies) do
      add :short_intro, :string, null: false
      add :state, :string, null: false
      add :job_id, references(:jobs), null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

    create index(:applies, [:job_id, :user_id])
  end
end
