defmodule Jqq.Work do
  import Ecto.Query, warn: false
  alias Jqq.Repo

  alias Jqq.Work.{Job, Review, Apply, Category, Tag}
  alias Jqq.Accounts.User

  def get_job_by_slug!(slug) do
    Repo.get_by!(Job, slug: slug)
  end

  def list_jobs do
    Repo.all(Job)
  end

  def list_jobs(criteria) do
    query = from(j in Job)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from j in query, limit: ^limit

      {:filter, filters}, query ->
        filter_with(filters, query)

      {:order, order}, query ->
        from j in query, order_by: [{^order, :id}]
    end)
    |> IO.inspect()
    |> Repo.all()
  end

  defp filter_with(filters, query) do
    Enum.reduce(filters, query, fn
      {:matching, term}, query ->
        pattern = "%#{term}%"

        from q in query,
          where:
            ilike(q.title, ^pattern) or
              ilike(q.description, ^pattern) or
              ilike(q.prerequisites, ^pattern) or
              ilike(q.location, ^pattern) or
              ilike(q.category, ^pattern)
    end)
  end

  def create_job(attrs) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  def update_job(%Job{} = job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  def delete_job(%Job{} = job) do
    Repo.delete(job)
  end

  def create_tags(attrs) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  def create_categories(attrs) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def get_applicants do
    Repo.all(Apply)
  end

  def create_applicant(%User{} = user, attrs) do
    %Apply{}
    |> Apply.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def cancel_applicant(%Apply{} = apply) do
    apply
    |> Apply.cancel_changeset(%{state: "cancelled"})
    |> Repo.update()
  end

  def create_review(%User{} = user, attrs) do
    %Review{}
    |> Review.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Apply, %{limit: limit, scope: :job}) do
    Apply
    |> where(state: "applied")
    |> order_by(asc: :id)
    |> limit(^limit)
  end

  def query(Apply, %{scope: :user}) do
    Apply
    |> order_by(asc: :id)
  end

  def query(queryable, _) do
    queryable
  end
end
