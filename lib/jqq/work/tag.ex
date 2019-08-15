defmodule Jqq.Work.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jqq.Work.Tag

  schema "tags" do
    field :name, :string, null: false

    many_to_many :jobs, Jqq.Work.Job, join_through: "jobs_tagging"
  end

  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
