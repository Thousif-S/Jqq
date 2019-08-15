defmodule Jqq.Work.Category do
    use Ecto.Schema
    import Ecto.Changeset
    alias Jqq.Work.Category

    schema "categories" do
        field :name, :string, null: false
        field :description, :string

        has_many :jobs, Jqq.Work.Job

        timestamps()
    end

    def changeset(%Category{} = category, attrs) do
        category
        |> cast(attrs, [:description, :name])
        |> validate_required([:name])
    end
end