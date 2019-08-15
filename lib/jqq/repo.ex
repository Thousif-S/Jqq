defmodule Jqq.Repo do
  use Ecto.Repo,
    otp_app: :jqq,
    adapter: Ecto.Adapters.Postgres
end
