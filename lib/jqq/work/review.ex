defmodule Jqq.Work.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :rating, :integer
    field :comment, :string

    belongs_to :job, Jqq.Work.Job

    timestamps(type: :utc_datetime)
  end

  def changeset(review, attrs) do
    required_fields = [:comment, :job_id]
    optional_fields = [:rating]
    
    review
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> assoc_constraint(:place)
    # |> assoc_constraint(:user)
  end
end
