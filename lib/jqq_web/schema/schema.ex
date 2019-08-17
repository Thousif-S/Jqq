defmodule JqqWeb.Schema.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]
  import_types(Absinthe.Type.Custom)

  alias JqqWeb.Resolvers

  alias Jqq.{Accounts, Work}

  query do
    @desc "Get a list of jobs"

    field :jobs, list_of(:job) do
      arg(:filter, :job_filter)
      arg(:limit, :integer)
      args(:order, type: :sort_order, default_values: :asc)
      resolve(&Resolvers.Work.jobs/3)
    end

    @desc "Get a job by its slug"
    field :job, :job do
      arg(:slug, non_null(:string))
      resolve(&Resolvers.Work.job/3)
    end

    @desc "Get a list of categories"
    field :companies, list_of(:company) do
      arg(:filter, :company_filter)
      arg(:limit, :integer)
      args(:order, type: :sort_order, default_values: :asc)
      resolve(&Resolvers.Accounts.companies/3)
    end

    @desc "Get a company by its slug"
    field :company, list_of(:company) do
      arg(:slug, non_null(:string))
      resolve(&Resolvers.Accounts.company/3)
    end

    @desc "Get a list of categories"
    field :category, list_of(:category) do
      resolve(&Resolvers.Work.categories/3)
    end

    @desc "Get a list of tags"
    field :tag, list_of(:tag) do
      resolve(&Resolvers.Work.tags/3)
    end

    @desc "Get currently signed-in user"
    field :me, :user do
      resolve(&Resolvers.Accounts.me/3)
    end
  end

  ######## Object of work

  object :job do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :slug, non_null(:string)
    field :description, non_null(:string)
    field :image, :string
    field :salary, :string
    field :prerequisites, non_null(:string)
    field :about_us, non_null(:string)
    field :takingg_applicants_till, :date
    field :location, :string

    field :applies, list_of(:apply) do
      arg(:limit, type: :integer, default_value: 100)
      resolve(dataloader(Work, :applies, args: %{scope: :job}))
    end

    field :company, :company, resolve: dataloader(Work)
    field :category_id, :category, resolve: dataloader(Work)
    field :tag_name, list_of(:tag), resolve: dataloader(Work)
    # Add Relation
  end

  # field :bookings, list_of(:booking) do
  #   arg :limit, type: :integer, default_value: 100
  #   resolve dataloader(Vacation, :bookings, args: %{scope: :place})
  # end

  object :review do
    field :id, non_null(:id)
    field :rating, :integer
    field :comment, :string
    field :inserted_at, :datetime
    field :user, non_null(:user), resolve: dataloader(Work)
    field :company, non_null(:company), resolve: dataloader(Work)

    # Add relation
  end

  object :category do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string

    field :jobs, list_of(:job) do
      arg(:limit, type: :integer, default_value: 100)
      resolve(dataloader(Work, :jobs, args: %{scope: :category}))
    end
  end

  object :tag do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :job, non_null(:job), resolve: dataloader(Work)
    # TODO _add relation
  end

  object :apply do
    field :id, non_null(:id)
    field :short_note, :string
    field :state, non_null(:string)
    field :inserted_at, :datetime
    field :job, non_null(:job), resolve: dataloader(Work)
    field :user, non_null(:user), resolve: dataloader(Work)
    ## Add relations
  end

  ###### Object of Acounts

  object :user do
    # field :id, non_null(:id)
    field :username, non_null(:string)
    field :email, non_null(:string)
  end

  object :profile do
    field :first_name, non_null(:string)
    field :last_name, :string
    field :profile_pic, :string
    field :age, :string
    field :short_bio, :string
    field :user_id, non_null(:user), resolve: dataloader(Accounts)
  end

  object :company do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :slug, non_null(:string)
    field :about_us, :string
    field :phone, :string
    field :address, :string
    field :web, :string
    field :user_id, non_null(:user), resolve: dataloader(Accounts)
    # Add relations
  end

  ####### Filters input_objects

  @desc "Filters for the list of jobs"
  input_object :job_filter do
    @desc "Matching a name, location, or description"

    field :matching, :string
  end

  @desc "Filters for the list of companies"
  input_object :company_filter do
    @desc "Matching a name, address"

    field :matching, :string
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end
end
