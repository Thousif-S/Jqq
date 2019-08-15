defmodule Jqq.Accounts.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string
    field :about_us, :string
    field :phone, :string
    field :address, :string
    field :web, :string

    belongs_to :user, Jqq.Accounts.User
    has_many :reviews, Jqq.Work.Review

    timestamps()
  end

  def changeset(company, attrs) do
    required_fields = [:name, :about_us, :address, :user_id]
    optional_fields = [:phone, :web]

    company
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> assoc_constraint(:user)
  end
end
