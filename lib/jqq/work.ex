defmodule Jqq.Work do
  import Ecto.Query, warn: false
  alias Jqq.Repo

  alias Jqq.Work.{Job, Review}
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
              ilike(q.location, ^pattern)
    end)
  end
end
