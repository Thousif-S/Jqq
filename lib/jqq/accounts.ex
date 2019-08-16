defmodule Jqq.Accounts do
  import Ecto.Query, warn: false

  alias Jqq.Repo

  alias Jqq.Accounts.{User, Profile, Company}

  def get_user(id) do
    Repo.get(User, id)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate(username, password) do
    user = Repo.get_by(User, username: username)

    with %{password_hash: password_hash} <- user,
         true <- Pbkdf2.verify_pass(password, password_hash) do
      {:ok, user}
    else
      _ -> :error
    end
  end

  def create_profile(attrs) do
    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

  def update_profile(%Profile{} = profile, attrs) do
    profile
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  def list_users do
    Repo.all(User)
  end

  def get_user_by_username(username) do
    Repo.get_by!(User, username: username)
  end

  def create_company(attrs) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  def list_profiles do
    Repo.all(Profile)
  end

  def get_people_by_name(first_name) do
    Repo.get_by!(Profile, first_name: first_name)
  end

  def list_companies do
    Repo.all(Company)
  end

  def get_company_by_slug!(slug) do
    Repo.get_by!(Company, slug: slug)
  end

  def list_companies(criteria) do
    query = from(c in Company)

    Enum.reduce(criteria, query, fn
      {:limit, limit}, query ->
        from c in query, limit: ^limit

      {:filter, filters}, query ->
        filter_with(filters, query)

      {:order, order}, query ->
        from c in query, order_by: [{^order, :id}]
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
            ilike(q.name, ^pattern) or
              ilike(q.address, ^pattern)
    end)
  end

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
