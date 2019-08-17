defmodule JqqWeb.Resolvers.Accounts do
  alias Jqq.Accounts
  alias JqqWeb.Schema.ChangesetErrors

  def signin(_, %{username: username, password: password}, _) do
    case Accounts.authenticate(username, password) do
      :error ->
        {:error, "Please check your username or password"}

      {:ok, user} ->
        token = JqqWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def signup(_, args, _) do
    case Accounts.create_user(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = JqqWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def me(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end

  def companies(_, args, _) do
    {:ok, Accounts.list_companies(args)}
  end

  def company(_, %{slug: slug}, _) do
    {:ok, Accounts.get_company_by_slug!(slug)}
  end
end
