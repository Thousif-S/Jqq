defmodule JqqWeb.Plugs.SetCurrentUser do
  @behaviour Plug
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["TiTe " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{id: id}} <- JqqWeb.AuthToken.verify(token),
         %{} = user <- Jqq.Accounts.get_user(id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
