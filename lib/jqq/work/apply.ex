defmodule Jqq.Work.Apply do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "applies" do
    field :short_intro, :string
    field :request, :boolean, default: false

    belongs_to :job, Jqq.Work.Job
    belongs_to :user, Jqq.Accounts.User

    timestamps()
  end

  def changeset(apply, attrs) do
    required_fields = [:short_intro, :request, :job_id, :user_id]

    apply
    |> cast(attrs, required_fields)
    |> assoc_constraint(:job)
    |> assoc_constraint(:user)
  end

  def cancel_changeset(apply, attrs) do
    apply
    |> cast(attrs, [:request])
    |> validate_required([:request])
  end
end
