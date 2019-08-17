defmodule JqqWeb.Resolvers.Work do
  alias Jqq.Work
  # alias JqqWeb.Schema.ChangesetErrors

  def jobs(_, args, _) do
    {:ok, Work.list_jobs(args)}
  end

  def job(_, %{slug: slug}, _) do
    {:ok, Work.get_job_by_slug!(slug)}
  end

  def tags(_, _, _) do
      {:ok, Work.list_tags}
  end 

  def categories(_,_,_) do
      {:OK, Work.list_categories}
  end
end
