defmodule Jqq.Repo.Migrations.AddingJobsLocation do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :location, :string, null: false
    end
  end
end
