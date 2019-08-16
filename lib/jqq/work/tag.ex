defmodule Jqq.Work.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jqq.Work.Tag

  schema "tags" do
    field :name, :string, null: false

    belongs_to :job, Jqq.Work.Job
  end

  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :job_id])
    |> cast_assoc(:jobs)
    |> validate_required([:name])
  end
end
