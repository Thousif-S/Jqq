defmodule Jqq.Repo.Migrations.CreateApplicants do
  use Ecto.Migration

  def change do
    create table(:applies) do
      add :short_note, :string, null: false
      add :
    end

  end
end
