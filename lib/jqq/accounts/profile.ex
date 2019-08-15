defmodule Jqq.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :profile_pic, :string
    field :age, :integer
    field :short_bio, :string

    belongs_to :user, Jqq.Accounts.User

    timestamps()
  end

  def changeset(profile, attrs) do
    required_fields = [:first_name, :age, :user_id]
    optional_fields = [:last_name, :profile_pic, :short_bio]

    profile
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
