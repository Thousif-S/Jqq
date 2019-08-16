defmodule Jqq.QuestBoard.Quest do
    use Ecto.Schema
    import Ecto.Changeset

    schema "quests" do
        field :title, :string
        field :descriptioon, :string
        field :categorry, :string

        belongs_to :user, Jqq.Accounts.User

        # has_many :review, Jqq.Work.Review

        timestamps()
    end
end
