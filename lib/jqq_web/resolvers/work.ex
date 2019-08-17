defmodule JqqWeb.Resolvers.Work do
  alias Jqq.Work
  alias JqqWeb.Schema.ChangesetErrors
  # alias JqqWeb.Schema.ChangesetErrors

  def jobs(_, args, _) do
    {:ok, Work.list_jobs(args)}
  end

  def job(_, %{slug: slug}, _) do
    {:ok, Work.get_job_by_slug!(slug)}
  end

  def tags(_, _, _) do
    {:ok, Work.list_tags()}
  end

  def categories(_, _, _) do
    {:OK, Work.list_categories()}
  end

  def create_applicant(_, args, %{context: %{current_user: user}}) do
    case Work.create_applicant(user, args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not apply", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, apply} ->
        publish_applicant_change(apply)
        {:ok, apply}
    end
  end

  def cancel_applicant(_, args, %{context: %{current_user: user}}) do
    apply = Work.get_applicant!(args[:apply_id])

    if apply.user_id == user.id do
      case Work.cancel_applicant(apply) do
        {:error, changeset} ->
          {
            :error,
            message: "Could ot cancel application",
            details: ChangesetErrors.error_details(changeset)
          }

        {:ok, apply} ->
          publish_applicant_change(apply)
          {:ok, apply}
      end
    else
      {
        :error,
        message: "Hola, Mattteeee, That's not your application"
      }
    end
  end

  def create_review(_, args, %{context: %{current_user: user}}) do
    case Work.create_review(user, args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create review", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, review} ->
        {:ok, review}
    end
  end

  defp publish_applicant_change(apply) do
    Absinthe.Subscription.publish(
      JqqWeb.Endpoint,
      apply,
      applicant_change: apply.place_id
    )
  end
end
