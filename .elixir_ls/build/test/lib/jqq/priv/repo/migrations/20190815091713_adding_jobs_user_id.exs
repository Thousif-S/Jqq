defmodule Jqq.Repo.Migrations.AddingJobsUserId do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :company_id, references(:companies), null: false
    end

    create index(:jobs, [:company_id])
  end
end
