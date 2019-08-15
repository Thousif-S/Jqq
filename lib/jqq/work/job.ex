defmodule Jqq.Work.Job do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "jobs" do
    field :title, :string
    field :slug, :string
    field :description, :string
    field :image, :string
    field :salary, :string
    field :prerequisites, :string
    # field :type, :string, default: "job"
    field :about_us, :string
    field :taking_applicants_till, :date
    field :location, :string

    has_many :applies, Jqq.Work.Apply
    belongs_to :company, Jqq.Accounts.Company

    belongs_to :category, Jqq.Work.Category

    many_to_many :tags, Jqq.Work.Tag, join_through: "jobs_tagging"

    timestamps()
  end

  def changeset(job, attrs) do
    required_fields = [
      :title,
      :description,
      :about_us,
      :slug,
      :company_id,
      :category_id
    ]

    optional_fields = [:image, :salary, :prerequisites, :taking_applicants_till]

    job
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> cast_assoc(:tags)
    |> foreign_key_constraint(:category, :company)
    |> unique_constraint(:slug)
  end
end
