defmodule Jqq.Repo.Migrations.AddingCategoriesTags do
  use Ecto.Migration

  def change do
    create table(:jobs_tagging, primary_key: false) do
      add :job_id, references(:jobs), null: false
      add :tag_id, references(:tags), null: false
    end

    alter table(:jobs) do
      add :category_id, references(:categories), null: false
      add :tag_name, references(:tags), null: true
    end
  end
end
