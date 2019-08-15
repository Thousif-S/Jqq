defmodule Jqq.Work.Job do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "jobs" do
    field :title, :string
    field :slug, :string
    field :category, :string
    field :description, :string
    field :image, :string
    field :salary, :string
    field :prerequisites, :string
    # field :type, :string, default: "job"
    field :about_us, :string
    field :taking_applicants_till, :date
    field :location, :string

    has_many :reviews, Jqq.Work.Review
    belongs_to :company, Jqq.Accounts.Company

    timestamps()
  end

  def changeset(job, attrs) do
    required_fields = [:title, :description, :category, :about_us, :slug]
    optional_fields = [:image, :salary, :prerequisites, :taking_applicants_till]

    job
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> unique_constraint(:slug)
  end
end
